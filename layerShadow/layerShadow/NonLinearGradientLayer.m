//
//  NonLinearGradientLayer.m
//  layerShadow
//
//  Created by iOSzhang Inc on 21/5/21.
//

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#define SecondBezier(t, P0, P1, P2) pow((1-t), 2) * P0 + 2 * (1-t) * t * P1 + pow(t, 2) * P2
#define ThirdBezier(t, P0, P1, P2, P3) pow((1-t), 3) * P0 + 3 * pow((1-t), 2) * t * P1 + 3 * (1-t) * pow(t, 2) * P2 + pow(t, 3) * P3

#import "NonLinearGradientLayer.h"

@interface NonLinearGradientLayerConfig()

/// 根据startColor和endColor计算得出
@property(nonatomic, nullable, readwrite) NSArray *colors;

/// 根据startPoint和endPoint和计算得出
@property(nonatomic, nullable, readwrite) NSArray<NSNumber *> *locations;

@end

@implementation NonLinearGradientLayerConfig

/// 默认设置 LayerTypeSecondOrder pointNumber controlPoint[0.5,0.5]
+ (instancetype)defaultConfig {
    NonLinearGradientLayerConfig *config = [self new];
    config.type = LayerTypeSecondOrder|LayerTypeChangeLocation;
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
    
    self.type = LayerTypeSecondOrder|LayerTypeChangeLocation;
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
    
    self.type = LayerTypeThirdOrder|LayerTypeChangeLocation;
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
    redDiff = (endRed-startRed);
    greenDiff = (endGreen-startGreen);
    blueDiff = (endBlue-startBlue);
    alphaDiff = (endAlpha-startAlpha);

    NSMutableArray *colorArray = [NSMutableArray array];
    for (CGFloat i=0.f; i<=self.pointNumber; i=i+1) {
        CGFloat t = i/self.pointNumber;
        switch (self.type&LayerTypeChangeColor) {
            case LayerTypeChangeLocation:{
                UIColor *color = [UIColor colorWithRed:(startRed+redDiff*t) green:(startGreen+greenDiff*t) blue:(startBlue+blueDiff*t) alpha:(startAlpha+alphaDiff*t)];
                [colorArray addObject:(__bridge id)color.CGColor];
            }
                break;
            case LayerTypeChangeColor:{
                switch (self.type&LayerTypeThirdOrder) {
                    case LayerTypeSecondOrder:{
                        CGFloat controlRed = startRed+redDiff*self.controlPoint;
                        CGFloat colorRed = SecondBezier(t, startRed, controlRed, endRed);
                        CGFloat controlGreen = startGreen+greenDiff*self.controlPoint;
                        CGFloat colorGreen = SecondBezier(t, startGreen, controlGreen, endGreen);
                        CGFloat controlBlue = startBlue+blueDiff*self.controlPoint;
                        CGFloat colorBlue = SecondBezier(t, startBlue, controlBlue, endBlue);
                        CGFloat controlAlpha = startAlpha+alphaDiff*self.controlPoint;
                        CGFloat colorAlpha = SecondBezier(t, startAlpha, controlAlpha, endAlpha);

                        UIColor *color = [UIColor colorWithRed:colorRed green:colorGreen blue:colorBlue alpha:colorAlpha];
                        [colorArray addObject:(__bridge id)color.CGColor];
                    }
                        break;
                    case LayerTypeThirdOrder:{
                        CGFloat control1Red = startRed+redDiff*self.control1Point;
                        CGFloat control2Red = startRed+redDiff*self.control2Point;
                        CGFloat colorRed = ThirdBezier(t, startRed, control1Red, control2Red, endRed);
                        CGFloat control1Green = startGreen+greenDiff*self.control1Point;
                        CGFloat control2Green = startGreen+greenDiff*self.control2Point;
                        CGFloat colorGreen = ThirdBezier(t, startGreen, control1Green, control2Green, endGreen);
                        CGFloat control1Blue = startBlue+blueDiff*self.control1Point;
                        CGFloat control2Blue = startBlue+blueDiff*self.control2Point;
                        CGFloat colorBlue = ThirdBezier(t, startBlue, control1Blue, control2Blue, endBlue);
                        CGFloat control1Alpha = startAlpha+alphaDiff*self.control1Point;
                        CGFloat control2Alpha = startAlpha+alphaDiff*self.control2Point;
                        CGFloat colorAlpha = ThirdBezier(t, startAlpha, control1Alpha, control2Alpha, endAlpha);

                        UIColor *color = [UIColor colorWithRed:colorRed green:colorGreen blue:colorBlue alpha:colorAlpha];
                        [colorArray addObject:(__bridge id)color.CGColor];
                    }
                        break;
                }
            }
                break;
        }
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
        switch (self.type&LayerTypeChangeColor) {
            case LayerTypeChangeLocation:{
                switch (self.type&LayerTypeThirdOrder) {
                    case LayerTypeSecondOrder:{
                        CGFloat x = SecondBezier(t, self.startPoint.x, controlPoint.x, self.endPoint.x);
                        CGFloat y = SecondBezier(t, self.startPoint.y, controlPoint.y, self.endPoint.y);
                        CGFloat result = pow(pow(x, 2)+pow(y, 2), 0.5)*difValue;

                        [numberList addObject:@(result)];
                    }
                        break;
                    case LayerTypeThirdOrder:{
                        CGFloat x = ThirdBezier(t, self.startPoint.x, control1Point.x, control2Point.x, self.endPoint.x);
                        CGFloat y = ThirdBezier(t, self.startPoint.y, control1Point.y, control2Point.y, self.endPoint.y);
                        CGFloat result = pow(pow(x, 2)+pow(y, 2), 0.5)*difValue;

                        [numberList addObject:@(result)];
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            case LayerTypeChangeColor:{
                [numberList addObject:@(t)];
            }
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
