//
//  Stage02ViewController.m
//  HardestGame
//
//  Created by scsys on 15/10/21.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "Stage02ViewController.h"
#import "CountScoreView.h"

@interface Stage02ViewController ()

@end

@implementation Stage02ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (NSArray *)guideImageNames
{
    return @[@"guide00.png", @"guide01.png"];
}
#pragma mark 程序进入前台就会调用
- (void)appEnterForeground
{
    [self performSegueWithIdentifier:@"pause" sender:nil];
}

- (void)beginGame
{
    
}
-(void)endGame
{
    // 1.停止交互
    self.view.userInteractionEnabled = NO;
    
    // 2.停止计时器
    [self.timer invalidate];
    self.timer=nil;
    
 
    
    // 4.跳到算分界面
    
    UIStoryboard *story = [self.navigationController storyboard];
    //    UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    CountScoreView   *CountScore = [story instantiateViewControllerWithIdentifier:@"CountScore"];
    
    
    [self.navigationController pushViewController:CountScore animated:NO];
    

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
