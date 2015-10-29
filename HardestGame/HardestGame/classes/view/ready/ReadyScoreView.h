//
//  ReadyScoreView.h
//  HardestGame
//
//  Created by scsys on 15/10/16.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

//  准备游戏时的计分板

#import <UIKit/UIKit.h>

@class StageModel;

@interface ReadyScoreView : UIView
// 关卡信息
@property (nonatomic, strong) StageModel *stageModel;
@property (nonatomic, weak) IBOutlet UIImageView *scoreHint;
@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *labels;
@end


