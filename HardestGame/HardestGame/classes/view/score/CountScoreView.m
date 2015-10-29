//
//  CountScoreView.m
//  HardestGame
//

#import "CountScoreView.h"
#import "StageModel.h"
#import "SoundTool.h"
#import <QuartzCore/QuartzCore.h>
#import "Header.h"

#define kBtnWidth 52
#define KBtnHeight 60

#define kBtnShowRatio 88/103.0
#define kBtnTag 10

@interface CountScoreView()
{
    double _endX; // 指示器最终停留的x
}
@end

@implementation CountScoreView

- (void)awakeFromNib
{
    // 1.添加7个积分卡
    CGFloat btnY = self.frame.size.height - KBtnHeight;
    
    
    for (int i = 0; i<7; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置背景
        [btn setBackgroundImage:[UIImage imageNamed:@"other_score.png"] forState:UIControlStateNormal];
        // 设置边框
        btn.frame = CGRectMake(i * kBtnWidth * kBtnShowRatio, btnY, kBtnWidth, KBtnHeight);
        // 设置文字
        unichar c = [@"SABCDEF" characterAtIndex:i];
        [btn setTitle:[NSString stringWithFormat:@"%c", c] forState:UIControlStateNormal];
        
        // 设置界面属性
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 10);
        
        btn.userInteractionEnabled = NO;
        
        btn.tag = kBtnTag + i;
        
        [self insertSubview:btn belowSubview:_scoreBorder];
    }
    
    // 2.设置旋转一定角度
    self.transform = CGAffineTransformMakeRotation(M_PI_4/7);
    
    // 3.消除锯齿
    [self clearAlias];
}

#pragma mark 算分
- (void)countScoreWithNewScore:(double)newScore model:(StageModel *)model
{
    /*
     1.计算指示器最终要停留的x
     */
    // 1.1.计算每个积分卡占据多少分数
    double scorePerBtn = (model.max - model.min) / 5;
    
    // 1.2.计算每分占据多少宽度
    double widthPerScore = (kBtnWidth * kBtnShowRatio) /scorePerBtn;
    
    // 1.3.算出跟F的x的宽度差距
    double delta = (newScore - model.min) * widthPerScore;
    
    // 1.4.算出指示器最终的x
    // 取出F这个按钮的x
    double fX = [self viewWithTag:kBtnTag + 6].frame.origin.x;
    _endX = fX - delta - 1;
    
    // 1.5.最终的x进行过滤
    if (_endX < 0) { // 超出屏幕最左边
        _endX = 0;
    } else if(_endX > fX) {
        _endX = fX;
    }
    
    // 2.添加一个定时器
    [[CADisplayLink displayLinkWithTarget:self selector:@selector(update:)] addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    // 3.设置显示的分数和单位 
    _scoreLabel.text = [NSString stringWithFormat:model.format, newScore];
    _unitLabel.text = model.unit;
}

#pragma mark 刷新位置
- (void)update:(CADisplayLink *)timer
{
    // 初始化索引
    //因为反复调用，多次重复创建消除，浪费资源，所以可以定义成静态变量  static
    static int index = 6;
    
    // 取出当前的中点
    CGPoint center = _scoreHint.center;
    //center.x -= 0.5 * (index + 1);
    center.x -= 3;
    
    BOOL stop = NO;
    // x值越界
    if (center.x < _endX) {
        center.x = _endX;
        // 停止计时器
        [timer invalidate];
        
        stop = YES;
    }
    
    // 点亮积分卡
    index = center.x / (kBtnWidth * kBtnShowRatio);
    // 判断index是否合理
    if (index <= 6) {
        UIButton *btn = (UIButton *)[self viewWithTag:kBtnTag + index];
        if (btn) {
            [btn setBackgroundImage:[UIImage imageNamed:@"cureent_score.png"] forState:UIControlStateNormal];
            // 赋值一个特殊的tag
            btn.tag = 0;
            _scoreBorder.hidden = NO;
            _scoreBorder.center = CGPointMake(btn.center.x - 5, btn.center.y);
            
            // 播放音效
            [[SoundTool sharedSoundTool] playSound:kSoundGrade(index)];
            
            // 调用block
            if (_rankChange) {
                unichar c = [@"sabcdef" characterAtIndex:index];
                _rankChange([NSString stringWithFormat:@"%c", c]);
            }
        }
    }
    
    // 显示结果
    if (_showResult && stop) {
        unichar c = [@"sabcdef" characterAtIndex:index];
        _showResult([NSString stringWithFormat:@"%c", c]);
    }
    
    // 设置指示器的中点位置
    _scoreHint.center = center;
}
@end