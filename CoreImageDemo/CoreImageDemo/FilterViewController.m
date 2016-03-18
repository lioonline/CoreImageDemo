//
//  FilterViewController.m
//  CoreImageDemo
//
//  Created by Cocoa Lee on 16/3/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) UIPickerView   *pickerView;
@property (nonatomic,strong) UIImageView    *imageView;
@property (nonatomic,strong) NSMutableArray *filterNameArray;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initView];
}

- (void)initData {
    
    NSArray *properties = [CIFilter filterNamesInCategory: kCICategoryBlur];
    _filterNameArray    = [NSMutableArray arrayWithArray:properties];
    [_filterNameArray insertObject:@"原图" atIndex:0];
//    NSLog(@"%@", properties);
//    for (NSString *filterName in properties) {
//        CIFilter *fltr = [CIFilter filterWithName:filterName];
//        NSLog(@"%@", [fltr attributes]);
//    }
}

- (void)initView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [UIImageView new];
    imageView.image        = [UIImage imageNamed:@"demo.jpg"];
    imageView.frame        = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * (200/317.0));
    [self.view addSubview:imageView];
    _imageView = imageView;

    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate      = self;
    pickerView.dataSource    = self;
    pickerView.frame         = CGRectMake(0, self.view.center.y, CGRectGetWidth(self.view.bounds), self.view.bounds.size.height/2.0);
    [self.view addSubview:pickerView];
    _pickerView = pickerView;
}

- (NSInteger )numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger )pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
   
    return _filterNameArray.count;
}

- ( NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component  {
    return _filterNameArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"row :%ld",row);
    [self setTheFilterWithIndex:row];
}


-(void)setTheFilterWithIndex:(NSInteger)index {
    
    if (index == 0) {
        _imageView.image  = [UIImage imageNamed:@"demo.jpg"];
        return ;
    }
    //导入
    CIImage *ciImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"demo.jpg"]];
    
    //创建
    CIFilter *filter = [CIFilter filterWithName:_filterNameArray[index]];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setDefaults];

    CIImage *outImage  = [filter valueForKey:kCIOutputImageKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outImage fromRect:[outImage extent]];
    UIImage *showImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    _imageView.image   = showImage;
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
