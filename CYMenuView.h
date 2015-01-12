@@ -0,0 +1,20 @@
//
//  CYMenuView.h
//  CYScircleMenu
//
//  Created by CY on 15/1/8.
//  Copyright (c) 2015年 commondec. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CYMenuDelegate <NSObject>
-(int)numbersOfItems;
-(void)didSelectedMenuItemsWithIndex:(NSInteger)index;
@end

@interface CYMenuView : UIView
@property (nonatomic)NSMutableArray * itemsArray;
@property (nonatomic)UIView * backView;
@property (nonatomic, weak) id <CYMenuDelegate> delegate;
-(void)selectedMenuItemAtIndex:(int)index;
@end
