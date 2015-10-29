//
//  FailView.m
//  HardestGame
//

#import "FailView.h"
#import "SoundTool.h"
#import "Header.h"

@implementation FailView

- (void)awakeFromNib
{
    // 设置背景
    [self setFullscreenImageName:@"fail_bg.jpg"];
    
    self.frame = [UIScreen mainScreen].bounds;
}

// 开始执行动画
- (void)begin
{
    // 1.默认就让文字、监狱在最上面
    _boyAndWord.transform = CGAffineTransformMakeTranslation(0, -CGRectGetMaxY(_boyAndWord.frame));
    _prison.transform = CGAffineTransformMakeTranslation(0, -CGRectGetMaxY(_prison.frame));
    
    // 2.文字动画
    [UIView animateWithDuration:0.3 animations:^{
        //平移返回原来位置
        _boyAndWord.transform = CGAffineTransformIdentity;
        [[SoundTool sharedSoundTool] playSound:kSoundFailDrop];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _prison.transform = CGAffineTransformIdentity;
            [[SoundTool sharedSoundTool] playSound:kSoundCageDrop];
            [[SoundTool sharedSoundTool] playSound:kSoundFailShout];
        }];
    }];
}

- (IBAction)retry {
    
    // 1.关闭当前控制器
    //nav  抽出window中一系列控制器，选择在最上面的，也就是当前的控制器（分数控制器CountScoreViewController）
    UINavigationController *nav =  (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav popViewControllerAnimated:NO];
    
    // 2.通知关卡界面重新开始游戏
    [[NSNotificationCenter defaultCenter] postNotificationName:@"restartGame" object:nil];
}

- (IBAction)home {
    UINavigationController *nav =  (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav popToRootViewControllerAnimated:NO];
}
@end
