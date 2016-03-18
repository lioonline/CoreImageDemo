//
//  ViewController.m
//  CoreImageDemo
//
//  Created by Cocoa Lee on 16/3/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *categoryArray;
@property (nonatomic,strong)NSArray *classNameArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
    [self initView];
    
    
}
- (void)initData {
    _categoryArray = @[@"滤镜",@"图片合成",@"视频在线播放"];
    _classNameArray = @[@"FilterViewController",@"SynthesisViewController",@"VideoViewController"];
}

- (void)initView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-20) style:UITableViewStylePlain];
    tableView.delegate     = self;
    tableView.dataSource   = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _categoryArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text   = _categoryArray[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *stringClassName = _classNameArray[indexPath.row];
    Class vc                  = NSClassFromString(stringClassName);
    UIViewController *pushVC  = [vc new];
    [self.navigationController pushViewController:pushVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
