//
//  XCViewController.m
//  XCAudioManager
//
//  Created by fanxiaocong on 10/29/2021.
//  Copyright (c) 2021 fanxiaocong. All rights reserved.
//

#import "XCViewController.h"
#import "XCAudioManager.h"

@interface XCViewController ()<XCAudioRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *resultLB;

@end

@implementation XCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    id<XCAudioRecognizer> recognizer = [XCAudioManager shared].recognizer;
    recognizer.delegate = self;
}

#pragma mark - 🎬 👀 Action Method 👀

/// 开始
- (IBAction)start:(id)sender
{
    id<XCAudioRecognizer> recognizer = [XCAudioManager shared].recognizer;
    [recognizer startListening];
}

/// 结束
- (IBAction)end:(id)sender
{
    id<XCAudioRecognizer> recognizer = [XCAudioManager shared].recognizer;
    [recognizer stopListening];
}

#pragma mark - 💉 👀 XCAudioReaderDelegate 👀

/// 开始录音的回调
/// 当调用了 startListening 函数后，如果没有发生错误则会回调此函数，如果发生错误则回调 onCompleted: 函数
- (void)onRecordingBegin
{
    NSLog(@"*** onRecordingBegin ***");
}

/// 停止录音的回调
/// 当调用了 stopListening 函数后，如果没有发生错误则会回调此函数，如果发生错误则回调 onCompleted: 函数
- (void)onRecordingEnd
{
    NSLog(@"*** onRecordingEnd ***");
}

/// 在录音过程中，音量变化的回调
/// @param volume 音量（0~30）
- (void)onVolumeChanged:(NSInteger)volume
{
    
}

/// 取消识别的回调
/// 当调用了 cancel 函数后，会回调此函数
- (void)onCancel
{
    
}

/// 识别结果回调
/// @param result 识别结果
/// @param error 错误
- (void)onCompleted:(NSString *)result error:(NSError *)error
{
    if (!error) {
        self.resultLB.text = [NSString stringWithFormat:@"%@%@", self.resultLB.text, result];
    }
    
    NSLog(@"*** onCompleted ***");
}

@end
