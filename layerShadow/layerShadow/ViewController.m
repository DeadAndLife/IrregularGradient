//
//  ViewController.m
//  layerShadow
//
//  Created by iOSzhang Inc on 21/5/21.
//

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define maxNumer (10)

#import "ViewController.h"
#import "NonLinearGradientLayer.h"

@interface ViewController ()

/// <#Description#>
@property (nonatomic, strong) UILabel *layerLabel;

@property (nonatomic, strong) UISlider *layerSlider;

/// <#Description#>
@property (nonatomic, strong) UIView *layerView;

/// <#Description#>
@property (nonatomic, strong) NonLinearGradientLayer *gradientLayer;

/// <#Description#>
@property (nonatomic, strong) UIView *layer2View;

/// <#Description#>
@property (nonatomic, strong) NonLinearGradientLayer *gradient2Layer;

/// <#Description#>
@property (nonatomic, strong) UILabel *layer2Label1;

@property (nonatomic, strong) UISlider *layer2Slider1;

/// <#Description#>
@property (nonatomic, strong) UILabel *layer2Label2;

@property (nonatomic, strong) UISlider *layer2Slider2;

/// <#Description#>
@property (nonatomic, strong) UILabel *layer3Label;

@property (nonatomic, strong) UISlider *layer3Slider;

/// <#Description#>
@property (nonatomic, strong) UIView *layer3View;

/// <#Description#>
@property (nonatomic, strong) NonLinearGradientLayer *gradient3Layer;

/// <#Description#>
@property (nonatomic, strong) UIView *layer4View;

/// <#Description#>
@property (nonatomic, strong) NonLinearGradientLayer *gradient4Layer;

/// <#Description#>
@property (nonatomic, strong) UILabel *layer4Label1;

@property (nonatomic, strong) UISlider *layer4Slider1;

/// <#Description#>
@property (nonatomic, strong) UILabel *layer4Label2;

@property (nonatomic, strong) UISlider *layer4Slider2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];

    self.layerLabel = [[UILabel alloc] init];
    self.layerLabel.text = @"0.8";
    self.layerLabel.frame = CGRectMake(50, 30, SCREEN_W-100, 20);
    
    self.layerSlider = [[UISlider alloc] init];
    self.layerSlider.frame = CGRectMake(50, CGRectGetMaxY(self.layerLabel.frame), SCREEN_W-100, 20);
    [self.layerSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.layerView = [[UIView alloc] init];
    self.layerView.frame = CGRectMake(0, CGRectGetMaxY(self.layerSlider.frame)+10, SCREEN_W, 75);
    self.gradientLayer = [NonLinearGradientLayer layer];
    self.gradientLayer.frame = CGRectMake(0,0,SCREEN_W,75);
    NonLinearGradientLayerConfig *config =
    [[NonLinearGradientLayerConfig alloc]
     initWithStartPoint:CGPointMake(0, 0)
     endPoint:CGPointMake(1, 0.5)
     startColor:[[UIColor redColor] colorWithAlphaComponent:0.4f]
     endColor:[[UIColor blueColor] colorWithAlphaComponent:0.9f]
     controlPoint:0.8
     pointNumber:SCREEN_W];
    self.gradientLayer.config = config;
    [self.layerView.layer addSublayer:self.gradientLayer];
    
    self.layer2Label1 = [[UILabel alloc] init];
    self.layer2Label1.text = @"0.8";
    self.layer2Label1.frame = CGRectMake(50, CGRectGetMaxY(self.layerView.frame)+20, SCREEN_W-100, 20);
    
    self.layer2Slider1 = [[UISlider alloc] init];
    self.layer2Slider1.frame = CGRectMake(50, CGRectGetMaxY(self.layer2Label1.frame), SCREEN_W-100, 20);
    [self.layer2Slider1 addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.layer2Label2 = [[UILabel alloc] init];
    self.layer2Label2.text = @"0.8";
    self.layer2Label2.frame = CGRectMake(50, CGRectGetMaxY(self.layer2Slider1.frame)+8, SCREEN_W-100, 20);
    
    self.layer2Slider2 = [[UISlider alloc] init];
    self.layer2Slider2.frame = CGRectMake(50, CGRectGetMaxY(self.layer2Label2.frame), SCREEN_W-100, 20);
    [self.layer2Slider2 addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.layer2View = [[UIView alloc] init];
    self.layer2View.frame = CGRectMake(0, CGRectGetMaxY(self.layer2Slider2.frame)+10, SCREEN_W, 75);
    self.gradient2Layer = [NonLinearGradientLayer layer];
    self.gradient2Layer.frame = CGRectMake(0,0,SCREEN_W,75);
    NonLinearGradientLayerConfig *config2 =
    [[NonLinearGradientLayerConfig alloc]
     initWithStartPoint:CGPointMake(0, 0)
     endPoint:CGPointMake(1, 0.5)
     startColor:[[UIColor redColor] colorWithAlphaComponent:0.4f]
     endColor:[[UIColor blueColor] colorWithAlphaComponent:0.9f]
     control1Point:0.8
     control2Point:0.8
     pointNumber:SCREEN_W];
    self.gradient2Layer.config = config2;
    [self.layer2View.layer addSublayer:self.gradient2Layer];
    
    self.layer3Label = [[UILabel alloc] init];
    self.layer3Label.text = @"0.8";
    self.layer3Label.frame = CGRectMake(50, CGRectGetMaxY(self.layer2View.frame)+20, SCREEN_W-100, 20);
    
    self.layer3Slider = [[UISlider alloc] init];
    self.layer3Slider.frame = CGRectMake(50, CGRectGetMaxY(self.layer3Label.frame), SCREEN_W-100, 20);
    [self.layer3Slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.layer3View = [[UIView alloc] init];
    self.layer3View.frame = CGRectMake(0, CGRectGetMaxY(self.layer3Slider.frame)+10, SCREEN_W, 75);
    self.gradient3Layer = [NonLinearGradientLayer layer];
    self.gradient3Layer.frame = CGRectMake(0,0,SCREEN_W,75);
    NonLinearGradientLayerConfig *config3 =
    [[NonLinearGradientLayerConfig alloc]
     initWithStartPoint:CGPointMake(0, 0)
     endPoint:CGPointMake(1, 0.5)
     startColor:[[UIColor redColor] colorWithAlphaComponent:0.4f]
     endColor:[[UIColor blueColor] colorWithAlphaComponent:0.9f]
     controlPoint:0.8
     pointNumber:SCREEN_W];
    config3.type = LayerTypeSecondOrder|LayerTypeChangeColor;
    self.gradient3Layer.config = config3;
    [self.layer3View.layer addSublayer:self.gradient3Layer];
    
    self.layer4Label1 = [[UILabel alloc] init];
    self.layer4Label1.text = @"0.8";
    self.layer4Label1.frame = CGRectMake(50, CGRectGetMaxY(self.layer3View.frame)+20, SCREEN_W-100, 20);
    
    self.layer4Slider1 = [[UISlider alloc] init];
    self.layer4Slider1.frame = CGRectMake(50, CGRectGetMaxY(self.layer4Label1.frame), SCREEN_W-100, 20);
    [self.layer4Slider1 addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.layer4Label2 = [[UILabel alloc] init];
    self.layer4Label2.text = @"0.8";
    self.layer4Label2.frame = CGRectMake(50, CGRectGetMaxY(self.layer4Slider1.frame)+8, SCREEN_W-100, 20);
    
    self.layer4Slider2 = [[UISlider alloc] init];
    self.layer4Slider2.frame = CGRectMake(50, CGRectGetMaxY(self.layer4Label2.frame), SCREEN_W-100, 20);
    [self.layer4Slider2 addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.layer4View = [[UIView alloc] init];
    self.layer4View.frame = CGRectMake(0, CGRectGetMaxY(self.layer4Slider2.frame)+10, SCREEN_W, 75);
    self.gradient4Layer = [NonLinearGradientLayer layer];
    self.gradient4Layer.frame = CGRectMake(0,0,SCREEN_W,75);
    NonLinearGradientLayerConfig *config4 =
    [[NonLinearGradientLayerConfig alloc]
     initWithStartPoint:CGPointMake(0, 0)
     endPoint:CGPointMake(1, 0.5)
     startColor:[[UIColor redColor] colorWithAlphaComponent:0.4f]
     endColor:[[UIColor blueColor] colorWithAlphaComponent:0.9f]
     control1Point:0.8
     control2Point:0.8
     pointNumber:SCREEN_W];
    config4.type = LayerTypeThirdOrder|LayerTypeChangeColor;
    self.gradient4Layer.config = config4;
    [self.layer4View.layer addSublayer:self.gradient4Layer];
    
    [self.view addSubview:self.layerView];
    [self.view addSubview:self.layer2View];
    [self.view addSubview:self.layerSlider];
    [self.view addSubview:self.layer2Slider1];
    [self.view addSubview:self.layer2Slider2];
    [self.view addSubview:self.layerLabel];
    [self.view addSubview:self.layer2Label1];
    [self.view addSubview:self.layer2Label2];
    [self.view addSubview:self.layer3View];
    [self.view addSubview:self.layer4View];
    [self.view addSubview:self.layer3Slider];
    [self.view addSubview:self.layer4Slider1];
    [self.view addSubview:self.layer4Slider2];
    [self.view addSubview:self.layer3Label];
    [self.view addSubview:self.layer4Label1];
    [self.view addSubview:self.layer4Label2];
    // Do any additional setup after loading the view.
}

- (IBAction)sliderChanged:(UISlider *)sender {
//    CGPoint controlPoint = CGPointMake(sender.value*2, 0);
//    [self layerLocationsProgress:sender.value*3-1];
    if (sender == self.layerSlider) {
        NonLinearGradientLayerConfig *nowConfig = self.gradientLayer.config;
        nowConfig.controlPoint = sender.value;
        self.gradientLayer.config = nowConfig;
        self.layerLabel.text = @(sender.value).stringValue;
    } else if (sender == self.layer2Slider1) {
        NonLinearGradientLayerConfig *nowConfig = self.gradient2Layer.config;
        nowConfig.control1Point = sender.value;
        self.gradient2Layer.config = nowConfig;
        self.layer2Label1.text = @(sender.value).stringValue;
    } else if (sender == self.layer2Slider2) {
        NonLinearGradientLayerConfig *nowConfig = self.gradient2Layer.config;
        nowConfig.control2Point = sender.value;
        self.gradient2Layer.config = nowConfig;
        self.layer2Label2.text = @(sender.value).stringValue;
    } else if (sender == self.layer3Slider) {
        NonLinearGradientLayerConfig *nowConfig = self.gradient3Layer.config;
        nowConfig.controlPoint = sender.value;
        self.gradient3Layer.config = nowConfig;
        self.layer3Label.text = @(sender.value).stringValue;
    } else if (sender == self.layer4Slider1) {
        NonLinearGradientLayerConfig *nowConfig = self.gradient4Layer.config;
        nowConfig.control1Point = sender.value;
        self.gradient4Layer.config = nowConfig;
        self.layer4Label1.text = @(sender.value).stringValue;
    } else if (sender == self.layer4Slider2) {
        NonLinearGradientLayerConfig *nowConfig = self.gradient4Layer.config;
        nowConfig.control2Point = sender.value;
        self.gradient4Layer.config = nowConfig;
        self.layer4Label2.text = @(sender.value).stringValue;
    }
    
}

@end
