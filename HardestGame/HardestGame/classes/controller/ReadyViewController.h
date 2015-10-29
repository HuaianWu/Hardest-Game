//
//  ReadyViewController.h
//  HardestGame
//
//  Created by scsys on 15/10/16.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

//  准备游戏界面

#import <UIKit/UIKit.h>
@class StageModel, ReadyTitleView, ReadyScoreView;

@interface ReadyViewController : UIViewController
// 关卡信息
@property (nonatomic, strong) StageModel *stageModel;
@property (weak, nonatomic) IBOutlet UILabel *stageNo;
@property (weak, nonatomic) IBOutlet UILabel *stageIntro;
@property (weak, nonatomic) IBOutlet UIImageView *stageIcon;
@property (weak, nonatomic) IBOutlet ReadyTitleView *readyTitleView;
@property (weak, nonatomic) IBOutlet ReadyScoreView *readyScoreView;
- (IBAction)back;

- (IBAction)play;
@end

