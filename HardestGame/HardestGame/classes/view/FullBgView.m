//
//  FullBgView.m
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "FullBgView.h"
#import "Header.h"

//专门用来全屏显示背景图片

@interface FullBgView()
{
    NSString *_name;
}
@end


@implementation FullBgView

- (void)setFullscreenImageName:(NSString *)name
{
    _name = name;
    
    // 刷新
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // 如果没有名称，直接返回
    if (!_name) return;
    
    // 1.加载图片
    UIImage *image = [UIImage imageNamed:_name];
    
    // 2.裁剪
    
    if (!iPhone5)
    { // 非iPhone5
        CGRect cutFrame = CGRectMake(0, 88, 640, 960);
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, cutFrame);
        image = [UIImage imageWithCGImage:imageRef];
    }
    // 3.绘图
    [image drawInRect:rect];
}


@end
