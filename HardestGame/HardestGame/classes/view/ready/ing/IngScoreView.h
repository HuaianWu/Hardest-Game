//
//  IngScoreView.h
//  HardestGame
//


//  计分板

#import <UIKit/UIKit.h>

@class StageModel;

@interface IngScoreView : UIView
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;

- (void)beginWithStageModel:(StageModel *)model;

// 设置积分
- (void)setScore:(double)score stageModel:(StageModel *)model;
@end

