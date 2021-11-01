//
//  XCAudioManager.h
//  Pods-XCAudioManager_Example
//
//  Created by yunjidian on 2021/10/29.
//

#import <Foundation/Foundation.h>
#import "XCAudioReader.h"
#import "XCAudioRecognizer.h"

@interface XCAudioManager : NSObject

/// 语音阅读
@property (strong, nonatomic, readonly) id<XCAudioReader> reader;
/// 语音识别
@property (strong, nonatomic, readonly) id<XCAudioRecognizer> recognizer;

+ (instancetype)shared;

/**
 *  初始化
 *
 *  @param appKey 第三方SDK的AppKey
 *  @param language 语言
 */
- (void)initialized:(NSString *)appKey language:(XCAudioLanguage)language;

@end
