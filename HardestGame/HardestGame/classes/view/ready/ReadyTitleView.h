//
//  ReadyTitleView.h
//  HardestGame
//
//  Created by scsys on 15/10/16.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

//  显示关卡的标题

#import "FullBgView.h"

@class StageModel;

@interface ReadyTitleView : FullBgView

@property (nonatomic, copy) void (^removeBlock)();

// 关卡信息
@property (nonatomic, strong) StageModel *stageModel;

@property (nonatomic, weak) IBOutlet UILabel *stageNo;

// IBOutletCollection一定要用strong
@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *labels;
@end

