//
//  MyNavViewController.m
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "MyNavViewController.h"

@interface MyNavViewController ()

@end

@implementation MyNavViewController

#pragma mark 重写push控制器的方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 不需要动画
    [super pushViewController:viewController animated:NO];
}

@end
