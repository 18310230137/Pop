//
//  SortingView.m
//  Pop
//
//  Created by BQHZ on 16/10/18.
//  Copyright © 2016年 BQHZ. All rights reserved.
//

#import "SortingView.h"
#import "POPSpringAnimation.h"
#import "UIColor+ColorConversion.h"

#define maxKeyWord 11
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGH [UIScreen mainScreen].bounds.size.height
#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation SortingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isFirst = YES;
        self.keyWordArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.colorArray = [[NSMutableArray alloc] initWithCapacity:0];
        //#ffffff 的RGB值是{ 255.0, 23.0, 140.0 }
        self.backgroundColor = [UIColor colorWithRed:255.0 green:23.0 blue:140.0 alpha:0.8];
        
    }
    return self;
}
- (void)changeSearchKeyWord
{
    for (UIButton *button in self.subviews) {
        if (button.tag != 100) {
            [button removeFromSuperview];
        }
    }
    //随机获取10个key
    NSArray *keyWordArrayTemp = [self rondomkeyWordArray];
    NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [keyWordArrayTemp count]; i++) {
        UIButton *button = [self keyWordButtonWithTitle:[keyWordArrayTemp objectAtIndex:i] tag:i];
        [buttonArray addObject:button];
        [self addSubview:button];
    }
    NSArray *temp = [NSArray arrayWithObjects:@"F39B77", @"CBE198", @"AA8ABC", @"89C997", @"F29EC2", @"84CCC9", @"C490C0",@"7ECDF4", @"FACD89",@"8c98cc", @"F29C9F", @"ADD597", nil];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:temp];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [keyWordArrayTemp count]; i++) {
        UIButton *button = [self keyWordButtonWithTitle:[keyWordArrayTemp objectAtIndex:i] tag:i];
        int index = arc4random() % (temp.count - i);
        [resultArray addObject:[tempArray objectAtIndex:index]];
        [tempArray removeObjectAtIndex:index];
        button.backgroundColor = [UIColor colorFromHexRGB:[resultArray objectAtIndex:i]];
        [buttonArray addObject:button];
        [self addSubview:button];
    }
    NSArray *frameArray = [self keyWordButtonAnimationFrameWithButtonArray:buttonArray];
    for (UIButton *button in [self subviews]) {
        if (button.tag != 100) {
            NSInteger idx = button.tag;
            if(idx < [frameArray count]){
                NSValue *value = frameArray[idx];
                CGRect frameTemp = [value CGRectValue];
                [self showPopWithPopButton:button showPosition:frameTemp];
            }
        }
    }
    [self addCancel];
}
- (void)addCancel
{
    _lineView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _lineView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 55, [UIScreen mainScreen].bounds.size.width, 55);
    [_lineView addTarget:self action:@selector(tapCancel) forControlEvents:UIControlEventTouchUpInside];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self.window addSubview:_lineView];
    _cancelBtu = [[UIImageView alloc] init];
    _cancelBtu.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 18) / 2, 15, 18, 18);
    _cancelBtu.image = [UIImage imageNamed:@"筛选－关闭66px"];
    [_lineView addSubview:_cancelBtu];
}

//点击取消返回
- (void)tapCancel
{
    NSLog(@"取消");
    [self removeFromSuperview];
    _lineView.hidden = YES;
}
//弹出动画
- (void)showPopWithPopButton:(UIButton *)aButton showPosition:(CGRect)aRect
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    positionAnimation.fromValue = [NSValue valueWithCGRect:aButton.frame];
    positionAnimation.toValue = [NSValue valueWithCGRect:aRect];
    positionAnimation.springBounciness = 15.0f;
    positionAnimation.springSpeed = 10.0f;
    [aButton pop_addAnimation:positionAnimation forKey:@"frameAnimation"];
}
- (UIButton *)keyWordButtonWithTitle:(NSString *)aTitle tag:(NSInteger)aTag
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat button_X = [UIScreen mainScreen].bounds.size.width / 2;
    CGFloat button_Y = 64;
    
    _button.frame = CGRectMake(button_X, button_Y, 78, 78);
    [_button.layer setCornerRadius:CGRectGetHeight([_button bounds]) / 2];
    [_button setTitle:aTitle forState:UIControlStateNormal];
    
    
    [_button setTitleColor:[UIColor colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [_button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    _button.tag = aTag;
    [_button addTarget:self action:@selector(keyWordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    
    return  _button;
}
//点击keyWord button 时的事件
- (void)keyWordBtnAction:(UIButton *)aButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changedSortingTitle:)]) {
        [self.delegate changedSortingTitle:aButton.titleLabel.text];
    }
    [self removeFromSuperview];
    _lineView.hidden = YES;
    
}
#pragma mark - 获取动画的位移的frame
//获取10个位移后的frame
- (NSArray *)keyWordButtonAnimationFrameWithButtonArray:(NSArray *)aButtonArray
{
    NSMutableArray *frameArray = [[NSMutableArray alloc] initWithCapacity:0];
    //
    NSArray *rowNoArray = [self keywordRowNoArray];
    __block NSInteger count = 0;
    [rowNoArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        count += [obj intValue];
    }];
    for (NSInteger idx = 0; idx < count; idx++) {
        CGRect frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 280) / 2 + (78 + 24) * (idx%3),64 + (24 + 78) * (idx/ 3), 78, 78);
        frameArray[idx] = [NSValue valueWithCGRect:frame];
    }
    return frameArray;
}
//获取一行的三个frame  如 100 100 100
- (NSArray *)rowKeyWordButtonAnimationWithFrameArray:(NSArray *)frameArray
{
    NSMutableArray *xPointArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSInteger count = [frameArray count];
    NSLog(@"----%ld", (long)count);
    
    NSInteger totalWeight = 0;//n个frame 加起来的宽度
    for (int i = 0; i < count; i ++ ) {
        NSNumber *weight =[frameArray objectAtIndex:i];
        totalWeight += [weight floatValue];
    }
    NSInteger subWeight = SCREEN_WIDTH - totalWeight;
    if (subWeight < 0) {
        subWeight = -subWeight;
        NSInteger xTemp = (CGFloat)random() / (CGFloat)RAND_MAX * subWeight;
        NSInteger x = 0;
        for (int i = 0; i < count; i ++ ) {
            
            if (i != 0) {
                NSNumber *weight =[frameArray objectAtIndex:i - 1];
                x = x + [weight floatValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            else
            {
                x = -xTemp ;
                [xPointArray addObject:[NSNumber numberWithInteger:-xTemp]];
            }
        }
    }
    else
    {
        NSMutableArray * xTempArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < count; i ++) {
            NSInteger xTemp = (CGFloat)random() / (CGFloat)RAND_MAX * (subWeight/(count - i));//(arc4random() % subWeight) + 0;
            subWeight = subWeight - xTemp;
            [xTempArray addObject:[NSNumber numberWithInteger:xTemp]];
        }
        for (int k = 0; k < count; k ++ ) {
            
            if (k != 0) {
                
                NSNumber *x1 = [xPointArray objectAtIndex:k - 1];
                NSNumber *rondomX =[xTempArray objectAtIndex:k];
                
                NSNumber *prevWeight = [frameArray objectAtIndex:k-1];
                
                NSInteger x = [x1 integerValue] + [rondomX integerValue] + [prevWeight floatValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            else
            {
                NSInteger x = [[xTempArray objectAtIndex:0] integerValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
        }
    }
    return xPointArray;
}
- (NSArray *)keywordRowNoArray
{
    NSInteger keyWordNo = 11;//keyword个数
    NSInteger maxRow = 4;//最大行
    NSInteger minRow = 3;//最小行
    
    NSInteger row = (arc4random() % (maxRow - minRow +1)) + 3;
    
    NSInteger theMaxRowNo = 4;
    
    NSInteger maxRowNo = keyWordNo / minRow + 1;//每行的最大数
    NSInteger minRowNo = [self keyWordCGFloatToNSInteger:(keyWordNo - maxRowNo) / (CGFloat)(row - 1) -1] ;//最小行keyWord个数
    NSMutableArray * rowNoArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < row; i ++ ) {
        if (i == row - 1) {
            NSInteger rowNo = keyWordNo;
            [rowNoArray addObject:[NSNumber numberWithInteger:rowNo]];
        }
        else
        {
            NSInteger rowNo = (arc4random() % 11) + 10;
            [rowNoArray addObject:[NSNumber numberWithInteger:rowNo]];
            
            keyWordNo -= rowNo;
            NSInteger maxRowNoTemp = keyWordNo - (row - i - 1) + 1;
            maxRowNo = maxRowNoTemp>theMaxRowNo?theMaxRowNo:maxRowNoTemp ;//每行的最大数
            minRowNo =  [self keyWordCGFloatToNSInteger:(keyWordNo - maxRowNo) / (CGFloat)(row - i - 1 - 1)] ;//最小行keyWord个数
        }
    }
    return rowNoArray;
}
- (NSInteger )keyWordCGFloatToNSInteger:(CGFloat)aFloat
{
    NSInteger smallInt = aFloat;
    if (aFloat - smallInt > 0) {
        return smallInt + 1;
    }
    return smallInt;
}

// 取N个不同的随机数
- (NSArray *)rondomArrayWithCount:(NSInteger)arrayCount totalCount:(NSInteger)totalCount
{
    NSMutableArray *rondomArray = [[NSMutableArray alloc] initWithCapacity:0];
    do
    {
        int random = arc4random()%totalCount +0;
        
        NSString *randomString = [NSString stringWithFormat:@"%d",random];
        
        if (![rondomArray containsObject:randomString]) {
            [rondomArray addObject:randomString];
        }
        else{
        }
        
    } while (rondomArray.count != arrayCount);
    return rondomArray;
}

//获取N个热词
- (NSArray *)rondomkeyWordArray
{
    NSArray *keyWordArray = [self.keyWordArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 11)]];
    return keyWordArray;
    
}
- (CGFloat) widthForLableWithText:(NSString *)strText fontSize:(NSInteger)fontSize
{
    CGSize constraint = CGSizeMake(CGFLOAT_MAX,20);
    CGSize size = [strText sizeWithFont: [UIFont systemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByClipping];
    float fHeight = size.width +2;
    return fHeight;
}

@end
