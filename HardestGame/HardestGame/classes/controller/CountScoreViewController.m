//
//  CountScoreViewController.m
//  HardestGame
//
//  Created by scsys on 15/10/20.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "CountScoreViewController.h"
#import "CountScoreView.h"
#import "StageModel.h"
#import "StageRecordTool.h"
#import "StageRecordModel.h"
#import "SoundTool.h"
#import "FailView.h"
#import "Header.h"
#import "RecordNewView.h"
#import "StagesViewController.h"


@interface CountScoreViewController ()

@end

@implementation CountScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1.设置背景
    [self.view setFullscreenImageName:@"rank_bg.jpg"];
    
    // 2.算分
    [_countScoreView countScoreWithNewScore:_scoreNew model:_model];
    // 设置积分改变的block
    _countScoreView.rankChange = ^(NSString *rank){
        _rankLabel.image = [UIImage imageNamed:[NSString stringWithFormat:@"score_%@.png", rank]];
    };
    
    // 3.设置显示结果的block
    _countScoreView.showResult = ^(NSString *rank){
        // 1.什么时候需要保存游戏数据
        BOOL betterScore = ((_model.max > _model.min) && (_scoreNew > _model.recordModel.score))
        || ((_model.max < _model.min) && (_scoreNew < _model.recordModel.score));
        
        // 需要保存数据 ：1> 第一次玩  2> 成绩比上次好
        BOOL needSaveData = _model.recordModel.rank == nil || betterScore;
        
        // 2.保存数据
        if (needSaveData) {
            [self saveData:rank];
        }
        
        // 3.显示结果（界面效果）
        [self showResultEffect:rank needSaveData:needSaveData];
    };

        
//        if ([rank isEqualToString:@"f"]) { // 失败
//            FailView *failView =  [[NSBundle mainBundle] loadNibNamed:@"FailView" owner:nil options:nil][0];
//            [self.view addSubview:failView];
//            // 开始执行动画
//            [failView begin];
//        } else if ([rank isEqualToString:@"s"]) { // 最好
//            [[SoundTool sharedSoundTool] playSound:kSoundNormalGrade];
//            [[SoundTool sharedSoundTool] playSound:kSoundSGrade];
//        } else { // 普通  rank == A~E
//            [[SoundTool sharedSoundTool] playSound:kSoundNormalGrade];
//        }
//    };
}


#pragma mark 显示结果（界面效果）
- (void)showResultEffect:(NSString *)rank needSaveData:(BOOL)needSaveData
{
    if ([rank isEqualToString:@"f"]) { // 失败
        FailView *failView =  [[NSBundle mainBundle] loadNibNamed:@"FailView" owner:nil options:nil][0];
        [self.view addSubview:failView];
        // 开始执行动画
        [failView begin];
    } else { // 成功（合格）
        if (needSaveData) { // 有新纪录
            [self showNewRecord];
        } else { // 没有新纪录
            if ([rank isEqualToString:@"s"]) { // 最好
                [[SoundTool sharedSoundTool] playSound:kSoundNormalGrade];
                [[SoundTool sharedSoundTool] playSound:kSoundSGrade];
            } else { // 普通  rank == A~E
                [[SoundTool sharedSoundTool] playSound:kSoundNormalGrade];
            }
        }
    }
}

#pragma mark 保存游戏数据
- (void)saveData:(NSString *)rank
{
    // 设置新的分数和等级
    _model.recordModel.rank = rank;
    _model.recordModel.score = _scoreNew;
    // 归档
    //[StageRecordTool sharedStageRecordTool]  单例对象，不在生成新对象，而是反复调用第一次生成的对象，所以对象要这样写
    [[StageRecordTool sharedStageRecordTool] saveStageRecord:_model.recordModel];
    
    if (![rank isEqualToString:@"f"]) {
        // 检测下一关
        StageRecordModel *next = [[StageRecordTool sharedStageRecordTool] stageRecordWithNo:_model.no + 1];
        if (next == nil) { // 解锁下一关
            next = [[StageRecordModel alloc] init];
            next.no = _model.no + 1;
            [[StageRecordTool sharedStageRecordTool]  saveStageRecord:next];
        }
    }
}

#pragma mark 显示新纪录
- (void)showNewRecord
{
    // 1.更换背景
    [self.view setFullscreenImageName:@"scene_bg.jpg"];
    
    // 2.添加新纪录view
    RecordNewView *recordNew = [[NSBundle mainBundle] loadNibNamed:@"RecordNewView" owner:nil options:nil][0];
    [self.view insertSubview:recordNew belowSubview:_rankLabel];
    [recordNew begin];
}

- (IBAction)retry
{
    // 1.关闭当前控制器
    UINavigationController *nav =  (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav popViewControllerAnimated:NO];
    
    // 2.通知关卡界面重新开始游戏
    [[NSNotificationCenter defaultCenter] postNotificationName:@"restartGame" object:nil];
}

- (IBAction)selectOther
{
    // 1.导航控制器
    UINavigationController *nav =  (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    StagesViewController *stages = nav.viewControllers[1];
    // 刷新数据
    [stages reloadDataAtNo:_model.no];
    
    // 2.回到选择关卡界面
    [nav popToViewController:stages animated:NO];
    
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
