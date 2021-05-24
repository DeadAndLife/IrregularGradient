//
//  NonLinearGradientLayer.m
//  layerShadow
//
//  Created by iOSzhang Inc on 21/5/21.
//

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#import "NonLinearGradientLayer.h"

@interface NonLinearGradientLayerConfig()

/// 根据startColor和endColor计算得出
@property(nonatomic, nullable, readwrite) NSArray *colors;

/// 根据startPoint和endPoint和计算得出
@property(nullable, readwrite) NSArray<NSNumber *> *locations;

@end

@implementation NonLinearGradientLayerConfig

/// 默认设置 LayerTypeSecondOrder pointNumber controlPoint[0.5,0.5]
+ (instancetype)defaultConfig {
    NonLinearGradientLayerConfig *config = [self new];
    config.type = LayerTypeSecondOrder;
    config.controlPoint = 0.5;
    config.pointNumber = SCREEN_W;
    return config;
}

/// 使用二阶贝塞尔计算初始化的必要参数设置
/// @param startPoint 开始点
/// @param endPoint 结束点
/// @param startColor 起始颜色
/// @param endColor 结束颜色
/// @param controlPoint 控制点
/// @param pointNumber 取点数量
- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startColor:(UIColor *)startColor endColor:(UIColor *)endColor controlPoint:(CGFloat)controlPoint pointNumber:(NSInteger)pointNumber {
    self = [super init];
    
    self.type = LayerTypeSecondOrder;
    self.startPoint = startPoint;
    self.endPoint = endPoint;
    self.startColor = startColor;
    self.endColor = endColor;
    self.controlPoint = controlPoint;
    self.pointNumber = pointNumber;
    
    return self;
}

/// 使用三阶贝塞尔计算初始化的必要参数设置
/// @param startPoint 开始点
/// @param endPoint 结束点
/// @param startColor 起始颜色
/// @param endColor 结束颜色
/// @param control1Point 控制点1
/// @param control2Point 控制点2
/// @param pointNumber 取点数量
- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startColor:(UIColor *)startColor endColor:(UIColor *)endColor control1Point:(CGFloat)control1Point control2Point:(CGFloat)control2Point pointNumber:(NSInteger)pointNumber {
    self = [super init];
    
    self.type = LayerTypeThirdOrder;
    self.startPoint = startPoint;
    self.endPoint = endPoint;
    self.startColor = startColor;
    self.endColor = endColor;
    self.control1Point = control1Point;
    self.control2Point = control2Point;
    self.pointNumber = pointNumber;
    
    return self;
}

/// 根据startColor和endColor计算得出
- (NSArray *)colors {
    CGFloat startRed, startGreen, startBlue, startAlpha, endRed, endGreen, endBlue, endAlpha, redDiff, greenDiff, blueDiff, alphaDiff;
//    BOOL startSuccess =
    [self.startColor getRed:&startRed green:&startGreen blue:&startBlue alpha:&startAlpha];
//    BOOL endSuccess =
    [self.endColor getRed:&endRed green:&endGreen blue:&endBlue alpha:&endAlpha];
    redDiff = (endRed-startRed)/self.pointNumber;
    greenDiff = (endGreen-startGreen)/self.pointNumber;
    blueDiff = (endBlue-startBlue)/self.pointNumber;
    alphaDiff = (endAlpha-startAlpha)/self.pointNumber;
    
    NSMutableArray *colorArray = [NSMutableArray array];
    for (NSInteger i=0; i<=self.pointNumber; i++) {
        UIColor *color = [UIColor colorWithRed:(startRed+redDiff*i) green:(startGreen+greenDiff*i) blue:(startBlue+blueDiff*i) alpha:(startAlpha+alphaDiff*i)];
        [colorArray addObject:(__bridge id)color.CGColor];
    }
    return colorArray;
}

/// 根据startPoint和endPoint和计算得出
- (NSArray<NSNumber *> *)locations {
    NSMutableArray <NSNumber *>*numberList = [NSMutableArray array];
    CGFloat xdif = self.endPoint.x-self.startPoint.x;
    CGFloat ydif = self.endPoint.y-self.startPoint.y;
    CGPoint controlPoint = CGPointMake(self.startPoint.x+xdif*self.controlPoint, self.startPoint.y+ydif*self.controlPoint);
    CGPoint control1Point = CGPointMake(self.startPoint.x+xdif*self.control1Point, self.startPoint.y+ydif*self.control1Point);
    CGPoint control2Point = CGPointMake(self.startPoint.x+xdif*self.control2Point, self.startPoint.y+ydif*self.control2Point);
    CGFloat difValue = pow(pow(xdif, 2)+pow(ydif, 2), 0.5);
    for (CGFloat i=0.f; i<self.pointNumber; i=i+1) {
        CGFloat t = i/self.pointNumber;
        switch (self.type) {
            case LayerTypeSecondOrder:{
                CGFloat x = pow((1-t), 2) * self.startPoint.x + 2 * (1-t) * t * controlPoint.x + pow(t, 2) * self.endPoint.x;
                CGFloat y = pow((1-t), 2) * self.startPoint.y + 2 * (1-t) * t * controlPoint.y + pow(t, 2) * self.endPoint.y;
                CGFloat result = pow(pow(x, 2)+pow(y, 2), 0.5)*difValue;
                
                [numberList addObject:@(result)];
            }
                break;
            case LayerTypeThirdOrder:{
                CGFloat x = pow((1-t), 3) * self.startPoint.x + 3 * pow((1-t), 2) * t * control1Point.x + 3 * (1-t) * pow(t, 2) * control2Point.x + pow(t, 3) * self.endPoint.x;
                CGFloat y = pow((1-t), 3) * self.startPoint.y + 3 * pow((1-t), 2) * t * control1Point.y + 3 * (1-t) * pow(t, 2) * control2Point.y + pow(t, 3) * self.endPoint.y;
                CGFloat result = pow(pow(x, 2)+pow(y, 2), 0.5)*difValue;
                
                [numberList addObject:@(result)];
            }
                break;
            default:
                break;
        }
    }
    return numberList;
}

@end

@implementation NonLinearGradientLayer

- (void)setConfig:(NonLinearGradientLayerConfig *)config {
    _config = config;
    
    self.startPoint = config.startPoint;
    self.endPoint = config.endPoint;
    self.colors = config.colors;
    self.locations = config.locations;
}

@end
