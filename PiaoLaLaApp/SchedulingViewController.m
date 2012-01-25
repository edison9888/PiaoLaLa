//
//  SchedulingViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SchedulingViewController.h"
#import "LoginAndRegisterViewController.h"
#import "SchedulingListViewController.h"
@implementation SchedulingViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.delegate = self;
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
    
    _titleLabel.text = [[kAppDelegate.temporaryValues objectForKey:@"moveDetail"] objectForKey:@"MOVIENAME"];
    
//    [[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"] 
//                        objectForKey:@"CINEMANAME"];
    
}

-(void)orderLogin{
    [self pushLogin:@"perLoadData"];
}

-(void)pushLogin:(NSString*)selectName{
	LoginAndRegisterViewController *controller =  (LoginAndRegisterViewController*)[kAppDelegate loadFromVC:@"LoginAndRegisterViewController"];
	controller.delegate = self;
	controller.stringSelect = selectName;
	[self.navigationController pushViewController:controller animated:YES];
}

-(void)perLoadData{
	[self.navigationController popViewControllerAnimated:NO];
    [self performSelector:@selector(pushSiteView) withObject:nil afterDelay:0.0];
}

-(void)pushSiteView{
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/SiteViewController"];
    urlAction.animated = YES;
    [[TTNavigator navigator] openURLAction:urlAction];
}

-(void)loadView{
    [super loadView];
   // NSLog(@"SchedulingViewController loadView");
    //导航条
    UIImageView *_navigationHeader = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://titlebar.png")] autorelease];
    [_navigationHeader setUserInteractionEnabled:YES];
    _navigationHeader.frame = CGRectMake(0, 0, 320, 44);
    
    //背景
    UIImageView *_backGround = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://background.png")] autorelease];
    _backGround.frame = CGRectMake(0, 0, 320, 460);
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.frame = CGRectMake(60, (22/2), 200, 22);
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_navigationHeader addSubview:_titleLabel];
    [_titleLabel release];
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button1_1.png")  forState:UIControlStateNormal];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button1_2.png")  forState:UIControlStateHighlighted];
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    _backButton.frame = CGRectMake(5, (44-29)/2, 50, 29);
    
    [_navigationHeader addSubview:_backButton];
    
    [self.view addSubview:_backGround];
    [self.view sendSubviewToBack:_backGround];
    [self.view addSubview:_navigationHeader];
    
    SchedulingListViewController * a = [kAppDelegate loadFromVC:@"SchedulingListViewController"];
    a.title = @"订座票";
    a.rootController = self;
    UIViewController * b = [kAppDelegate loadFromNib:@"PassOrderViewController"];
    b.title = @"电子通票";
    self.viewControllers = [NSArray arrayWithObjects:a,b, nil ];
}


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
