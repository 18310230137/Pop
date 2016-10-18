//
//  ViewController.h
//  Pop
//
//  Created by BQHZ on 16/10/17.
//  Copyright © 2016年 BQHZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortingView.h"

@interface ViewController : UIViewController<ZWYSearchShowViewDelegate>

@property (nonatomic, retain) UIButton *screeningButton; //筛选按钮
@property (nonatomic, strong) SortingView *sortingView; //分类视图类

@end

