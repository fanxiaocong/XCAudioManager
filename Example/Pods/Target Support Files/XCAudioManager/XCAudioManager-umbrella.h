#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "XCAudioHeader.h"
#import "XCAudioManager.h"
#import "XCAudioReader.h"
#import "XCAudioRecognizer.h"
#import "XFAudioReader.h"
#import "XFAudioRecognizer.h"

FOUNDATION_EXPORT double XCAudioManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char XCAudioManagerVersionString[];

