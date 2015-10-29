//
//  CountScoreViewController.h
//  HardestGame
//
//  Created by scsys on 15/10/20.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

//  计分控制器

#import <UIKit/UIKit.h>

@class StageModel, CountScoreView;

@interface CountScoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *rankLabel;
@property (weak, nonatomic) IBOutlet CountScoreView *countScoreView;
// 传递两个参数：(方法名不能以new、alloc、)新的成绩、StageModel
@property (nonatomic, assign)  double scoreNew;
@property (nonatomic, strong) StageModel *model;


- (IBAction)retry;
- (IBAction)selectOther;
@end

