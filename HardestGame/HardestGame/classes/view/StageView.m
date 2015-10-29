//
//  StageView.m
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "StageView.h"
#import "StageModel.h"
#import "StageRecordModel.h"
#import "StageRecordTool.h"
#import "SoundTool.h"
#import <QuartzCore/QuartzCore.h>

@implementation StageView

#pragma mark 实现setStageInfo:方法
#pragma mark 当view是通过xib文件创建完毕的时候，就会调用一次这个方法
- (void)awakeFromNib
{
    // 1.加载序列帧图片
    UIImage *image1 = [UIImage imageNamed:@"select_stage_s01.png"];
    UIImage *image2 = [UIImage imageNamed:@"select_stage_s02.png"];
    UIImage *image3 = [UIImage imageNamed:@"select_stage_s03.png"];
    // 2.设置图片
    _stageBorder.animationImages = @[image1, image2, image3];
    // 3.设置时间
    _stageBorder.animationDuration = 0.3;
}

#pragma mark 实现setStageInfo:方法
- (void)setStageModel:(StageModel *)stageModel
{
    _stageModel = stageModel;
    
    // 1.关卡编号
    [_stageNo setTitle:[NSString stringWithFormat:@"%d", stageModel.no] forState:UIControlStateNormal];
    
    // 2.设置图标
    _stageIcon.image = [UIImage imageNamed:stageModel.icon];
    
    // 3.根据游戏记录更新关卡显示状态
    [self updateStageState];
}

#pragma mark 根据游戏记录更新关卡显示状态
- (void)updateStageState
{
    if (_stageModel.recordModel) {
        // 有关卡记录
        if (_stageModel.recordModel.isUnlocked) {
            // 已经解锁
            [self updateWithUnlocked];
        } else {
            // 即将解锁（执行解锁动画）
            [self updateWithWillUnlocked];
        }
    } else {
        // 没有记录(加锁)
        [self updateWithNoRecord];
    }
}

#pragma mark 已经解锁
- (void)updateWithUnlocked
{
    // 移除：锁、遮盖
    [_stageLock removeFromSuperview];
    [_stageCover removeFromSuperview];
    
    if (_stageModel.recordModel.rank) { // 有玩过
        // 1.显示：等级、阴影
        _stageRank.hidden = NO;
        _stageShadow.hidden = NO;
        
        // 2.移除new
        [_stageNew removeFromSuperview];
        
        // 3.设置等级显示的图片
        NSString *name = [NSString stringWithFormat:@"select_stage_%@.png", _stageModel.recordModel.rank];
        _stageRank.image = [UIImage imageNamed:name];
        
        // 4.判断是否为S
        if ([@"s" isEqualToString:_stageModel.recordModel.rank]) {
            // 播放序列帧图片
            [_stageBorder startAnimating];
        } else {
            _stageBorder.image = [UIImage imageNamed:@"select_stage_normal.png"];
        }
    } else { // 没有玩过
        // 1.边框显示白色
        _stageBorder.image = [UIImage imageNamed:@"select_stage_new.png"];
        
        // 2.显示new
        _stageNew.hidden = NO;
    }
}

#pragma mark 即将解锁（执行解锁动画）
- (void)updateWithWillUnlocked
{
    self.userInteractionEnabled = NO;
    
    // 1.创建动画对象
    CAAnimationGroup *group = [self shakeScaleAnimation];
    
    // 2.设置动画代理
    group.delegate = self;
    
    // 3.执行动画
    [self.layer addAnimation:group forKey:nil];
    
    // 4.播放解锁声音
    [[SoundTool sharedSoundTool] playSound:kSoundUnlock];
    
    // 5.将解锁标记设置为YES
    _stageModel.recordModel.unlocked = YES;
    
    [[StageRecordTool sharedStageRecordTool] saveStageRecord:_stageModel.recordModel];
}

#pragma mark 没有记录(加锁)
- (void)updateWithNoRecord
{
    self.userInteractionEnabled = NO;
}

#pragma mark 返回一个摇摆、伸缩的动画对象
- (CAAnimationGroup *)shakeScaleAnimation
{
    // 1.摇摆
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    CGFloat angle = M_PI_4/4;
    shake.values = @[ @(-angle), @(angle), @(-angle)];
    
    // 2.伸缩
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scale.values = @[@1.2, @1];
    
    // 3.动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[shake, scale];
    
    return group;
}

#pragma mark 监听摇摆、缩放动画
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 1.移除遮盖
    [_stageCover removeFromSuperview];
    
    // 2.让锁掉落
    // 锁最终的Y值 = 屏幕高度 - 关卡的Y
    CGFloat destY = [UIScreen mainScreen].bounds.size.height - self.frame.origin.y;
    CGFloat duration = destY /200;

    [UIView animateWithDuration:duration animations:^{
        CGRect frame = _stageLock.frame;
        frame.origin.y = destY;
        _stageLock.frame = frame;
 
        
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        
        // 3.显示白框
        _stageBorder.image = [UIImage imageNamed:@"select_stage_new.png"];
        
        // 4.显示new（摇摆）
        _stageNew.hidden = NO;
        
        // 5.执行动画组
        CAAnimationGroup *group = [self shakeScaleAnimation];
        [_stageNew.layer addAnimation:group forKey:nil];
        
        // 6.播放音效
        [[SoundTool sharedSoundTool] playSound:kSoundNew];
        
        // 7.移除锁
        [_stageLock removeFromSuperview];
    }];
}



@end
