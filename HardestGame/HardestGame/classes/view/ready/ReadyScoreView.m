//
//  ReadyScoreView.m
//  HardestGame
//
//  Created by scsys on 15/10/16.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "ReadyScoreView.h"
#import "StageModel.h"
#import "StageRecordModel.h"
#import <QuartzCore/QuartzCore.h>
@implementation ReadyScoreView


- (void)setStageModel:(StageModel *)stageModel
{
    _stageModel = stageModel;
    
    // 1.每个积分卡之间的积分间距
    CGFloat margin = (_stageModel.max - _stageModel.min) / 5;
    
    // 2.遍历所有的积分卡标签
    int count = _labels.count;
    for (int i = 0; i<count; i++) {
        // 取出积分卡标签
        UILabel *label = _labels[i];
        
        // 显示积分
        CGFloat score = _stageModel.max - i * margin;
        label.text = [NSString stringWithFormat:_stageModel.format, score];
    }
    
    // 如果没有玩过这个关卡，不显示指示器
    if (!_stageModel.recordModel.rank) {
        _scoreHint.hidden = YES;
        return;
    }
    
    // 4.根据积分计算指示器中点的x位置
    [self setScoreHintCenter:margin];
    
    // 5.执行动画
    [self showAnimation];
}

#pragma mark 执行动画
- (void)showAnimation
{
    // 默认会往下挪200的距离
    self.transform = CGAffineTransformMakeTranslation(0, 200);
    
    [UIView animateWithDuration:0.3 animations:^{
        // 平移动画(CGAffineTransformIdentity 清空所有的属性)
        //从哪移动的还移回哪里
        self.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        // 闪烁
        CAKeyframeAnimation *blink = [CAKeyframeAnimation animationWithKeyPath:@"hidden"];
        blink.values = @[@0, @1, @0];
        blink.repeatCount = 3;
        
        [_scoreHint.layer addAnimation:blink forKey:nil];
    }];
}

#pragma mark 设置指示器的位置
- (void)setScoreHintCenter:(CGFloat)margin
{
    CGPoint center = _scoreHint.center;
    
    // 计算现在积分 和 最差成绩 的差距
    CGFloat delta = _stageModel.recordModel.score - _stageModel.min;
    
    // 计算 每一分 占据 多少宽度
    CGFloat widthPerScore = center.x / (margin * 6);
    
    // 根据 积分差距  和 每分占据的宽度  来计算总宽度差距
    center.x -=  delta * widthPerScore;
    
    
    if (center.x <= 0) {
        center.x = 0;
    }
    
    _scoreHint.center = center;
}

@end
