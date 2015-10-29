//
//  BaseStageViewController.h
//  HardestGame
//
//  Created by scsys on 15/10/21.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import <UIKit/UIKit.h>

@class StageModel;

@interface BaseStageViewController : UIViewController
{
    StageModel *_stageModel;
}
@property (nonatomic, strong) StageModel *stageModel;

/*
 交给子类去实现
 */
// 开始游戏
- (void)beginGame;
// 结束游戏
- (void)endGame;

// 返回教程所需要的图片名称
- (NSArray *)guideImageNames;


@property(nonatomic,strong)CADisplayLink *timer;
@end


