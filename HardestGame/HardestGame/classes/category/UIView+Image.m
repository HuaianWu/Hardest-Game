//
//  UIView+Image.m
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "UIView+Image.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (Image)

- (void)clearAlias
{
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    // 就会把图层当做是一个bitmap来渲染
    self.layer.shouldRasterize = YES;
    
    //递归
    //让视图内所有视图，比如数字，分数单位也都进行去锯齿
    for (UIView *child in self.subviews) {
        [child clearAlias];
    }
}


@end
