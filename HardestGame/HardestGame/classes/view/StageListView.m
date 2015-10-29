//
//  StageListView.m
//  HardestGame
//
//  Created by scsys on 15/10/15.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "StageListView.h"
#import "FullBgView.h"
#import "StageView.h"
#import "StageModel.h"
#import "Header.h"
#import "StageRecordTool.h"
#import "StageRecordModel.h"

@implementation StageListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        // 1.加载4张背景图片
//        [self loadBgs];
//        
//        // 2.加载关卡信息
//        [self loadStageInfo];
        
        // 1.加载关卡信息
        [self loadStageInfo];
        
        // 2.加载4张背景图片
        [self loadBgs];

        
        // 3.基本属性设置
        // 内容尺寸
        self.contentSize = CGSizeMake(4 * self.frame.size.width, 0);
        // 开启分页
        self.pagingEnabled = YES;
        // 隐藏水平滚动条
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

#pragma mark 刷新关卡
- (void)reloadStageViewAtNo:(int)no
{
    // 1.刷新当前关卡
    StageView *stage1 = (StageView *)[self viewWithTag:no];
    StageModel *model1 = stage1.stageModel;
    model1.recordModel = [[StageRecordTool sharedStageRecordTool] stageRecordWithNo:no];
    stage1.stageModel = model1;
    
    // 2.刷新下一关
    StageView *stage2 = (StageView *)[self viewWithTag:no + 1];
    if (stage2 == nil) return;
    
    StageModel *model2 = stage2.stageModel;
    model2.recordModel = [[StageRecordTool sharedStageRecordTool] stageRecordWithNo:no + 1];
    stage2.stageModel = model2;
    
    // 3.翻到下一页: 当前关卡通过 && 下一关从未玩过 && 下一关在下一页
    BOOL pass = ![model1.recordModel.rank isEqualToString:@"f"];
    BOOL never = model2.recordModel.rank == nil;
    BOOL nextPage = (no % 6) == 0;
    if (pass && never && nextPage) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        CGPoint offset = self.contentOffset;
        offset.x = (no / 6) * self.frame.size.width;
        self.contentOffset = offset;
        [UIView commitAnimations];
    }
}




#pragma mark 添加1张背景
- (void)addBgWithName:(NSString *)name index:(int)index
{
    CGSize size = self.frame.size;
    
    FullBgView *bg = [[FullBgView alloc] init];
    bg.frame = CGRectMake(index * size.width, 0, size.width, size.height);
    // 设置图片名称
    [bg setFullscreenImageName:name];
    [self addSubview:bg];
    
    //把该视图放在所有视图最底下
    [self sendSubviewToBack:bg];
}

#pragma mark 加载4张背景
- (void)loadBgs
{
    [self addBgWithName:@"select_easy_bg.jpg" index:0];
    [self addBgWithName:@"select_normal_bg.jpg" index:1];
    [self addBgWithName:@"select_hard_bg.jpg" index:2];
    [self addBgWithName:@"select_insane_bg.jpg" index:3];
}

#pragma mark 加载关卡信息
- (void)loadStageInfo
{
    // 1.加载plist文件
    NSURL *stagesUrl = [[NSBundle mainBundle] URLForResource:@"stages" withExtension:@"plist"];
    NSArray *stages = [NSArray arrayWithContentsOfURL:stagesUrl];
    
    // 固定数值
    CGSize viewSize = self.frame.size;
    CGFloat stageViewWdith = 110;
    CGFloat stageViewHeight = 93;
    
    // 水平间距
    CGFloat marginX = 30;
    // 垂直间距
    CGFloat marginY = 30;
    
    // 开始的y
    CGFloat startY = 90 + (iPhone5?44:0);
    
    // 2.解析关卡信息
    int count = stages.count;
    for (int i = 0; i <count; i++)
    {
        // 2.1 取出当前的关卡
        NSDictionary *dict = stages[i];
        
        // 2.2 创建关卡View
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"StageView" owner:nil options:nil];
        
        // 2.3.1 把字典转成模型对象
        StageModel *stageModel = [StageModel stageModelWithDict:dict];
        stageModel.no = i + 1;
        
        // 2.3.2加载关卡记录信息
        StageRecordModel *record = [[StageRecordTool sharedStageRecordTool] stageRecordWithNo:i + 1];
        stageModel.recordModel = record;
        
        // 2.4 给关卡View设置模型数据
        StageView *stageView = views[0];
        stageView.tag = i + 1;
        stageView.stageModel = stageModel;

        
        [stageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClick:)]];
        
        // 2.5 设置x、y值
        // 开始的x(每一页的开始x都不一样)
        CGFloat startX = (viewSize.width - 2 * stageViewWdith - marginX) * 0.5 + (i/6) * viewSize.width;
        
        // y
        CGFloat y = startY + (i%3) * (stageViewHeight + marginY);
        CGFloat x = startX + (i/3)%2 * (stageViewWdith + marginX);
        
        CGRect frame = stageView.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        stageView.frame = frame;
        
        // 2.6 添加到StageListView中
        [self addSubview:stageView];
        [self sendSubviewToBack:stageView];
    }
}

#pragma mark 点击了关卡
- (void)itemClick:(UITapGestureRecognizer *)tap
{
    if (_itemClickBlock) {
        
        
        StageView *stageView =  (StageView *)tap.view;
        
        _itemClickBlock(stageView.stageModel);
    }
}


@end
