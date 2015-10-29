//
//  ReadyViewController.m
//  HardestGame
//
//  Created by scsys on 15/10/16.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "ReadyViewController.h"
#import "StageModel.h"
#import "SoundTool.h"
#import "ReadyTitleView.h"
#import "ReadyScoreView.h"
#import "Stage01ViewController.h"

@implementation ReadyViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置标签数据
    _stageNo.text = [NSString stringWithFormat:@"Stage %d", _stageModel.no];
    //为了换行
    _stageIntro.text = [_stageModel.intro stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    
    // 2.设置图标
    _stageIcon.image = [UIImage imageNamed:_stageModel.icon];
    
    // 3.给titleView传递数据
    _readyTitleView.stageModel = _stageModel;
    _readyTitleView.removeBlock = ^{
        // 4.给计分板传递数据(并且执行动画)
        _readyScoreView.stageModel = _stageModel;
    };
    
}

- (IBAction)play {
    // 跳到对应的关卡控制器
    NSString *className = nil;
    
    if (_stageModel.no < 10) {
        className = [NSString stringWithFormat:@"Stage0%dViewController", _stageModel.no];
    } else {
        className = [NSString stringWithFormat:@"Stage%dViewController", _stageModel.no];
    }
    
    //根据字符串，找同名的类，就可以调用类中的全部属性方法
    Class c = NSClassFromString(className);
    
    // 创建控制器
    BaseStageViewController *vc = [[c alloc] init];
    vc.stageModel = _stageModel;
    [self.navigationController pushViewController:vc animated:NO];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Stage01ViewController *stage = segue.destinationViewController;
    stage.stageModel = _stageModel;
}



- (IBAction)back {
    [[SoundTool sharedSoundTool] playSound:kSoundClick];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
