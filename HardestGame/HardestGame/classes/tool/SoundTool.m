//
//  SoundTool.m
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "SoundTool.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundTool()
{
    AVAudioPlayer *_bgMusicPlayer;
    NSMutableDictionary *_soundIDs; // 所有的音频文件ID
}

@end




@implementation SoundTool


/*
 OC的单例模式：
 1.有个static类型的全局变量
 2.重写allocWithZone:，保证只会分配一次内存
 3.公共的类方法来返回单例对象
 */




//// 存放唯一的一个实例
//static SoundTool *_instance;
//// 重写allocWithZone（alloc最终还是要调用allocWithZone）
//+ (id)allocWithZone:(NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    /*
//     1.不用管多线程问题
//     2.能保证block里面的代码永远只调用一次
//     */
//    // 保证多次调用allocWithZone后都返回同一个对象
//    dispatch_once(&onceToken, ^{
//        _instance = [super allocWithZone:zone];
//    });
//    return _instance;
//}
//
//+ (SoundTool *)sharedSoundTool
//{
//    // 保证多次调用sharedSoundTool都返回同一个alloc、init之后的对象
//    
//    //dispatch_once_t  一个函数，功能是保证代码块的内容只执行一次
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc] init];
//    });
//    return _instance;
//}
//



singleton_implementation(SoundTool)


- (id)init
{
    if (self = [super init]) {
        /*
         加载资源
         */
        // 1.加载背景音乐
        [self loadBgMusic];
        
        // 2.加载音效
        [self loadSounds];
        
        // 3.加载软件参数
        _musicMuted = [[NSUserDefaults standardUserDefaults] boolForKey:kMusicMuted];
        _soundMuted = [[NSUserDefaults standardUserDefaults] boolForKey:kSoundMuted];
    }
    return self;
}

#pragma mark - 音乐、音效的设置
#pragma mark 设置音乐是否静音
- (void)setMusicMuted:(BOOL)musicMuted
{
    // 1.赋值给成员变量
    _musicMuted = musicMuted;
    
    // 2.归档
    [[NSUserDefaults standardUserDefaults] setBool:_musicMuted forKey:kMusicMuted];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 3.根据当前状态决定要不要播放背景音乐
    if (_musicMuted) {
        [_bgMusicPlayer pause];
    } else {
        [_bgMusicPlayer play];
    }
}
#pragma mark 设置音效是否静音
- (void)setSoundMuted:(BOOL)soundMuted
{
    // 1.赋值给成员变量
    _soundMuted = soundMuted;
    
    // 2.归档
    [[NSUserDefaults standardUserDefaults] setBool:_soundMuted forKey:kSoundMuted];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 加载...初始化
#pragma mark 加载背景音乐
- (void)loadBgMusic
{
    // 1.获得背景音乐的URL
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"bg_music.mp3" withExtension:nil];
    
    // 2.加载播放器
    _bgMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    // 缓冲
    [_bgMusicPlayer prepareToPlay];
    // 无限循环
    _bgMusicPlayer.numberOfLoops = -1;
}

#pragma mark 加载音效
- (void)loadSounds
{
    // 1.初始化字典
    _soundIDs = [NSMutableDictionary dictionary];
    
    // 2.加载sound.bundle
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"sound" withExtension:@"bundle"];
    NSBundle *soundBundle = [NSBundle bundleWithURL:bundleURL];
    
    // 3.获得sound.bundle中所有mp3文件的URL
    NSArray *mp3URLs = [soundBundle URLsForResourcesWithExtension:@"mp3" subdirectory:nil];
    
    // 4.根据每个mp3的URL加载soundID
    for (NSURL *url in mp3URLs)
    {
        SystemSoundID soundID;
        // 5.加载音频ID
        AudioServicesCreateSystemSoundID((__bridge CFURLRef )url, &soundID);
        
        // 6.获得文件名
        NSString *filename = [url.path lastPathComponent];
        
        // 7.将音频ID和文件名放入字典
        [_soundIDs setObject:@(soundID) forKey:filename];
    }
}

#pragma mark - 公共方法
#pragma mark 播放背景音乐
- (void)playBgMusic
{
    // 1.如果静音，直接返回
    if (_musicMuted) return;
    
    // 2.播放
    [_bgMusicPlayer play];
}

#pragma mark 播放音频
- (void)playSound:(NSString *)soundName
{
    // 1.如果静音，直接返回
    if (_soundMuted) return;
    
    // 2.取出音频ID
    SystemSoundID soundID = [_soundIDs[soundName] unsignedLongValue];
    
    // 3.根据播放音频
    AudioServicesPlaySystemSound(soundID);
}



@end
