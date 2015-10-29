//
//  UIView+Image.h
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Image)

// 设置全屏显示的图片名称
- (void)setFullscreenImageName:(NSString *)name;


// 清除锯齿
- (void)clearAlias;

@end
