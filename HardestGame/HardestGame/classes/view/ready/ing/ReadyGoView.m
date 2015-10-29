//
//  ReadyGoView.m
//  HardestGame
//

#import "ReadyGoView.h"
#import "SoundTool.h"

@implementation ReadyGoView

- (void)beginWithCompletion:(void (^)())completion
{
    // 显示
    self.hidden = NO;
    
    // 播放音频
    [[SoundTool sharedSoundTool] playSound:kSoundReadyGo];
    
    // 执行动画
    // 从屏幕最右边 -> 中间 -> 切换GO -> 屏幕最左边
    self.transform = CGAffineTransformMakeTranslation(320, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
        // 清空transform属性（返回原本位置）
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 屏幕最左边
        [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            // 切换图片为GO
            self.image = [UIImage imageNamed:@"go.png"];
            
            self.transform = CGAffineTransformMakeTranslation(-320, 0);
        } completion:^(BOOL finished) {
            // 隐藏
            self.hidden = YES;
            
            // 执行外面传进来的block
            completion();
        }];
    }];
}

@end
