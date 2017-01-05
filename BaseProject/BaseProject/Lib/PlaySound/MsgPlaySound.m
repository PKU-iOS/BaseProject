//
//  MsgPlaySound.m
//  sdfasf
//
//  Created by Wmy on 16/1/26.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "MsgPlaySound.h"

@implementation MsgPlaySound

#pragma mark -
#pragma mark - 单次消息提醒

+ (void)msgPlaySystemVibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (void)msgPlaySystemSound
{
    [MsgPlaySound msgPlaySystemSoundWithName:@"sms-received1" soundType:@"caf"];
}

+ (void)msgPlaySystemSoundWithName:(NSString *)soundName soundType:(NSString *)soundType
{
    // 得到苹果框架资源UIKit.framework ，从中取出所要播放的系统声音的路径
    // [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:soundName ofType:soundType];
    // 获取自定义的声音
    // [[NSBundle mainBundle] URLForResource:@"tap" withExtension:@"aif"];

    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@", soundName, soundType];
    SystemSoundID soundID;
    if (path) {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        if (error != kAudioServicesNoError) { // 获取的声音的时候，出现错误
            soundID = 1007;
        }
    }
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - 
#pragma mark - 循环播放提醒

void completeCallback(SystemSoundID soundID, void * clientData)
{   // 循环提 声音 或 震动
    AudioServicesPlaySystemSound(soundID);
}

void soundAndVibrateCompleteCallback(SystemSoundID soundID, void * clientData)
{   // 循环体 声音 和 震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(soundID);
}

+ (void)stopAlertSoundWithSoundID:(SystemSoundID)soundID
{   // 停止循环播放
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(soundID);
    AudioServicesRemoveSystemSoundCompletion(soundID);
}

+ (void)msgLoopPlayVibrate
{   // 循环震动
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, completeCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (void)msgLoopPlaySound
{   // 循环声音
    [MsgPlaySound msgLoopPlaySoundWithSoundID:1007];
}

+ (void)msgLoopPlaySoundWithSoundID:(SystemSoundID)soundID
{   // 核心代码 可重复执行
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, completeCallback, NULL);
    AudioServicesPlaySystemSound(soundID);
}

+ (void)msgLoopPlaySoundAndVibrate
{   // 循环声音和震动
    [MsgPlaySound msgLoopPlaySoundAndVibrateWithSoundID:1007];
}

+ (void)msgLoopPlaySoundAndVibrateWithSoundID:(SystemSoundID)soundID
{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"music.mp3" ofType:nil];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    // 核心代码 可重复执行
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundAndVibrateCompleteCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(soundID);
}


@end
