//
//  ViewController.m
//  Pop
//
//  Created by BQHZ on 16/10/17.
//  Copyright © 2016年 BQHZ. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self clickedSceenButton];
    
}
//筛选按钮
- (void)clickedSceenButton
{
    //右按钮
    _screeningButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_screeningButton setFrame:CGRectMake(200, 200, 60, 40)];
    [_screeningButton setTitle:@"筛选" forState:UIControlStateNormal];
    _screeningButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_screeningButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_screeningButton addTarget:self action:@selector(didClickedSearchButtonAction) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:_screeningButton];
}
//点击筛选按钮触发的事件
- (void)didClickedSearchButtonAction
{
    _sortingView = [[SortingView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _sortingView.keyWordArray = [NSMutableArray arrayWithObjects:@"全部", @"吐槽", @"晒照", @"交友", @"萌宝", @"宠物", @"美女",@"拼车", @"活动", @"二手市场",@"其它", nil];
    _sortingView.delegate = self;
    
//    [[[UIApplication sharedApplication] delegate]window].windowLevel = 1;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_sortingView];
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    [_sortingView changeSearchKeyWord];
    
}
- (void)changedSortingTitle:(NSString *)title
{
    [_screeningButton setTitle:title forState:UIControlStateNormal];
    if ([title isEqualToString:@"全部"]) {
        NSLog(@"-----%@", title);
        
    }if ([title isEqualToString:@"吐槽"]) {
        NSLog(@"-----%@", title);
        
    }if ([title isEqualToString:@"晒照"]) {
        NSLog(@"-----%@", title);
        
    }if ([title isEqualToString:@"交友"]) {
       NSLog(@"-----%@", title);
        
    }if ([title isEqualToString:@"萌宝"]) {
        NSLog(@"-----%@", title);
        
    }if ([title isEqualToString:@"宠物"]) {
        NSLog(@"-----%@", title);
        
    }if ([title isEqualToString:@"美女"]) {
       NSLog(@"-----%@", title);
        
    }if ([title isEqualToString:@"拼车"]) {
        NSLog(@"-----%@", title);
        
    }if ([title isEqualToString:@"活动"]) {
        NSLog(@"-----%@", title);
        
    }if ([title isEqualToString:@"二手市场"]) {
        NSLog(@"-----%@", title);
        
    }if ([title isEqualToString:@"其它"]) {
        NSLog(@"-----%@", title);
        
    }
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
