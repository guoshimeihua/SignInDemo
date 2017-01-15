//
//  MyView.h
//  UIBezierPathTest
//
//  Created by ZHILEI YIN on 2016/12/15.
//  Copyright © 2016年 dodonew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXZSignView : UIView
@property (nonatomic, strong) NSArray *numberArray;//下面数字的数组 不设置就没有东西
@property (nonatomic, strong) UIImage *movePointImage;//移动的图标
@property (nonatomic, strong) UIImage *headerImage;//下面跟着移动的图片


/**
 设置滑条滑动到第几个

 @param value 第几个点
 */
- (void)layFormValueToValue:(NSInteger )value;

@end
