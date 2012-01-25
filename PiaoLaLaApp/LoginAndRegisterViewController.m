//
//  LoginAndRegisterViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoginAndRegisterViewController.h"

static const NSInteger TAG_OFFSET = 1000;
@implementation LoginAndRegisterViewController
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize stringSelect = _stringSelect;
@synthesize delegate = _delegate;

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_stringSelect);
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin) name:@"userLogin" object:nil];
    }
    return self;
}

-(void) loadView{
	[super loadView];
    //导航条
    UIImageView *_navigationHeader = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://titlebar.png")] autorelease];
    [_navigationHeader setUserInteractionEnabled:YES];
    _navigationHeader.frame = CGRectMake(0, 0, 320, 44);
    //背景
    UIImageView *_backGround = [[[UIImageView alloc] 
                                 initWithImage:TTIMAGE(@"bundle://background.png")] autorelease];
    _backGround.frame = CGRectMake(0, 0, 320, 460);
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button1_1.png")  forState:UIControlStateNormal];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button1_2.png")  forState:UIControlStateHighlighted];
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    _backButton.frame = CGRectMake(5, (44-29)/2, 50, 29);
    
    [_navigationHeader addSubview:_backButton];
    
    SVSegmentedControl * _redSC = [[SVSegmentedControl alloc] 
                                   initWithSectionTitles:[NSArray arrayWithObjects:@"登 录", @"注 册", nil]];
    _redSC.delegate = self;
    _redSC.thumb.shadowColor = [UIColor clearColor];
    _redSC.selectedIndex = 0;
    
    [_navigationHeader addSubview:_redSC];
	_redSC.center = _navigationHeader.center;
    
    [self.view addSubview:_backGround];
    [self.view sendSubviewToBack:_backGround];
    [self.view addSubview:_navigationHeader];
    
    //初始化切页视图
    _selectedIndex = NSNotFound;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGRect rect = CGRectMake(0, 64, self.view.bounds.size.width, 371);
    contentContainerView = [[UIView alloc] initWithFrame:rect];
	contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:contentContainerView];
    
    self.viewControllers = [NSArray arrayWithObjects:
                            [kAppDelegate loadFromVC:@"LoginViewController"],
                            [kAppDelegate loadFromVC:@"RegisterViewController"], nil ];
}


-(void)userLogin{
    if (self.delegate&&TTIsStringWithAnyText(self.stringSelect)) {
        [self.delegate performSelector:NSSelectorFromString(self.stringSelect)];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}


- (void)setViewControllers:(NSArray *)newViewControllers{
    NSAssert([newViewControllers count] >= 2, @"MHTabBarController requires at least two view controllers");
    
	UIViewController *oldSelectedViewController = self.selectedViewController;
    
	// Remove the old child view controllers.
	for (UIViewController *viewController in _viewControllers)
	{
		//[viewController willMoveToParentViewController:nil];
		//[viewController removeFromParentViewController];
	}
    
	_viewControllers = [newViewControllers copy];
    
	// This follows the same rules as UITabBarController for trying to
	// re-select the previously selected view controller.
	NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
	if (newIndex != NSNotFound)
		_selectedIndex = newIndex;
	else if (newIndex < [_viewControllers count])
		_selectedIndex = newIndex;
	else
		_selectedIndex = 0;
    
	// Add the new child view controllers.
	for (UIViewController *viewController in _viewControllers)
	{
		//[self addChildViewController:viewController];
		//[viewController didMoveToParentViewController:self];
	}
    
	NSUInteger lastIndex = 0;
	_selectedIndex = NSNotFound;
	self.selectedIndex = lastIndex;
}

- (void)reloadTabButtons
{
	// Force redraw of the previously active tab.
	NSUInteger lastIndex = _selectedIndex;
	_selectedIndex = NSNotFound;
	self.selectedIndex = lastIndex;
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex
{
	NSAssert(newSelectedIndex < [self.viewControllers count], @"View controller index out of bounds");
	if (![self isViewLoaded])
	{
		_selectedIndex = newSelectedIndex;
	}
	else if (_selectedIndex != newSelectedIndex)
	{
		UIViewController *fromViewController=nil;
		UIViewController *toViewController=nil;
        
		if (_selectedIndex != NSNotFound)
		{
			fromViewController = self.selectedViewController;
		}
        
		NSUInteger oldSelectedIndex = _selectedIndex;
		_selectedIndex = newSelectedIndex;
        
		if (_selectedIndex != NSNotFound)
		{
			toViewController = self.selectedViewController;
		}
        
		if (toViewController == nil)  // don't animate
		{
			[fromViewController.view removeFromSuperview];
		}
		else if (fromViewController == nil)  // don't animate
		{
			toViewController.view.frame = contentContainerView.bounds;
			[contentContainerView addSubview:toViewController.view];
            [toViewController viewWillAppear:YES];
            [toViewController viewDidAppear:YES];
		}
		else
		{
			CGRect rect = contentContainerView.bounds;
			if (oldSelectedIndex < newSelectedIndex)
				rect.origin.x = rect.size.width;
			else
				rect.origin.x = -rect.size.width;
            
			toViewController.view.frame = rect;
            [contentContainerView addSubview:toViewController.view];
             [toViewController viewWillAppear:YES];
            [UIView animateWithDuration:0.3 
                                  delay:0.0 
                                options:UIViewAnimationOptionLayoutSubviews 
                             animations:^{
                                 CGRect rects = fromViewController.view.frame;
                                 if (oldSelectedIndex < newSelectedIndex)
                                     rects.origin.x = -rects.size.width;
                                 else
                                     rects.origin.x = rects.size.width;
                                 
                                 fromViewController.view.frame = rects;
                                 toViewController.view.frame = contentContainerView.bounds;
                             } completion:^(BOOL finished){
                                 [fromViewController.view removeFromSuperview];
                                 [toViewController viewDidAppear:YES];
                             }];
		}
	}
}

- (UIViewController *)selectedViewController
{
	if (self.selectedIndex != NSNotFound)
		return [self.viewControllers objectAtIndex:self.selectedIndex];
	else
		return nil;
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController
{
	NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
	if (index != NSNotFound)
		self.selectedIndex = index;
}


- (void)segmentedControl:(SVSegmentedControl*)segmentedControl didSelectIndex:(NSUInteger)index{
    self.selectedIndex = index;
}

@end
