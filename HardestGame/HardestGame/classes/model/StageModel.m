//
//  Stage.m
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//
#define kIcon @"icon"
#define kMax @"max"
#define kMin @"min"
#define kTitle @"title"
#define kIntro @"intro"

#define kFormat @"format"
#define kUnit @"unit"

#import "StageModel.h"

@implementation StageModel

+ (StageModel *)stageModelWithDict:(NSDictionary *)dict {
    StageModel *stage = [[self alloc] init];
    stage.icon = dict[kIcon];
    stage.max = [dict[kMax] doubleValue];
    stage.min = [dict[kMin] doubleValue];
    stage.title = dict[kTitle];
    stage.intro = dict[kIntro];
    stage.format = dict[kFormat];
    stage.unit = dict[kUnit];
    
    return stage;
}


@end
