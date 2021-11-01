//
//  XCAudioRecognizer.m
//  XCAudioManager
//
//  Created by yunjidian on 2021/10/29.
//

#import "XFAudioRecognizer.h"
#import "iflyMSC/IFlyMSC.h"

@interface XFAudioRecognizer ()<IFlySpeechRecognizerDelegate>

@end

@implementation XFAudioRecognizer
{
    /// 语言
    XCAudioLanguage _language;
    
    /// 讯飞语音识别器
    IFlySpeechRecognizer *_iFlySpeechRecognizer;
    
    /// 识别结果
    NSMutableArray<NSString *> *_results;
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
    _results = [NSMutableArray array];
    
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    _iFlySpeechRecognizer.delegate = self;
    //set timeout of recording
    [_iFlySpeechRecognizer setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
    //set VAD timeout of end of speech(EOS)
    [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_EOS]];
    //set VAD timeout of beginning of speech(BOS)
    [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
    //set network timeout
    [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
    //set sample rate, 16K as a recommended option
    [_iFlySpeechRecognizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    //Set result type
    [_iFlySpeechRecognizer setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    //set whether or not to show punctuation in recognition results
    [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
    
    switch (_language) {
        case XCAudioLanguageMandarin: { // 普通话
            //set language
            [_iFlySpeechRecognizer setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
            //set accent
            [_iFlySpeechRecognizer setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
            break;
        }
        case XCAudioLanguageEnglish: { // 英文
            //set language
            [_iFlySpeechRecognizer setParameter:@"en_us" forKey:[IFlySpeechConstant LANGUAGE]];
            //set accent
            [_iFlySpeechRecognizer setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
            break;
        }
    }
}

#pragma mark - 💉 👀 XCAudioRecognizer 👀

/// 开始录音，同时只能进行一路会话
- (void)startListening
{
    [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant AUDIO_SOURCE]];
    [_iFlySpeechRecognizer startListening];
}

/// 停止录音，并开始进行语音识别
- (void)stopListening
{
    [_iFlySpeechRecognizer stopListening];
}

/// 取消本次会话
- (void)cancel
{
    [_iFlySpeechRecognizer cancel];
}

/// 识别一段音频文件
/// @param data 音频文件
- (void)recognizeData:(NSData *)data
{
    [_iFlySpeechRecognizer setParameter:@"-1" forKey:[IFlySpeechConstant AUDIO_SOURCE]];
    [_iFlySpeechRecognizer startListening];
    [_iFlySpeechRecognizer writeAudio:data];
    [_iFlySpeechRecognizer stopListening];
}

#pragma mark - 💉 👀 IFlySpeechRecognizerDelegate 👀

/*!
 *  识别结果回调
 *
 *  在进行语音识别过程中的任何时刻都有可能回调此函数，你可以根据errorCode进行相应的处理，当errorCode没有错误时，表示此次会话正常结束；否则，表示此次会话有错误发生。特别的当调用`cancel`函数时，引擎不会自动结束，需要等到回调此函数，才表示此次会话结束。在没有回调此函数之前如果重新调用了`startListenging`函数则会报错误。
 *
 *  @param error 错误描述
 */
- (void)onCompleted:(IFlySpeechError *)error
{
    NSString *result = [_results componentsJoinedByString:@""];
    [_results removeAllObjects];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onCompleted:error:)]) {
        NSError *err;
        if (error.errorCode != 0) {
            err = [NSError errorWithDomain:NSCocoaErrorDomain code:error.errorCode userInfo:@{
                NSLocalizedDescriptionKey: (error.errorDesc ?: @"出现错误")
            }];
        }
        [self.delegate onCompleted:result error:err];
    }
}

/*!
 *  识别结果回调
 *
 *  在识别过程中可能会多次回调此函数，你最好不要在此回调函数中进行界面的更改等操作，只需要将回调的结果保存起来。<br>
 *  使用results的示例如下：
 *  <pre><code>
 *  - (void) onResults:(NSArray *) results{
 *     NSMutableString *result = [[NSMutableString alloc] init];
 *     NSDictionary *dic = [results objectAtIndex:0];
 *     for (NSString *key in dic){
 *        [result appendFormat:@"%@",key];//合并结果
 *     }
 *   }
 *  </code></pre>
 *
 *  @param results  -[out] 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，sc为识别结果的置信度。
 *  @param isLast   -[out] 是否最后一个结果
 */
- (void)onResults:(NSArray *)results isLast:(BOOL)isLast
{
    // 保存结果
    NSDictionary *dic = results.firstObject;
    [_results addObjectsFromArray:dic.allKeys];
}

/*!
 *  音量变化回调<br>
 *  在录音过程中，回调音频的音量。
 *
 *  @param volume -[out] 音量，范围从0-30
 */
- (void)onVolumeChanged:(int)volume
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onVolumeChanged:)]) {
        [self.delegate onVolumeChanged:volume];
    }
}

/*!
 *  开始录音回调<br>
 *  当调用了`startListening`函数之后，如果没有发生错误则会回调此函数。<br>
 *  如果发生错误则回调onCompleted:函数
 */
- (void)onBeginOfSpeech
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRecordingBegin)]) {
        [self.delegate onRecordingBegin];
    }
}

/*!
 *  停止录音回调<br>
 *  当调用了`stopListening`函数或者引擎内部自动检测到断点，如果没有发生错误则回调此函数。<br>
 *  如果发生错误则回调onCompleted:函数
 */
- (void)onEndOfSpeech
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRecordingEnd)]) {
        [self.delegate onRecordingEnd];
    }
}

/*!
 *  取消识别回调<br>
 *  当调用了`cancel`函数之后，会回调此函数，在调用了cancel函数和回调onCompleted之前会有一个<br>
 *  短暂时间，您可以在此函数中实现对这段时间的界面显示。
 */
- (void)onCancel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onCancel)]) {
        [self.delegate onCancel];
    }
}

@end
