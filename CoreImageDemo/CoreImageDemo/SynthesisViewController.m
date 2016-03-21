//
//  SynthesisViewController.m
//  CoreImageDemo
//
//  Created by Cocoa Lee on 16/3/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "SynthesisViewController.h"

@interface SynthesisViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImageView *secondImageView;
@property (nonatomic,strong) UIImageView *thirdImageView;
@property (nonatomic,assign) CGAffineTransform transform;
@property (nonatomic,assign) CGFloat rotation;


@end

@implementation SynthesisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initView];
}



- (void) initData {
    
}

- (void) initView {
    self.view.backgroundColor         = [UIColor whiteColor];
    UIImageView *imageView            = [UIImageView new];
    imageView.image                   = [UIImage imageNamed:@"demo.jpg"];
    imageView.frame                   = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * (200/317.0));
    [self.view addSubview:imageView];
    _imageView                        = imageView;
    _imageView.userInteractionEnabled = YES;
    _imageView.clipsToBounds          = YES;
    
    
    UIImageView *secondImageView = [UIImageView new];
    secondImageView.image        = [UIImage imageNamed:@"demo2.png"];
    secondImageView.frame        = CGRectMake(50, 50, 120,120);
    secondImageView.layer.borderWidth       = 1;
    secondImageView.layer.borderColor       = [UIColor grayColor].CGColor;
    [imageView  addSubview:secondImageView];
    _secondImageView                        = secondImageView;
    _secondImageView.userInteractionEnabled = YES;
    
    
    UIPanGestureRecognizer * panGestureRecognizer =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [secondImageView addGestureRecognizer:panGestureRecognizer];

    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePinch:)];
    [secondImageView addGestureRecognizer:pinchGestureRecognizer];

    UIRotationGestureRecognizer *rotateRecognizer    = [[UIRotationGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(handleRotate:)];
    [secondImageView addGestureRecognizer:rotateRecognizer];
    
    UIButton *button       = [UIButton new];
    button.center          = CGPointMake(CGRectGetWidth(self.view.bounds)/2.0,CGRectGetHeight(self.view.bounds)-100);
    button.bounds          = CGRectMake(0, 0, 90, 44);
    [button setTitle:@"合成" forState:normal];
    button.backgroundColor = [UIColor brownColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(heCheng) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *thirdImageView = [UIImageView new];
    thirdImageView.frame        = CGRectMake(0, CGRectGetHeight(_imageView.bounds)+64, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * (200/317.0));
    [self.view addSubview:thirdImageView];
    _thirdImageView             = thirdImageView;
}

- (void)heCheng {
    UIImage *img          = [self addImage:_imageView.image toImage:_secondImageView.image];
    _thirdImageView.image = img;

}


- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:recognizer.view];
   [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
//    NSLog(@"Pan Frame : %@",NSStringFromCGRect(_secondImageView.frame));

}


- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    CGFloat scale = [recognizer scale];
    [recognizer.view setTransform:CGAffineTransformScale(recognizer.view.transform, scale, scale)];
    [recognizer setScale:1.0];
//    NSLog(@"Pinch Frame : %@",NSStringFromCGRect(_secondImageView.frame));
    NSLog(@"scale :%f",scale);

   
}

- (void) handleRotate:(UIRotationGestureRecognizer*) recognizer
{
    CGFloat rotation = [recognizer rotation];
    [recognizer.view setTransform:CGAffineTransformRotate(recognizer.view.transform, rotation)];
    [recognizer setRotation:0];
    NSLog(@"rotation :%f",rotation);
    NSLog(@"rotate Frame : %@",NSStringFromCGRect(_secondImageView.frame));
    _rotation = rotation;
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    

    
    
    
    
    //后期合成
    UIGraphicsBeginImageContext(_imageView.bounds.size);

    [image1 drawInRect:CGRectMake(0, 0, _imageView.bounds.size.width, _imageView.bounds.size.height)];
    
    [image2 drawInRect:CGRectMake(_secondImageView.frame.origin.x, _secondImageView.frame.origin.y, CGRectGetWidth(_secondImageView.frame),CGRectGetHeight(_secondImageView.frame))];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
