//
//  XCAudioRecognizer.h
//  Pods
//
//  Created by yunjidian on 2021/10/29.
//

#import <Foundation/Foundation.h>
#import "XCAudioHeader.h"


@protocol XCAudioRecognizerDelegate <NSObject>

@optional

/// 开始录音的回调
/// 当调用了 startListening 函数后，如果没有发生错误则会回调此函数，如果发生错误则回调 onCompleted: 函数
- (void)onRecordingBegin;

/// 停止录音的回调
/// 当调用了 stopListening 函数后，如果没有发生错误则会回调此函数，如果发生错误则回调 onCompleted: 函数
- (void)onRecordingEnd;

/// 在录音过程中，音量变化的回调
/// @param volume 音量（0~30）
- (void)onVolumeChanged:(NSInteger)volume;

/// 取消识别的回调
/// 当调用了 cancel 函数后，会回调此函数
- (void)onCancel;

/// 识别结果回调
/// @param result 识别结果
/// @param error 错误
- (void)onCompleted:(NSString *)result error:(NSError *)error;

@end



@protocol XCAudioRecognizer <NSObject>

@required

/**
 *  初始化
 */
- (instancetype)initWithLanguage:(XCAudioLanguage)language;


@optional

/// 回调代理
@property (weak, nonatomic) id<XCAudioRecognizerDelegate> delegate;

/// 开始录音，同时只能进行一路会话
- (void)startListening;

/// 停止录音，并开始进行语音识别
- (void)stopListening;

/// 取消本次会话
- (void)cancel;

/// 识别一段音频文件
/// @param data 音频文件
- (void)recognizeData:(NSData *)data;

@end
