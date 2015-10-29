//
//  RecordNewView.h
//  HardestGame
//
#import <UIKit/UIKit.h>

@interface RecordNewView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *lightView;
@property (weak, nonatomic) IBOutlet UIView *highScoreView;
@property (weak, nonatomic) IBOutlet UIView *recordNewBoard;
- (void)begin;
@end