//
//  XCAudioRecordView.h
//  XCAudioManager_Example
//
//  Created by yunjidian on 2021/11/1.
//  Copyright © 2021 fanxiaocong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCAudioRecordView : UIView

/// 显示录音的弹框
/// @param clickCompleteCallback 点击完成的回调
/// @param clickCancelCallback 点击取消的回调
+ (void)show:(void(^)(void))clickCompleteCallback cancel:(void(^)(void))clickCancelCallback;

@end
