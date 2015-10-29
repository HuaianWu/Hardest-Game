//
//  StageRecordModel.h
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

//  保存关卡的成绩、积分、状态

#import <Foundation/Foundation.h>

@interface StageRecordModel : NSObject <NSCoding>
// 成绩
@property (nonatomic, assign) double score;

// 等级（A～F、S）
@property (nonatomic, copy) NSString *rank;

// 是否解锁
//getter = isUnlocked  给这个属性生成的get方法改名
@property (nonatomic, assign, getter = isUnlocked) BOOL unlocked;

// 关卡编号
@property (nonatomic, assign) int no;

@end

