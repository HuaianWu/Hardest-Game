//
//  StageView.h
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//


//  一个关卡

#import <UIKit/UIKit.h>

@class StageModel;

@interface StageView : UIView

@property (nonatomic, strong) StageModel *stageModel;
@property (weak, nonatomic) IBOutlet UIButton *stageNo;
@property (weak, nonatomic) IBOutlet UIImageView *stageIcon;
@property (weak, nonatomic) IBOutlet UIView *stageLock;
@property (weak, nonatomic) IBOutlet UIImageView *stageNew;
@property (weak, nonatomic) IBOutlet UIImageView *stageBorder;
@property (weak, nonatomic) IBOutlet UIView *stageCover;
@property (weak, nonatomic) IBOutlet UIImageView *stageRank;
@property (weak, nonatomic) IBOutlet UIImageView *stageShadow;


@end

