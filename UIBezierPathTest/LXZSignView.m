//
//  MyView.m
//  UIBezierPathTest
//
//  Created by ZHILEI YIN on 2016/12/15.
//  Copyright © 2016年 dodonew. All rights reserved.
//

#import "LXZSignView.h"
#import <QuartzCore/QuartzCore.h>

#define LLineWidth ([UIScreen mainScreen].bounds.size.width - 20 - 7*10)/6.0


#define LXZWidth [UIScreen mainScreen].bounds.size.width
#define LXZHeight [UIScreen mainScreen].bounds.size.height

#define LXZPointRadius 5
#define LXZSpace 10

@interface LXZSignView ()

@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) CAShapeLayer *roundLayer;
@property (nonatomic, strong) CALayer *imageLayer;

@end


@implementation LXZSignView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initLayer];
    }
    return self;
}

- (void)initLayer {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat pointY = CGRectGetHeight(self.frame)-50;
    [path moveToPoint:CGPointMake(LXZSpace, pointY)];
    [path addLineToPoint:CGPointMake(LXZWidth-2*LXZSpace, pointY)];
    
    // 画一条灰色的线条
    CAShapeLayer *lineBgLayer = [CAShapeLayer layer];
    lineBgLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    lineBgLayer.fillColor = [UIColor clearColor].CGColor;
    lineBgLayer.lineWidth = 2;
    lineBgLayer.lineJoin = kCALineJoinRound;
    lineBgLayer.lineCap = kCALineCapRound;
    lineBgLayer.path = path.CGPath;
    [self.layer addSublayer:lineBgLayer];
    
    // 画一条红色的线条
    _lineLayer = [CAShapeLayer layer];
    _lineLayer.strokeColor = [UIColor redColor].CGColor;
    _lineLayer.fillColor = [UIColor clearColor].CGColor;
    _lineLayer.lineWidth = 5;
    _lineLayer.lineJoin = kCALineJoinRound;
    _lineLayer.lineCap = kCALineCapRound;
    _lineLayer.path = path.CGPath;
    _lineLayer.strokeStart = 0;
    _lineLayer.strokeEnd = 0;
    [self.layer addSublayer:_lineLayer];
    
    // 创建一个圆圈
    for (int i = 0; i < 7; i ++ ) {
        UIBezierPath *pointPath = [UIBezierPath bezierPath];
        [pointPath addArcWithCenter:CGPointMake(LXZSpace+i*(LLineWidth+2*LXZPointRadius)+LXZPointRadius, pointY) radius:LXZPointRadius startAngle:0.0 endAngle:2*M_PI clockwise:YES];
        [pointPath setLineWidth:1.0];
        CAShapeLayer *pointLayer = [CAShapeLayer layer];
        pointLayer.strokeColor = [UIColor redColor].CGColor;
        pointLayer.fillColor = [UIColor whiteColor].CGColor;
        pointLayer.path = pointPath.CGPath;
        [self.layer addSublayer:pointLayer];
    }
    
    UIBezierPath *roundPath = [UIBezierPath bezierPath];
    [roundPath addArcWithCenter:CGPointMake(LXZSpace+LXZPointRadius, pointY) radius:LXZPointRadius startAngle:0.0 endAngle:2*M_PI clockwise:YES];
    [roundPath setLineWidth:10.0];
    _roundLayer = [CAShapeLayer layer];
    _roundLayer.backgroundColor = [UIColor clearColor].CGColor;
    _roundLayer.strokeColor = [UIColor clearColor].CGColor;
    _roundLayer.fillColor = [UIColor clearColor].CGColor;
    _roundLayer.path = roundPath.CGPath;
    [self.layer addSublayer:_roundLayer];
    
    UIImage *backViewImage = [UIImage imageNamed:@"sign_big_img"];
    self.layer.contents = (id )backViewImage.CGImage;
}

- (void)layFormValueToValue:(NSInteger )value {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 1;
    animation.repeatCount = 1;
    animation.fromValue = [NSValue valueWithCGPoint:_roundLayer.position];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(value*(LLineWidth + 10), 0)];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    [_roundLayer addAnimation:animation forKey:@"move-layer"];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.duration = 1;
    animation2.repeatCount = 1;
    animation2.fromValue = [NSNumber numberWithFloat:_lineLayer.strokeEnd];
    animation2.toValue = [NSNumber numberWithFloat:(_lineLayer.strokeEnd + value/6.0)];
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeBoth;
    [_lineLayer addAnimation:animation2 forKey:@"strokeEnd"];
}

#pragma mark - setter and getter 
- (void)setNumberArray:(NSArray *)numberArray {
    if (numberArray.count != 7) {
        NSLog(@"数组不对");
        return;
    }
    
    for (int i = 0; i < 7; i ++ ) {
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.frame = CGRectMake(10 + i*(LLineWidth + 10) -10, 275, 30, 11);
        [self.layer addSublayer:textLayer];
        
        textLayer.foregroundColor = [UIColor blackColor].CGColor;
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.wrapped = YES;
        
        UIFont *font = [UIFont systemFontOfSize:11];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        textLayer.font = fontRef;
        textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
    
        NSString *text = numberArray[i];
        textLayer.string = text;
    }
    [self.layer addSublayer:_roundLayer];
}

- (void)setHeaderImage:(UIImage *)headerImage {
    _imageLayer = [[CALayer alloc] init];
    _imageLayer.frame = CGRectMake(0, 270, 30, 30);
    _imageLayer.contents = (id)headerImage.CGImage;
    _imageLayer.contentsGravity = kCAGravityResizeAspect;
    _imageLayer.contentsScale = headerImage.scale;
    [_roundLayer addSublayer:_imageLayer];
}

- (void)setMovePointImage:(UIImage *)movePointImage {
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(5, 240, 20, 20);
    layer.contents = (id)movePointImage.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsScale = movePointImage.scale;
    [_roundLayer addSublayer:layer];
}

@end
