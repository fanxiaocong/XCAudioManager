//
//  XCAudioManager.m
//  Pods-XCAudioManager_Example
//
//  Created by yunjidian on 2021/10/29.
//

#import "XCAudioManager.h"
#import "iflyMSC/IFlyMSC.h"
#import "XFAudio/XFAudioReader.h"
#import "XFAudio/XFAudioRecognizer.h"

static id _instance = nil;

@implementation XCAudioManager

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)initialized:(NSString *)appKey language:(XCAudioLanguage)language
{
    /// 配置科大讯飞相关的信息
    // 设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    
    // 打开输出在console的log开关
    [IFlySetting showLogcat:NO];
    
    // 设置sdk的工作路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    // 创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", appKey];
    
    // 所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
    // 配置语音阅读
    _reader = [[XFAudioReader alloc] initWithLanguage:language];
    // 配置语音识别
    _recognizer = [[XFAudioRecognizer alloc] initWithLanguage:language];
}

@end
