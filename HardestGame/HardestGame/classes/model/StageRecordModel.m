//
//  StageRecordModel.m
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//


#define KNo @"no"
#define KRank @"rank"
#define KScore @"score"
#define KUnlocked @"unlocked"
#import "StageRecordModel.h"

@implementation StageRecordModel

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.no = [decoder decodeIntForKey:KNo];
        self.rank = [decoder decodeObjectForKey:KRank];
        self.score = [decoder decodeDoubleForKey:KScore];
        self.unlocked = [decoder decodeBoolForKey:KUnlocked];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:self.no forKey:KNo];
    [encoder encodeObject:self.rank forKey:KRank];
    [encoder encodeDouble:self.score forKey:KScore];
    [encoder encodeBool:self.isUnlocked forKey:KUnlocked];
}



@end
