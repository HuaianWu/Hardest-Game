//
//  BaseStageViewController.m
//  HardestGame
//
//  Created by scsys on 15/10/21.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "BaseStageViewController.h"
#import "StageModel.h"
#import "StageRecordModel.h"
#import "CountScoreView.h"
#import "PauseViewController.h"


@interface BaseStageViewController ()
{
    UIImageView *imageView;
    
}
@end

@implementation BaseStageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // 1.如果没有游戏记录\f等级
    if ([_stageModel.recordModel.rank isEqualToString:@"f"]
        || _stageModel.recordModel.rank == nil) {
        // 显示游戏教程
        imageView = [[UIImageView alloc] init];
        
        NSMutableArray *images = [NSMutableArray array];
        
        for (NSString *imageName in self.guideImageNames) {
            [images addObject:[UIImage imageNamed:imageName]];
        }
        
        imageView.animationImages = images;
        imageView.frame = [UIScreen mainScreen].bounds;
        imageView.animationDuration = 0.15 * images.count;
        [self.view addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guideClick:)]];
        [imageView startAnimating];
    } else { // 如果有游戏记录
        // 开始游戏
        [self beginGame];
    }
    
    // 2.注册程序进入前台的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterForeground) name:@"applicationWillEnterForeground" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginGame) name:@"restartGame" object:nil];
    
    // 3.添加一些公共的UI界面
    UIButton *retry = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [retry addTarget:self action:@selector(beginGame) forControlEvents:UIControlEventTouchUpInside];
    [retry setBackgroundImage:[UIImage imageNamed:@"ing_retry.png"] forState:UIControlStateNormal];
    retry.frame = CGRectMake(263, 43, 114, 40);
    [self.view addSubview:retry];
    
    UIButton *pause = [UIButton buttonWithType:UIButtonTypeCustom];
    [pause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [pause setBackgroundImage:[UIImage imageNamed:@"ing_pause.png"] forState:UIControlStateNormal];
    pause.frame = CGRectMake(263, 91, 114, 40);
    [self.view addSubview:pause];
    
    [self.view bringSubviewToFront:imageView];
}


#pragma mark 暂停
- (void)pause
{
    // 1.跳到storyboard中PauseViewController
    
    // 拿到导航控制器所在的storyboard
    UIStoryboard *story = [self.navigationController storyboard];
    
    PauseViewController *pause = [story instantiateViewControllerWithIdentifier:@"pause"];
    [self.navigationController pushViewController:pause animated:NO];
    
    _timer.paused=YES;
    
    pause.resumeBlock=^{
        _timer.paused=NO;
    };
}


#pragma mark 点击了教程
- (void)guideClick:(UITapGestureRecognizer *)tap
{
    // 1.移除UIImageView
    [tap.view removeFromSuperview];
    
    // 2.开始游戏
    [self beginGame];
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
