//
//  FeatherView.h
//  HardestGame
//
//  羽毛

#import <UIKit/UIKit.h>

@interface FeatherView : UIImageView
- (void)begin;

// 攻击某个位置
- (void)attack:(int)index;
@end
