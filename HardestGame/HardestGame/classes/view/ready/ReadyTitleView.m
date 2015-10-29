//
//  ReadyTitleView.m
//  HardestGame
//
//  Created by scsys on 15/10/16.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "ReadyTitleView.h"
#import "StageModel.h"
#import "SoundTool.h"
#import <QuartzCore/QuartzCore.h>
#import "Header.h"

@implementation ReadyTitleView


#pragma mark 从storyboard或者xib中创建完毕就会调用
- (void)awakeFromNib
{
    [self setFullscreenImageName:@"select_bg.jpg"];
}

#pragma mark 用来显示Label（执行动画）
- (void)showLabel:(NSTimer *)timer
{
    // 1.取出标签
    UILabel *label = timer.userInfo;
    
    // 2.显示Label
    label.hidden = NO;
    
    // 3.伸缩（宽度从0到1）
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scale.fromValue = @0;
    scale.toValue = @1;
    
    // 4.平移 (先往下挪动一段距离，再往回一小段距离)
    CAKeyframeAnimation *trans = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    trans.values = @[@0, @40, @20];
    
    // 5.添加动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scale, trans];
    [label.layer addAnimation:group forKey:nil];
    
    // 6.播放对应的音效
    [[SoundTool sharedSoundTool] playSound:kSoundDrop(label.tag)];
}

#pragma mark 设置模型数据
- (void)setStageModel:(StageModel *)stageModel
{
    _stageModel = stageModel;
    
    // 0.播放音效
    [[SoundTool sharedSoundTool] playSound:kSoundReady];
    
    // 1.设置关卡编号
    _stageNo.text = [NSString stringWithFormat:@"Stage %d", _stageModel.no];
    
    // 2.设置三个标签
    //根据给的特殊符号将句子裁开
    NSArray *titles = [_stageModel.title componentsSeparatedByString:@"\\n"];
    int count = _labels.count;
    
    CGFloat totalTime = 0;
    
    for (int i = 0; i<count; i++) {
        // 取出标签
        UILabel *label = _labels[i];
        // 设置标签文字
        label.text = titles[i];
        
        // 绑定tag（为了到时播放对应的音效）
        label.tag = i + 1;
        
        // 初始化一个定时器
        CGFloat delay = 0.3 * (i + 1);
        totalTime += delay;
        //延迟0.3秒调用该方法
        [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(showLabel:) userInfo:label repeats:NO];
    }
    
    // 3.初始化一个定时器用来移除当前的view
    [NSTimer scheduledTimerWithTimeInterval:totalTime target:self selector:@selector(remove) userInfo:nil repeats:NO];
}

- (void)remove
{
    // 从父控件中移除
    [self removeFromSuperview];
    
    // 调用block
    if (_removeBlock) {
        _removeBlock();
    }
}


@end
