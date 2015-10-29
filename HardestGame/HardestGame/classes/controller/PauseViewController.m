//
//  PauseViewController.m
//  HardestGame
//
//  Created by scsys on 15/10/19.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "PauseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Header.h"

@interface PauseViewController ()
{
    NSArray *_imageNames;
    int _currentImageIndex; // 当前显示图片的索引
}
@end

@implementation PauseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置背景
    [self.view setFullscreenImageName:@"pause_bg.jpg"];
    
    // 2.计时器
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(right) userInfo:nil repeats:YES];
    
    // 3.初始化图片数组
    _imageNames = @[@"ad01.png", @"ad02.png", @"ad03.png", @"ad04.png"];
}


- (IBAction)resume {
    [self.navigationController popViewControllerAnimated:NO];
    
    if (_resumeBlock) {
        _resumeBlock();
    }
}

- (IBAction)exit {
    // 回到主界面
    //popToRootViewController   代表回到根控制器，也就是主界面
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark 切换图片
- (void)changeImage
{
    // 1.显示图片
    _imageView.image = [UIImage imageNamed:_imageNames[_currentImageIndex]];
    
    CATransition *anim = [CATransition animation];
    anim.type = @"push";
    anim.subtype = kCATransitionFromRight;
    [_imageView.layer addAnimation:anim forKey:nil];
    
    // 2.控制currentPage
    
    UIImageView *page = (UIImageView *)[self.view viewWithTag:10 + _currentImageIndex];
    _currentPage.center = page.center;
}

#pragma mark 左
- (IBAction)left
{
    // 1.计算索引
    _currentImageIndex--;
    if (_currentImageIndex < 0) {
        _currentImageIndex = _imageNames.count - 1;
    }
    
    // 2.利用转场动画显示图片
    [self changeImage];
}

#pragma mark 右
- (IBAction)right
{
    // 1.计算索引
    _currentImageIndex++;
    if (_currentImageIndex >= _imageNames.count) {
        _currentImageIndex = 0;
    }
    
    // 2.利用转场动画显示图片
    [self changeImage];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
