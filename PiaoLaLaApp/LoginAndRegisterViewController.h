//
//  LoginAndRegisterViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SVSegmentedControl.h"
@interface LoginAndRegisterViewController  : TTViewController <SVSegmentedControlDelegate>{
    UIView *contentContainerView;
    id _delegate;
    NSString *_stringSelect;
}
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSString *stringSelect;
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;

@end
