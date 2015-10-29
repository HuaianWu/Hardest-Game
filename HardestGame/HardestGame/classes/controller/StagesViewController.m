//
//  StagesViewController.m
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "StagesViewController.h"
#import "SoundTool.h"
#import "StageListView.h"
#import "Header.h"
#import "ReadyViewController.h"
#import "CountScoreViewController.h"


@interface StagesViewController ()
{
    StageListView *_listView;
}

@end

@implementation StagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.设置背景
    [self.view setFullscreenImageName:@"select_bg.jpg"];
    
    // 2.添加StageListView
    StageListView *listView = [[StageListView alloc] initWithFrame:self.view.bounds];
    listView.delegate = self;
    
    listView.itemClickBlock = ^(StageModel *model){
        // MyLog(@"%@", model.title);
        [self performSegueWithIdentifier:@"ready" sender:model];
    };
    
    // 这里用insert保证listView在最下层
    [self.view insertSubview:listView atIndex:0];
    
    
    //    [listView addSubview:listView];
    //    // 将子控件弄到最前面
    //    [listView bringSubviewToFront:<#(UIView *)#>];
    //    // 将子控件弄到最后面
    //    [listView sendSubviewToBack:listView];
    
    
       _listView = listView;

}

- (void)reloadDataAtNo:(int)no
{
    [_listView reloadStageViewAtNo:no];
}


#pragma mark 滚动代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}

- (IBAction)back {
    [[SoundTool sharedSoundTool] playSound:kSoundClick];
    [self.navigationController popViewControllerAnimated:NO];
}

/*
 stageView --> listView itemClick: ---> itemClickBlock(model)
 ---> performSegueWithIdentifier ---> prepareForSegue:
 */

#pragma mark 跳转之前会调用（一般在这里传递数据给下一个控制器）
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        ReadyViewController *ready = segue.destinationViewController;
    
        ready.stageModel = sender;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
