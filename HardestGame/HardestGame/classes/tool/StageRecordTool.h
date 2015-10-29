//
//  StageRecordTool.h
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

//  用来存档、读档

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class StageRecordModel;

@interface StageRecordTool : NSObject

singleton_interface(StageRecordTool)

// 读档
- (StageRecordModel *)stageRecordWithNo:(int)no;

// 存档
- (void)saveStageRecord:(StageRecordModel *)record;
@end


