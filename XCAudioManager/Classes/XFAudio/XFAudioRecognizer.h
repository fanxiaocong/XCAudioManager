//
//  XCAudioRecognizer.h
//  XCAudioManager
//
//  Created by yunjidian on 2021/10/29.
//

/*
 *  备注：语音识别 🐾
 */

#import <Foundation/Foundation.h>
#import "XCAudioRecognizer.h"

@interface XFAudioRecognizer : NSObject<XCAudioRecognizer>

@property (weak, nonatomic) id<XCAudioRecognizerDelegate> delegate;

@end
