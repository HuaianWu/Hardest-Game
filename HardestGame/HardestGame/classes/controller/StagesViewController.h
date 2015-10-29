//
//  StagesViewController.h
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

//  选择关卡

#import <UIKit/UIKit.h>

@interface StagesViewController : UIViewController <UIScrollViewDelegate>
- (IBAction)back;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (void)reloadDataAtNo:(int)no;

@end

