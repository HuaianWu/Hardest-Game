//
//  FailView.h
//  HardestGame
//
//  失败时显示的view

#import "FullBgView.h"

@interface FailView : FullBgView
@property (weak, nonatomic) IBOutlet UIView *boyAndWord;
@property (weak, nonatomic) IBOutlet UIView *prison;
- (IBAction)retry;
- (IBAction)home;
@property (weak, nonatomic) IBOutlet UILabel *ownerScore;
@property (weak, nonatomic) IBOutlet UILabel *condition;


- (void)begin;
@end
