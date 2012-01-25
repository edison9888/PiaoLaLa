//
//  HomeController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "ActionSheetPicker.h"
#import "HotMoveViewController.h"
#import "ComingMoveViewController.h"
#import "LoginAndRegisterViewController.h"
static const NSInteger TAG_OFFSET = 1000;

@interface HomeViewController()
-(void)reloadTabButtons;
@end

@implementation HomeViewController

@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize actionSheetPicker = _actionSheetPicker;
-(void) dealloc{
    self.actionSheetPicker = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //set up data
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
    UIImageView *_backGround = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://background.png")] autorelease];
    _backGround.frame = CGRectMake(0, 0, 320, 460);
    //底部
    UIImageView *_footerBar = [[[UIImageView alloc] initWithImage:[TTIMAGE(@"bundle://footer_bg.png") 
                                        stretchableImageWithLeftCapWidth:1 topCapHeight:0]] autorelease];
    [_footerBar setUserInteractionEnabled:YES];
    _footerBar.frame = CGRectMake(0, 415, 320, 45);
    
    UIButton *_moveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moveButton setImage:TTIMAGE(@"bundle://footer_icon1_1.png")  forState:UIControlStateNormal];
    [_moveButton setImage:TTIMAGE(@"bundle://footer_icon1_2.png")  forState:UIControlStateHighlighted];
    [_moveButton addTarget:self action:@selector(moveAction) forControlEvents:UIControlEventTouchUpInside];
    _moveButton.frame = CGRectMake(100, 3, 44, 41);
    
    UIButton *_cinemaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cinemaButton setImage:TTIMAGE(@"bundle://footer_icon2_1.png")  forState:UIControlStateNormal];
    [_cinemaButton setImage:TTIMAGE(@"bundle://footer_icon2_2.png")  forState:UIControlStateHighlighted];
    [_cinemaButton addTarget:self action:@selector(cinemaAction) forControlEvents:UIControlEventTouchUpInside];
    _cinemaButton.frame = CGRectMake(180, 3, 44, 41);
    
    UIButton *_userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_userButton setImage:TTIMAGE(@"bundle://footer_icon3_1.png")  forState:UIControlStateNormal];
    [_userButton setImage:TTIMAGE(@"bundle://footer_icon3_2.png")  forState:UIControlStateHighlighted];
    [_userButton addTarget:self action:@selector(userAction) forControlEvents:UIControlEventTouchUpInside];
    _userButton.frame = CGRectMake(260, 3, 44, 41);
    
    _cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_cityButton setBackgroundImage:TTIMAGE(@"bundle://button2_1.png")  forState:UIControlStateNormal];
    [_cityButton setBackgroundImage:TTIMAGE(@"bundle://button2_2.png")  forState:UIControlStateHighlighted];
    [_cityButton addTarget:self action:@selector(cityChoose) forControlEvents:UIControlEventTouchUpInside];
    _cityButton.titleEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 0);
    _cityButton.frame = CGRectMake(10, 10, 85, 29);
    [_cityButton setTitle:[[kAppDelegate.temporaryValues objectForKey:@"selectCity"] 
                           objectForKey:@"CITYNAME"] forState:UIControlStateNormal];
    
    [_footerBar addSubview:_cityButton];
    [_footerBar addSubview:_moveButton];
    [_footerBar addSubview:_cinemaButton];
    [_footerBar addSubview:_userButton];
    
    SVSegmentedControl * _redSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"正在热映", @"即将上映", nil]];
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
    
    HotMoveViewController *_controller = [kAppDelegate loadFromVC:@"HotMoveViewController"];
    _controller.home = self;
    
    ComingMoveViewController *_controller1 = [kAppDelegate loadFromVC:@"ComingMoveViewController"];
    _controller1.home = self;
    
    self.viewControllers = [NSArray arrayWithObjects:_controller,_controller1, nil ];
    
    [self.view addSubview:_footerBar];
    [self.view bringSubviewToFront:_footerBar];
    
    
    
    UIButton *_doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneButton setBackgroundImage:TTIMAGE(@"bundle://tag1_button.png") forState:UIControlStateNormal];
    [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
    _doneButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _doneButton.frame = CGRectMake(10, 271, 73, 29);
    [_doneButton addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self getCityData];
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
    [kAppDelegate.temporaryValues removeObjectForKey:@"order"];
}

-(void)moveAction{
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/MoveListViewController"];
	urlAction.animated = YES;
	[[TTNavigator navigator] openURLAction:urlAction];
}

//票啦啦
-(void)userAction{
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/UserHomeViewController"];
	urlAction.animated = YES;
	[[TTNavigator navigator] openURLAction:urlAction];   
}

//影院选择
-(void)cinemaAction{
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/CinemaListViewController"];
	urlAction.animated = YES;
	[[TTNavigator navigator] openURLAction:urlAction];  
}

//城市选择按钮
-(void)cityChoose{
   self.actionSheetPicker = [ActionSheetPicker showPickerWithTitle:@"选择城市" 
                                      rows:[NSArray arrayWithObjects:
                                            [NSArray arrayWithObjects:@"test",@"test",nil],
                                            [NSArray arrayWithObjects:@"test",@"test",nil],nil] initialSelection:0
                                  delegate:self onSuccess:@selector(itemWasSelected::) origin:self.view];
}



//确定城市选择
- (void)itemWasSelected:(NSNumber *)selectedIndex:(id)element {
   
    [_cityButton setTitle:[[kAppDelegate.temporaryValues objectForKey:@"selectCity"] 
                           objectForKey:@"CITYNAME"] forState:UIControlStateNormal];
    [self getCityData];
    
   
}

-(void)getPaiqi{
    //    //海报选中
    [kAppDelegate HUDShow:@"查询中" yOffset:@"0"];
    //    //请求详情
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    
    [postData setObject:@"0805" forKey:@"OP"];
    
    [postData setObject:[[kAppDelegate.temporaryValues objectForKey:@"selectCity"] 
                         objectForKey:@"CITYCODE"]
                 forKey:@"CITYCODE"];//影片ID
    
    [postData setObject:@"0"
                 forKey:@"START"];
    
    [postData setObject:@"2"
                 forKey:@"END"];
    
    ASIHTTPRequest *detailRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
    
    [detailRequest setRequestMethod:@"POST"];
    [detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
                                 [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
    [postData release];
    [detailRequest setDelegate:self];
    detailRequest.didFinishSelector = @selector(paiqiFinsh:);
    detailRequest.didFailSelector = @selector(failUpdata:);
    [detailRequest startAsynchronous];
}

-(void)paiqiFinsh:(ASIHTTPRequest *)request{
    [kAppDelegate HUDHide];
    NSDictionary *json = [[JSONDecoder decoder] 
                          objectWithData:[request responseData]];
    [kAppDelegate.temporaryValues setObject:json forKey:@"0805"];
}

-(void)getCityData{
    //海报选中
    [kAppDelegate HUDShow:@"查询中" yOffset:@"0"];
    //请求详情
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    
    [postData setObject:@"0801" forKey:@"OP"];
    
    
    //    NSLog(@"MOVIECODE1 %@",[[[interestingPhotosDictionary objectForKey:@"list"]
    //                             objectAtIndex:_posterCarousel.currentItemIndex] 
    //                            objectForKey:@"MOVIECODE"]);
    
    
    
    [postData setObject:[[kAppDelegate.temporaryValues objectForKey:@"selectCity"] 
                         objectForKey:@"CITYCODE"]
                 forKey:@"CITYCODE"];//影片ID
    
    ASIHTTPRequest *detailRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
    
    [detailRequest setRequestMethod:@"POST"];
    [detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
                                 [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
    [postData release];
    [detailRequest setDelegate:self];
    detailRequest.didFinishSelector = @selector(cityFinishUpdata:);
    detailRequest.didFailSelector = @selector(failUpdata:);
    [detailRequest startAsynchronous];
}

-(void)cityFinishUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
    NSDictionary *json = [[JSONDecoder decoder] 
                                      objectWithData:[request responseData]];
    //NSLog(@"city %@",json);
    if ([[json objectForKey:@"RESULTCODE"] isEqualToString:@"0"]){
        [kAppDelegate.temporaryValues setObject:[json objectForKey:@"FIRMS"]
                                             forKey:@"cityMoveData"];
        [self getPaiqi];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cityChange" object:nil];
    }else{
       [kAppDelegate alert:@"错误" message:@"影院数据获取失败"]; 
    }

}

-(void)failUpdata{
    [kAppDelegate HUDHide];
    [kAppDelegate alert:@"错误" message:@"影院数据获取失败"];
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


-(void)pushLogin:(NSString*)selectName{
    LoginAndRegisterViewController *controller =  (LoginAndRegisterViewController*)[kAppDelegate loadFromVC:@"LoginAndRegisterViewController"];
	controller.delegate = self;
	controller.stringSelect = selectName;
	[self.navigationController pushViewController:controller animated:YES];
}

-(void)getUserData{
    [self.navigationController popViewControllerAnimated:NO];
    [kAppDelegate.temporaryValues setObject:@"1" forKey:@"order" ];
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/CinemaListViewController"];
    urlAction.animated = YES;
    [[TTNavigator navigator] openURLAction:urlAction];
}

@end
