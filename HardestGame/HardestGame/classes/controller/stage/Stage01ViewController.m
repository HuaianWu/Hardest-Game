//
//  Stage01ViewController.m
//  HardestGame
//
//  Created by scsys on 15/10/17.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "Stage01ViewController.h"
#import "ReadyGoView.h"
#import "IngScoreView.h"
#import "FeetView.h"
#import "FeatherView.h"
#import <QuartzCore/QuartzCore.h>
#import "SoundTool.h"
#import "StageModel.h"
#import "StageRecordModel.h"
#import "PauseViewController.h"
#import "Header.h"
#import "CountScoreViewController.h"


#define kRandomTime (1 +  arc4random_uniform(6)/10.0)


@interface Stage01ViewController ()
{
    CGFloat _leftTime; // 剩下的时间
    
    
    CGFloat _feetRandomLeftTime; // 脚随机出现剩下的时间
    
//    CADisplayLink *_timer;
    
    int _hitCount; // 击中的次数
}

@end

@implementation Stage01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    

}


    
- (NSArray *)guideImageNames
{
    return @[@"guide00.png", @"guide01.png"];
}



#pragma mark 显示miss
- (void)showMissAtButton:(UIButton *)btn
{
    // 1.创建一个miss
    UIImageView *miss = [[UIImageView alloc] init];
    miss.image = [UIImage imageNamed:@"01_miss.png"];
    
    CGFloat missWidth = 50;
    CGFloat missHeight = 19;
    CGFloat missX = CGRectGetMaxX(btn.frame) - missWidth - 10;
    CGFloat missY = _feetView.frame.origin.y + 50;
    
    miss.frame = CGRectMake(missX, missY, missWidth, missHeight);
    
    [self.view addSubview:miss];
    
    // 2.执行动画（平移 + 淡出）
    // 如果动画执行完毕后要用到前面的东西，就用UIView的动画
    [UIView animateWithDuration:1.5 animations:^{
        // 平移
        miss.transform = CGAffineTransformMakeTranslation(0, -200);
        
        // 淡出
        miss.alpha = 0;
    } completion:^(BOOL finished) {
        // 移除miss
        [miss removeFromSuperview];
    }];
    
   
}




#pragma mark 程序进入前台就会调用
- (void)appEnterForeground
{
    [self performSegueWithIdentifier:@"pause" sender:nil];
}




#pragma mark 开始游戏
- (void)beginGame
{
    // 1.计分板倾斜动画
    // 1.计分板
    [_ingScoreView beginWithStageModel:_stageModel];

    
    // 2.ReadyGo
    [_readyGoView beginWithCompletion:^{
        // 2.1.开始计时
        
        //这里加入if判定，是为了防治循环调用_timer，使得刷屏叠加。这样限定之后只有第一次调用创建，之后调用该方法都不会再生成定时器了
//        if (self.timer==nil) {
            self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
            // 一旦添加计时器到Runloop中，就会开始计时（刷帧，1秒大约60次）
            [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//        }
        
        
        // 2.2.开始交互
        self.view.userInteractionEnabled = YES;
    }];
    
    // 3.脚
    [_feetView begin];
    
    // 4.羽毛
    [_featherView begin];
    
    // 5.时间字符串
    _timeLabel.text = @"20.0";
    _leftTime = 20.0;
    _feetRandomLeftTime = kRandomTime;
    _hitCount = 0;
    // 停止上次的计时器
    [self.timer invalidate];

    
    
}

#pragma mark 结束游戏
- (void)endGame
{
    // 1.停止交互
    self.view.userInteractionEnabled = NO;
    
    // 2.停止计时器
    [self.timer invalidate];
    self.timer=nil;
    
    // 3.剩余时间清零
    _leftTime = 0;
    
    // 4.跳到算分界面

    UIStoryboard *story = [self.navigationController storyboard];
//    UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    CountScoreViewController   *CountScore = [story instantiateViewControllerWithIdentifier:@"CountScore"];
    CountScore.model=_stageModel;
    CountScore.scoreNew=_hitCount;
    
    
    [self.navigationController pushViewController:CountScore animated:NO];
    
   


}

#pragma mark 刷帧
- (void)update:(CADisplayLink *)timer
{
    // 减去上次刷帧所耗费的时间
    //timer.duration  为刷屏时间  1／60秒
    _leftTime -= timer.duration;
    
    // 让脚随机出现剩下的时间 减少
    _feetRandomLeftTime -= timer.duration;
    
    // 脚应该随机出现一次
    if (_feetRandomLeftTime <= 0 && _leftTime>=0) {
        // 让脚随机
        [_feetView random];
        
        // 让脚随机出现剩下的时间 重新计时
        _feetRandomLeftTime = kRandomTime;
    }
    
    // 检测时间
    if (_leftTime <= 0) {
        // 停止游戏
        [self endGame];
    }
    
    _timeLabel.text = [NSString stringWithFormat:@"%.1f", _leftTime];
}

#pragma mark 点击了羽毛按钮
- (IBAction)attack:(UIButton *)sender {
    // 1.计算按钮索引
    int index = (sender.frame.origin.x + 10) / sender.frame.size.width;
    
    // 2.让羽毛攻击这个位置
    [_featherView attack:index];
    
    // 3.判断有没有击中脚
    if ([_feetView isGotHit:index]) {
        // 3.1.加分
        _hitCount++;
        // 3.2.设置显示的分数
        [_ingScoreView setScore:_hitCount stageModel:_stageModel];
    } else {
        // 3.1.显示miss
        [self showMissAtButton:sender];
    }
    
    // 4.音效
    [[SoundTool sharedSoundTool] playSound:kSoundTap];
    
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
