//
//  XFAudioReader.m
//  Pods-XCAudioManager_Example
//
//  Created by yunjidian on 2021/10/29.
//

#import "XFAudioReader.h"
#import "iflyMSC/IFlyMSC.h"

#define K_SPEED         @"50"       // 语速
#define K_VOLUME        @"50"       // 音量
#define K_PITCH         @"50"       // 音调
#define K_SAMPLE_RATE   @"1600"     // 采样率
#define K_ENGINE_TYPE   @"auto"     // 发音人
#define K_VCN_NAME      @"vixq"     // 引擎类型

@interface XFAudioReader ()<IFlySpeechSynthesizerDelegate>

@end

@implementation XFAudioReader
{
    /// 语言
    XCAudioLanguage _language;
    
    /// 讯飞语音播报器
    IFlySpeechSynthesizer *_iFlySpeechSynthesizer;
}

- (instancetype)initWithLanguage:(XCAudioLanguage)language
{
    if (self = [super init]) {
        _language = language;
        [self _setup];
    }
    return self;
}

#pragma mark - 🔒 👀 Privite Method 👀

- (void)_setup
{
    /// 配置一些语音的默认参数
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    
    //设置语速1-100
    [_iFlySpeechSynthesizer setParameter:K_SPEED forKey:[IFlySpeechConstant SPEED]];
    
    //设置音量1-100
    [_iFlySpeechSynthesizer setParameter:K_VOLUME forKey:[IFlySpeechConstant VOLUME]];
    
    //设置音调1-100
    [_iFlySpeechSynthesizer setParameter:K_PITCH forKey:[IFlySpeechConstant PITCH]];
    
    //设置采样率
    [_iFlySpeechSynthesizer setParameter:K_SAMPLE_RATE forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    //设置发音人
    [_iFlySpeechSynthesizer setParameter:K_VCN_NAME forKey:[IFlySpeechConstant VOICE_NAME]];
    
    //设置文本编码格式
    [_iFlySpeechSynthesizer setParameter:@"unicode" forKey:[IFlySpeechConstant TEXT_ENCODING]];
    
    switch (_language) {
        case XCAudioLanguageMandarin: { // 普通话
            [_iFlySpeechSynthesizer setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
            break;
        }
        case XCAudioLanguageEnglish: { // 英文
            [_iFlySpeechSynthesizer setParameter:@"catherine" forKey:[IFlySpeechConstant VOICE_NAME]];
            break;
        }
    }
}

#pragma mark - 💉 👀 XCAudioReader 👀

/// 开始阅读
/// @param text 文本
- (void)startReading:(NSString *)text
{
    [_iFlySpeechSynthesizer startSpeaking:text];
}

/// 停止阅读
- (void)stopReading
{
    [_iFlySpeechSynthesizer stopSpeaking];
}

/// 恢复阅读
- (void)resumeReading
{
    [_iFlySpeechSynthesizer resumeSpeaking];
}

/// 暂停阅读
- (void)pauseReading
{
    [_iFlySpeechSynthesizer pauseSpeaking];
}

#pragma mark - 💉 👀 IFlySpeechSynthesizerDelegate 👀

/*!
 *  开始阅读回调
 */
- (void)onSpeakBegin
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onReadingBegin)]) {
        [self.delegate onReadingBegin];
    }
}

/*!
 *  缓冲进度回调
 *
 *  @param progress 缓冲进度，0-100
 *  @param msg      附件信息，此版本为nil
 */
- (void)onBufferProgress:(int)progress message:(NSString *)msg
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onBufferProgress:)]) {
        [self.delegate onBufferProgress:progress];
    }
}

/*!
 *  阅读进度回调
 *
 *  @param progress 当前阅读进度，0-100
 *  @param beginPos 当前阅读文本的起始位置，0-100
 *  @param endPos 当前阅读文本的结束位置，0-100
 */
- (void)onSpeakProgress:(int)progress beginPos:(int)beginPos endPos:(int)endPos
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onReadingProgress:)]) {
        [self.delegate onReadingProgress:progress];
    }
}

/*!
 *  结束回调<br>
 *  当整个合成结束之后会回调此函数
 *
 *  @param error 错误码
 */
- (void)onCompleted:(IFlySpeechError*)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onCompleted)]) {
        NSError *err;
        if (error.errorCode != 0) {
            err = [NSError errorWithDomain:NSCocoaErrorDomain code:error.errorCode userInfo:@{
                NSLocalizedDescriptionKey: (error.errorDesc ?: @"出现错误")
            }];
        }
        [self.delegate onReadingCompleted:err];
    }
}


@end
