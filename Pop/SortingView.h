//
//  SortingView.h
//  Pop
//
//  Created by BQHZ on 16/10/18.
//  Copyright © 2016年 BQHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZWYSearchShowViewDelegate <NSObject>

@optional

- (void)searchHotTaglibWithKeyWord:(NSString *)keyWords;
- (void)changedSortingTitle:(NSString *)title;  //传button上的值

@end


@interface SortingView : UIView

{
    id<ZWYSearchShowViewDelegate>delegate;
}
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, retain) NSMutableArray *keyWordArray;
@property (nonatomic, retain) id<ZWYSearchShowViewDelegate>delegate;
@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, strong) UIImageView *cancelBtu;
@property (nonatomic, strong) UIButton *lineView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSString *colorStr;

- (void)changeSearchKeyWord;

@end
