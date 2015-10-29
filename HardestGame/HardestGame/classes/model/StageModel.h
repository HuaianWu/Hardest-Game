//
//  Stage.h
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import <Foundation/Foundation.h>

@class StageRecordModel;
@interface StageModel : NSObject


@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *intro;

@property (nonatomic, assign) double max;
@property (nonatomic, assign) double min;

// 编号
@property (nonatomic, assign) int no;

@property (nonatomic, strong) StageRecordModel *recordModel;


@property (nonatomic, copy) NSString *format; // 格式
@property (nonatomic, copy) NSString *unit; // 单位

+ (StageModel *)stageModelWithDict:(NSDictionary *)dict;


@end
