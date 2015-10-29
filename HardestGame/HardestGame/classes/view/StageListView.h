//
//  StageListView.h
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//



#import <UIKit/UIKit.h>
@class StageModel;

@interface StageListView : UIScrollView

@property (nonatomic, assign) int age;
// 要想拥有一个block属性，只能用copy
@property (nonatomic, copy) void (^itemClickBlock)(StageModel *model);

- (void)reloadStageViewAtNo:(int)no;
@end

