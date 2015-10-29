//
//  StageRecordTool.m
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "StageRecordTool.h"
#import "StageRecordModel.h"

#define kFileName @"records.data"

#define kPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kFileName]

@interface StageRecordTool()
{
    // 所有的关卡记录
    NSMutableDictionary *_allRecords;
}
@end


@implementation StageRecordTool

singleton_implementation(StageRecordTool)

- (id)init
{
    if (self = [super init]) {
        // 1.从文件读取游戏数据
        _allRecords = [NSKeyedUnarchiver unarchiveObjectWithFile:kPath];
        
        // 2.说明没有游戏数据
        if (!_allRecords) {
            _allRecords = [NSMutableDictionary dictionary];
            
            // 添加第一关
            StageRecordModel *model = [[StageRecordModel alloc] init];
            model.no = 1;
            [_allRecords setObject:model forKey:@1];
        }
    }
    return self;
}

#pragma mark 存档
- (void)saveStageRecord:(StageRecordModel *)record
{
    // 1.如果编号不合理，直接返回
    if (record.no <= 0) return;
    
    // 2.覆盖以前的数据\添加新的数据
    [_allRecords setObject:record forKey:@(record.no)];
    
    // 3.归档
    [NSKeyedArchiver archiveRootObject:_allRecords toFile:kPath];
}

#pragma mark 读档
- (StageRecordModel *)stageRecordWithNo:(int)no
{
    return _allRecords[@(no)];
}



@end
