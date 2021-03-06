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

#pragma mark - π¬ π Action Method π

/// εΌε§
- (IBAction)start:(id)sender
{
    id<XCAudioRecognizer> recognizer = [XCAudioManager shared].recognizer;
    [recognizer startListening];
}

/// η»ζ
- (IBAction)end:(id)sender
{
    id<XCAudioRecognizer> recognizer = [XCAudioManager shared].recognizer;
    [recognizer stopListening];
}

#pragma mark - π π XCAudioReaderDelegate π

/// εΌε§ε½ι³ηεθ°
/// ε½θ°η¨δΊ startListening ε½ζ°εοΌε¦ζζ²‘ζεηιθ――εδΌεθ°ζ­€ε½ζ°οΌε¦ζεηιθ――εεθ° onCompleted: ε½ζ°
- (void)onRecordingBegin
{
    NSLog(@"*** onRecordingBegin ***");
}

/// εζ­’ε½ι³ηεθ°
/// ε½θ°η¨δΊ stopListening ε½ζ°εοΌε¦ζζ²‘ζεηιθ――εδΌεθ°ζ­€ε½ζ°οΌε¦ζεηιθ――εεθ° onCompleted: ε½ζ°
- (void)onRecordingEnd
{
    NSLog(@"*** onRecordingEnd ***");
}

/// ε¨ε½ι³θΏη¨δΈ­οΌι³ιεεηεθ°
/// @param volume ι³ιοΌ0~30οΌ
- (void)onVolumeChanged:(NSInteger)volume
{
    
}

/// εζΆθ―ε«ηεθ°
/// ε½θ°η¨δΊ cancel ε½ζ°εοΌδΌεθ°ζ­€ε½ζ°
- (void)onCancel
{
    
}

/// θ―ε«η»ζεθ°
/// @param result θ―ε«η»ζ
/// @param error ιθ――
- (void)onCompleted:(NSString *)result error:(NSError *)error
{
    if (!error) {
        self.resultLB.text = [NSString stringWithFormat:@"%@%@", self.resultLB.text, result];
    }
    
    NSLog(@"*** onCompleted ***");
}

@end
