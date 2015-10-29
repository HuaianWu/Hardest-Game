//
//  SettingViewController.h
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController

- (IBAction)back;
- (IBAction)musicSwitch:(UIButton *)sender;
- (IBAction)soundSwitch:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *musicBtn;
@property (weak, nonatomic) IBOutlet UIButton *soundBtn;

@end
