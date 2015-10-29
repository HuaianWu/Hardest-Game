//
//  SettingViewController.m
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "SettingViewController.h"
#import "SoundTool.h"
#import "Header.h"


@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1.设置背景图片
    [self.view setFullscreenImageName:@"setting_bg.jpg"];
    
    // 2.根据软件参数，设置按钮文字
    int music = [SoundTool sharedSoundTool].musicMuted;
    [_musicBtn setTitle:music?@"音乐 [关]":@"音乐 [开]" forState:UIControlStateNormal];
    
    int sound = [SoundTool sharedSoundTool].soundMuted;
    [_soundBtn setTitle:sound?@"音效 [关]":@"音效 [开]" forState:UIControlStateNormal];
}

- (IBAction)back {
    [[SoundTool sharedSoundTool] playSound:kSoundClick];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark 音乐
- (IBAction)musicSwitch:(UIButton *)sender {
    // 0.取得当前的音乐状态
    int music = [SoundTool sharedSoundTool].musicMuted;
    
    // 1.按钮文字更改
    [sender setTitle:music?@"音乐 [开]":@"音乐 [关]" forState:UIControlStateNormal];
    
    // 2.状态取反
    [SoundTool sharedSoundTool].musicMuted = !music;
    
    // 3.播放点击的音效
    [[SoundTool sharedSoundTool] playSound:kSoundClick];
}

#pragma mark 音效
- (IBAction)soundSwitch:(UIButton *)sender {
    int sound = [SoundTool sharedSoundTool].soundMuted;
    
    // 1.按钮文字更改
    [sender setTitle:sound?@"音效 [开]":@"音效 [关]" forState:UIControlStateNormal];
    
    // 2.状态取反
    [SoundTool sharedSoundTool].soundMuted = !sound;
    
    // 3.播放点击的音效
    [[SoundTool sharedSoundTool] playSound:kSoundClick];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
