//
//  FeetView.m
//  HardestGame
//

#import "FeetView.h"

@implementation FeetView

- (void)awakeFromNib
{
    // 加载动画图片
    _feetIcon.animationImages = @[
          [UIImage imageNamed:@"01-feet01.png"],
          [UIImage imageNamed:@"01-feet02.png"],
          [UIImage imageNamed:@"01-feet02.png"],
          [UIImage imageNamed:@"01-feet02.png"],
          [UIImage imageNamed:@"01-feet02.png"],
          [UIImage imageNamed:@"01-feet03.png"]
    ];
    _feetIcon.animationRepeatCount = 1;
    _feetIcon.animationDuration = 0.5;
}

- (void)begin
{
    // 显示
    self.hidden = NO;
}

- (void)random
{
    // 0.停止动画
    [_feetIcon stopAnimating];
    
    // 1.获得脚当前的索引
    int oldIndex = self.currentIndex;
    
    // 2.随机生成一个新的索引
    int newIndex = oldIndex;
    while (newIndex == oldIndex) {
        // 生成3以内的随机整数（0、1、2）
        newIndex = arc4random_uniform(3);
    }
    
    // 3.更改位置
    CGRect frame = self.frame;
    frame.origin.x = newIndex * self.frame.size.width;
    self.frame = frame;
}

#pragma mark 是否被击中
- (BOOL)isGotHit:(int)attackIndex
{
    if (attackIndex == self.currentIndex) { // 击中
        // 执行动画
        [_feetIcon startAnimating];
        return YES;
    }
    
    // 没有击中
    return NO;
}

- (int)currentIndex
{
    return self.frame.origin.x / self.frame.size.width;
}

@end
