//
//  MsgPlaySound.h
//  sdfasf
//
//  Created by Wmy on 16/1/26.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MsgPlaySound : NSObject

/**
 *  播放系统消息震动
 */
+ (void)msgPlaySystemVibrate;

/**
 *  播放系统消息声音
 */
+ (void)msgPlaySystemSound;

/**
 *  播放指定系统声音
 *
 *  @param soundName 文件名
 *  @param soundType 文件类型
 */
+ (void)msgPlaySystemSoundWithName:(NSString *)soundName soundType:(NSString *)soundType;

/**
 *  循环震动
 */
+ (void)msgLoopPlayVibrate;

/**
 *  循环系统声音
 */
+ (void)msgLoopPlaySound;

/**
 *  循环系统声音
 *
 *  @param soundID 系统声音的id 取值范围为：1000-2000 eg:1007
 */
+ (void)msgLoopPlaySoundWithSoundID:(SystemSoundID)soundID;

/**
 *  循环系统声音和震动
 */
+ (void)msgLoopPlaySoundAndVibrate;

/**
 *  循环系统声音和震动
 *
 *  @param soundID 系统声音的id 取值范围为：1000-2000 eg:1007
 */
+ (void)msgLoopPlaySoundAndVibrateWithSoundID:(SystemSoundID)soundID;

/**
 *  停止循环声音和震动
 *
 *  @param soundID 系统声音的id 取值范围为：1000-2000 eg:1007
 */
+ (void)stopAlertSoundWithSoundID:(SystemSoundID)soundID;

@end

/**
 
 信息
 ReceivedMessage.caf-----收到信息，仅在短信界面打开时播放。
 sms-received1.caf-------三全音
 sms-received2.caf-------管钟琴
 sms-received3.caf-------玻璃
 sms-received4.caf-------圆号
 sms-received5.caf-------铃声
 sms-received6.caf-------电子乐
 SentMessage.caf---------发送信息
 
 电话
 dtmf-0.caf----------拨号面板0按键
 dtmf-1.caf----------拨号面板1按键
 dtmf-2.caf----------拨号面板2按键
 dtmf-3.caf----------拨号面板3按键
 dtmf-4.caf----------拨号面板4按键
 dtmf-5.caf----------拨号面板5按键
 dtmf-6.caf----------拨号面板6按键
 dtmf-7.caf----------拨号面板7按键
 dtmf-8.caf----------拨号面板8按键
 dtmf-9.caf----------拨号面板9按键
 dtmf-pound.caf------拨号面板＃按键
 dtmf-star.caf-------拨号面板*按键
 Voicemail.caf-------新语音邮件
 
 输入设备声音提示
 Tock.caf-----------------点击键盘
 begin_record.caf---------开始录音
 begin_video_record.caf---开始录像
 photoShutter.caf---------快门声
 end_record.caf-----------结束录音
 end_video_record.caf-----结束录像
 
 其他
 beep-beep.caf-------充电、注销及连接电脑
 lock.caf------------锁定手机
 shake.caf-----------“这个还没搞清楚”
 unlock.caf----------滑动解锁
 low_power.caf-------低电量提示
 
 */
