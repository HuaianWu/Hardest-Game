//
//  FeetView.h
//  HardestGame
//
//  脚

#import <UIKit/UIKit.h>

@interface FeetView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *feetIcon;

- (void)begin;

// 随机出现
- (void)random;

// 是否被击中
- (BOOL)isGotHit:(int)attackIndex;

@end
