//
//  MoveListViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  热门影片和即将上映 列表

#import "SVSegmentedControl.h"
@interface MoveListViewController : TTViewController <SVSegmentedControlDelegate>{
    UIView *contentContainerView;
}
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@end
