//
//  FeatherView.m
//  HardestGame
//

#import "FeatherView.h"
#import <QuartzCore/QuartzCore.h>

@interface FeatherView()
{
    NSTimer *_timer;
}
@end

@implementation FeatherView

- (void)begin
{
    // 隐藏
    self.alpha = 0;
}
- (void)attack:(int)index
{
    // 0.显示
    self.alpha = 1;
    
    [UIView animateWithDuration:0.1 animations:^{
        // 1.修改x值
        CGRect frame = self.frame;
        frame.origin.x = (index + 0.5) * [UIScreen mainScreen].bounds.size.width/3;
        self.frame = frame;
        
        // 2.执行挠的动画
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation"];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGFloat width = 60;
        CGFloat height = 40;
        CGPathAddEllipseInRect(path, NULL, CGRectMake(-width*0.5, -height * 0.5, width, height));
        anim.path = path;
        
        [self.layer addAnimation:anim forKey:nil];
        
        CGPathRelease(path);
    }];
    
    // 2.过一段时间让羽毛消失
    //防止出现垃圾对象
    [_timer invalidate]; // 让上次的计时器失效
    _timer=nil;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

- (void)hide
{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    }];
}

@end