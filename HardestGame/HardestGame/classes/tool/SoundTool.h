//
//  SoundTool.h
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoundNames.h"
#import "Singleton.h"

@interface SoundTool : NSObject

// 公共的访问单例对象的方法
singleton_interface(SoundTool)

// 播放背景音乐
- (void)playBgMusic;

// 播放音频
- (void)playSound:(NSString *)soundName;

// 设置音乐是否静音
@property (nonatomic, assign) BOOL musicMuted;

// 设置音效是否静音
@property (nonatomic, assign) BOOL soundMuted;
@end

