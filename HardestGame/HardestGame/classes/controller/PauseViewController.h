//
//  PauseViewController.h
//  HardestGame
//
//  Created by scsys on 15/10/19.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PauseViewController : UIViewController

- (IBAction)resume;
- (IBAction)exit;
- (IBAction)left;
- (IBAction)right;
//@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *pages;

@property (weak, nonatomic) IBOutlet UIImageView *currentPage;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) void (^resumeBlock)();


@end
