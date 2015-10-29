//
//  IngScoreView.m
//  HardestGame
//

#import "IngScoreView.h"
#import <QuartzCore/QuartzCore.h>
#import "StageModel.h"
#import "Header.h"


@implementation IngScoreView

- (void)awakeFromNib
{
    // 设置锚点（左下角）
    self.layer.anchorPoint = CGPointMake(0, 1);
    
    self.layer.position = CGPointMake(-60, 100);
}

- (void)beginWithStageModel:(StageModel *)model
{
    // 显示
    self.hidden = NO;
    
    self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI_4/7);
    }];
    
    // 积分清零
    [self setScore:0 stageModel:model];
    // #warning
}

- (void)setScore:(double)score stageModel:(StageModel *)model
{
    // 1.设置积分Label
    NSString *format = nil;
    
    //为了修改分数的显示格式
    if (score < 10) {
        format = [NSString stringWithFormat:@"00%@", model.format];
    } else if (score < 100) {
        format = [NSString stringWithFormat:@"0%@", model.format];
    } else {
        format = model.format;
    }
    
    _scoreLabel.text = [NSString stringWithFormat:format, score];
    
    // 2.颤抖动画
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.values = @[@0, @10, @0];
    [self.layer addAnimation:shake forKey:nil];
}




@end
