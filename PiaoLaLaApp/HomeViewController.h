//
//  HomeController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  票啦啦主页

#import "SVSegmentedControl.h"
@class ActionSheetPicker;
@interface HomeViewController : TTViewController <SVSegmentedControlDelegate>{
    UIView *contentContainerView;
    UIButton *_cityButton;
    
}
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, retain) ActionSheetPicker *actionSheetPicker;
@end
