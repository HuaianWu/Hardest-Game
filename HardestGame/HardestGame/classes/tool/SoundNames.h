//
//  SoundNames.h
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

/*
 专门存放跟音频相关的宏
 */

/*
 软件参数相关的key
 */
#define kMusicMuted @"music_muted"
#define kSoundMuted @"sound_muted"

/*
 音频文件名
 */
// 点击
#define kSoundClick @"click.mp3"

// 解锁
#define kSoundUnlock @"chain_drop.mp3"
// new出现
#define kSoundNew @"new_pop.mp3"


// 准备界面
#define kSoundReady @"stage_ready.mp3"
// 标题掉落
#define kSoundDrop(n) [NSString stringWithFormat:@"drop_title_%d.mp3", n]

// 准备游戏ready-go
#define kSoundReadyGo @"ready_go.mp3"


// 点击了羽毛按钮
#define kSoundTap @"tap.mp3"


// 关卡等级的声音
#define kSoundGrade(i) [NSString stringWithFormat:@"scoreGrade%d.mp3", i]

// 普通等级
#define kSoundNormalGrade @"normalScore.mp3"
// S等级
#define kSoundSGrade @"getGradeS.mp3"

// 人掉下来
#define kSoundFailDrop @"failDrop.mp3"

// 人惨叫
#define kSoundFailShout @"failShout.mp3"

// 监狱掉下来
#define kSoundCageDrop @"cageDrop.mp3"

// 新纪录的声音
#define kSoundRecordNew1 @"hiScore01.mp3"
#define kSoundRecordNew2 @"hiScore02.mp3"
