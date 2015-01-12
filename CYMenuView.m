@@ -0,0 +1,185 @@
//
//  CYMenuView.m
//  CYScircleMenu
//
//  Created by CY on 15/1/8.
//  Copyright (c) 2015年 commondec. All rights reserved.
//

#import "CYMenuView.h"
@interface CYMenuView(){
    UISwipeGestureRecognizer * recognizer;
    BOOL firstLoadFlag;
    float times;
}
@property (nonatomic)int itemsCount;
@property (nonatomic)int selectedIndex;
@end
@implementation CYMenuView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemsArray = [[NSMutableArray alloc] init];
        _selectedIndex = 0;
        firstLoadFlag = YES;
        times = 0;
    }
    return self;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    [self loadMenu];
    [self addGestures];
}
-(void)selectedMenuItemAtIndex:(int)index {
    _selectedIndex = index;
}
//添加滑动手势向上滑动和向下滑动
-(void)addGestures {
   UISwipeGestureRecognizer* recognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
   UISwipeGestureRecognizer* recognizerDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizerUp setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self addGestureRecognizer:recognizerUp];
    
    [recognizerDown setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self  addGestureRecognizer:recognizerDown];


}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizers{
    
    if(recognizers.direction==UISwipeGestureRecognizerDirectionDown) {
        
        NSLog(@"swipe down");
        //执行程序
        _selectedIndex ++;
        if (_selectedIndex == _itemsCount) {
            _selectedIndex = 0;
        }
        [self setitemsFrameAndStatus];
    }
    if(recognizers.direction==UISwipeGestureRecognizerDirectionUp) {
        
        NSLog(@"swipe up");
        //执行程序
        _selectedIndex --;
        if (_selectedIndex == -1) {
            _selectedIndex = _itemsCount -1;
        }
        [self setitemsFrameAndStatus];

    }
    
}

-(void)setitemsFrameAndStatus{
    if (self.itemsCount > 5) {
            UIButton * btn = [_itemsArray objectAtIndex:_selectedIndex];
        
            int above1 = _selectedIndex + 1 >_itemsCount - 1?_selectedIndex + 1 -_itemsCount:_selectedIndex + 1;
            UIButton * btn_A = [_itemsArray objectAtIndex:above1];
        
            int above2 = _selectedIndex + 2 >_itemsCount - 1?_selectedIndex + 2 -_itemsCount:_selectedIndex + 2;
            UIButton * btn_B = [_itemsArray objectAtIndex:above2];
        
            int below1 = _selectedIndex - 1 < 0?_selectedIndex - 1 + _itemsCount : _selectedIndex - 1;
            UIButton * btn_D = [_itemsArray objectAtIndex:below1];
        
            int below2 = _selectedIndex - 2 < 0?_selectedIndex - 2 + _itemsCount: _selectedIndex - 2;
            UIButton * btn_C = [_itemsArray objectAtIndex:below2];

        if (!firstLoadFlag) {
            [self animationsStartWithBtn:btn andFrame:CGRectMake(0, self.bounds.size.height/3, self.bounds.size.width/2-5, self.bounds.size.height/3-5) andColor:[UIColor redColor]];
            
            [self animationsStartWithBtn:btn_A andFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/6, self.bounds.size.width/4 -5 , self.bounds.size.height/6 -5) andColor:[UIColor grayColor]];
            
            [self animationsStartWithBtn:btn_B andFrame:CGRectMake(self.bounds.size.width/4*3, 0, self.bounds.size.width/4 -5, self.bounds.size.height/6-5 ) andColor:[UIColor greenColor]];
            
            [self animationsStartWithBtn:btn_D andFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height*2/3, self.bounds.size.width/4 -5, self.bounds.size.height/6-5) andColor:[UIColor blueColor]];
            
            [self animationsStartWithBtn:btn_C andFrame:CGRectMake(self.bounds.size.width/4*3, self.bounds.size.height/6*5, self.bounds.size.width/4 -5, self.bounds.size.height/6-5) andColor:[UIColor blackColor]];

        }else {
            [btn setFrame:CGRectMake(0, self.bounds.size.height/3, self.bounds.size.width/2-5, self.bounds.size.height/3-5)];
            [btn setBackgroundColor:[UIColor redColor]];
            
            [btn_A setFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/6, self.bounds.size.width/4 -5 , self.bounds.size.height/6 -5)];
            [btn_A setBackgroundColor:[UIColor grayColor]];
            
            [btn_B setFrame:CGRectMake(self.bounds.size.width/4*3, 0, self.bounds.size.width/4 -5, self.bounds.size.height/6-5 )];
            [btn_B setBackgroundColor:[UIColor greenColor]];

            
            [btn_D setBackgroundColor:[UIColor blueColor]];
            [btn_D setFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height*2/3, self.bounds.size.width/4 -5, self.bounds.size.height/6-5)];
            
            [btn_C setBackgroundColor:[UIColor blackColor]];
            [btn_C setFrame:CGRectMake(self.bounds.size.width/4*3, self.bounds.size.height/6*5, self.bounds.size.width/4 -5, self.bounds.size.height/6-5)];
            firstLoadFlag = NO;

        }
        
        
            for (int i = 0; i < _itemsCount; i ++) {
                if (i != _selectedIndex && i != above1 && i != above2 && i != below1 && i != below2) {
                    UIButton * btn = [_itemsArray objectAtIndex:i];
                    [btn setFrame:CGRectMake(self.bounds.size.width*2, self.bounds.size.height/3, 0, 0)];
                }
            }


        
    }
}
-(void)animationsStartWithBtn:(UIButton *)btn andFrame:(CGRect)frame andColor:(UIColor *)col {
//    CAShapeLayer * pathLayer = [CAShapeLayer layer];
//    pathLayer.frame = frame;
//    [pathLayer setBackgroundColor:col.CGColor];
//    [btn.layer addSublayer:pathLayer];
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 1.0;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    [UIView animateWithDuration:0.4 animations:^{
        [btn setFrame:frame];
        [btn setBackgroundColor:col];
        //btn.layer.speed = 0;
        //btn.layer.timeOffset = times;
    }];
    
    
    
}


-(void)loadMenu {
    if ([self.delegate respondsToSelector:@selector(numbersOfItems)]) {
        self.itemsCount = [self.delegate numbersOfItems];

    }
    
    
    self.itemsCount = [self.delegate numbersOfItems];
    if (_itemsArray.count > 0) {
        return;
    }
    
    for (int i = 0; i < self.itemsCount; i ++) {
        UIButton * button = [[UIButton alloc] init];
        [button setTag:1000+i];
        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [_itemsArray addObject:button];
        [self addSubview:button];
    }
    [self setitemsFrameAndStatus];
    
    
}

@end
