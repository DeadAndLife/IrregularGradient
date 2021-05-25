//
//  NonLinearGradientLayer.h
//  layerShadow
//
//  Created by iOSzhang Inc on 21/5/21.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LayerTypeSecondOrder    =   0b0<<0,
    LayerTypeThirdOrder     =   0b1<<0,
    LayerTypeChangeLocation =   0b0<<1,
    LayerTypeChangeColor    =   0b1<<1,
} NonLinearGradientLayerType;

@interface NonLinearGradientLayerConfig : NSObject

@property CGPoint startPoint;
@property CGPoint endPoint;
@property UIColor *startColor;
@property UIColor *endColor;

/// 默认是 LayerTypeSecondOrder
@property NonLinearGradientLayerType type;

/// 控制点1数值[0,1] 超过该范围也行，但起止颜色和中间过渡会不对
@property CGFloat controlPoint;

/// 控制点2数值[0,1] 超过该范围也行，但起止颜色和中间过渡会不对
@property CGFloat control1Point;

/// 控制点2数值[0,1] 超过该范围也行，但起止颜色和中间过渡会不对
@property CGFloat control2Point;

/// 取点数量，越大过度色彩越自然 默认与屏幕宽相同
@property NSUInteger pointNumber;

/// 默认设置 LayerTypeSecondOrder pointNumber controlPoint[0.5,0.5]
+ (instancetype)defaultConfig;

/// 使用二阶贝塞尔计算初始化的必要参数设置
/// @param startPoint 开始点
/// @param endPoint 结束点
/// @param startColor 起始颜色
/// @param endColor 结束颜色
/// @param controlPoint 控制点
/// @param pointNumber 取点数量
- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startColor:(UIColor *)startColor endColor:(UIColor *)endColor controlPoint:(CGFloat)controlPoint pointNumber:(NSInteger)pointNumber;

/// 使用三阶贝塞尔计算初始化的必要参数设置
/// @param startPoint 开始点
/// @param endPoint 结束点
/// @param startColor 起始颜色
/// @param endColor 结束颜色
/// @param control1Point 控制点1
/// @param control2Point 控制点2
/// @param pointNumber 取点数量
- (instancetype)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startColor:(UIColor *)startColor endColor:(UIColor *)endColor control1Point:(CGFloat)control1Point control2Point:(CGFloat)control2Point pointNumber:(NSInteger)pointNumber;

/// 根据startColor和endColor计算得出
@property(nullable, readonly) NSArray *colors;

/// 根据startPoint和endPoint和计算得出
@property(nullable, readonly) NSArray<NSNumber *> *locations;

@end

@interface NonLinearGradientLayer : CAGradientLayer

/// <#Description#>
@property (nonatomic, strong) NonLinearGradientLayerConfig *config;

@end

NS_ASSUME_NONNULL_END
