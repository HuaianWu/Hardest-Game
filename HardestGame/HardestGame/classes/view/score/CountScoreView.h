//
//  CountScoreView.h
//  HardestGame
//
//  计算分数的view

#import <UIKit/UIKit.h>

@class StageModel;

@interface CountScoreView : UIView
@property (nonatomic, weak) IBOutlet UIImageView *scoreBorder;
@property (nonatomic, weak) IBOutlet UIImageView *scoreHint;

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *unitLabel;

- (void)countScoreWithNewScore:(double)newScore model:(StageModel *)model;

@property (nonatomic, copy) void (^rankChange)(NSString *rank);

@property (nonatomic, copy) void (^showResult)(NSString *rank);

@end
