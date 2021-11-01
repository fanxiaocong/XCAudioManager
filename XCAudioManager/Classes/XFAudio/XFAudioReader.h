//
//  XFAudioReader.h
//  Pods-XCAudioManager_Example
//
//  Created by yunjidian on 2021/10/29.
//

/*
 *  备注：语音播报 🐾
 */

#import <Foundation/Foundation.h>
#import "XCAudioReader.h"

@interface XFAudioReader : NSObject<XCAudioReader>

@property (weak, nonatomic) id<XCAudioReaderDelegate> delegate;

@end
