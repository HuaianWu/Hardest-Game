//
//  HomeViewController.m
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "HomeViewController.h"
#import "SoundTool.h"
#import "Header.h"

@interface HomeViewController ()
{
    CGRect _btnSettingFrame; // 设置按钮的位置尺寸
    CGRect _btnLanguageFrame; // 语言按钮的位置尺寸
    CGRect _btnMoreFrame; // 更多按钮的位置尺寸
    
    CGRect _btnRankFrame; // 排名按钮的位置尺寸
    CGRect _btnPlayFrame; // PLAY按钮的位置尺寸
    CGRect _btnGetFrame; // GET按钮的位置尺寸
}
@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.设置背景图片
    [self.view setFullscreenImageName:@"home_bg.jpg"];
    
    // 设置View背景图片的一种做法   平铺
    // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Icon.png"]];
    
    // 2.加载配置文件home.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"home" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *frames = dict[iPhone5?@"iphone5":@"iphone4"];
    
    // 3.设置各个按钮的framex
    _btnSettingFrame = CGRectFromString(frames[@"btn_setting_frame"]);
    _btnLanguageFrame = CGRectFromString(frames[@"btn_language_frame"]);
    _btnMoreFrame = CGRectFromString(frames[@"btn_more_frame"]);
    
    _btnRankFrame = CGRectFromString(frames[@"btn_rank_frame"]);
    _btnPlayFrame = CGRectFromString(frames[@"btn_play_frame"]);
    _btnGetFrame = CGRectFromString(frames[@"btn_get_frame"]);
}


#pragma mark 监听View的点击
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.取得触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point =  [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_btnSettingFrame, point)) {
        // MyLog(@"点击了设置");
        
        [[SoundTool sharedSoundTool] playSound:kSoundClick];
        
        // 跳到设置界面
        //将跳转加到控制器上，利用控制器找到跳转的线的名字，想设置控制器跳转就可以利用这个方法
        [self performSegueWithIdentifier:@"setting" sender:nil];
        
    } else if (CGRectContainsPoint(_btnPlayFrame, point)) {
        
        [[SoundTool sharedSoundTool] playSound:kSoundClick];
        
        // 跳到选择关卡界面
        [self performSegueWithIdentifier:@"stages" sender:nil];

    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
