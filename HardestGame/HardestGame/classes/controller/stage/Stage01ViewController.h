//
//  Stage01ViewController.h
//  HardestGame
//
//  Created by scsys on 15/10/17.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "BaseStageViewController.h"

@class FeatherView, FeetView, IngScoreView, ReadyGoView, StageModel;

@interface Stage01ViewController : BaseStageViewController
@property (weak, nonatomic) IBOutlet FeetView *feetView;
@property (weak, nonatomic) IBOutlet FeatherView *featherView;
@property (weak, nonatomic) IBOutlet ReadyGoView *readyGoView;
@property (weak, nonatomic) IBOutlet IngScoreView *ingScoreView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
- (IBAction)attack:(UIButton *)sender;
@end



