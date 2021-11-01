//
//  XCAudioRecordView.m
//  XCAudioManager_Example
//
//  Created by yunjidian on 2021/11/1.
//  Copyright © 2021 fanxiaocong. All rights reserved.
//

#import "XCAudioRecordView.h"

@interface XCAudioButton : UIButton

@end

@implementation XCAudioButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetWidth(self.bounds));
    self.titleLabel.frame = CGRectMake(0,
                                       CGRectGetMaxY(self.imageView.bounds) + 8,
                                       CGRectGetWidth(self.bounds),
                                       CGRectGetHeight(self.bounds) - CGRectGetMaxY(self.imageView.bounds) - 8);
}

@end



@interface XCAudioRecordView ()

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) XCAudioButton *cancelButton;
@property (strong, nonatomic) XCAudioButton *enterButton;

/// 完成的回调
@property (copy, nonatomic) void(^clickCompleteCallback)(void);
/// 取消的回调
@property (copy, nonatomic) void(^clickCancelCallback)(void);

@end

@implementation XCAudioRecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}

#pragma mark - 🔓 👀 Public Method 👀

+ (void)show:(void (^)(void))clickCompleteCallback cancel:(void (^)(void))clickCancelCallback
{
    XCAudioRecordView *view = [[XCAudioRecordView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

@end
