//
//  XCAudioReader.h
//  Pods
//
//  Created by yunjidian on 2021/10/29.
//

#import <Foundation/Foundation.h>
#import "XCAudioHeader.h"

@protocol XCAudioReaderDelegate <NSObject>

@optional

/// 开始阅读
- (void)onReadingBegin;

/// 缓冲进度回调
/// @param progress 缓冲进度，0-100
- (void)onBufferProgress:(NSInteger)progress;

/// 阅读进度回调
/// @param progress 缓冲进度，0-100
- (void)onReadingProgress:(NSInteger)progress;

/// 结束的回调
/// @param error 错误
- (void)onReadingCompleted:(NSError *)error;

@end



@protocol XCAudioReader <NSObject>

@required

/**
 *  初始化
 */
- (instancetype)initWithLanguage:(XCAudioLanguage)language;


@optional

/// 回调代理
@property (weak, nonatomic) id<XCAudioReaderDelegate> delegate;

/// 开始阅读
/// @param text 文本
- (void)startReading:(NSString *)text;

/// 停止阅读
- (void)stopReading;

/// 恢复阅读
- (void)resumeReading;

/// 暂停阅读
- (void)pauseReading;

@end
