//
//  CinemaListViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CinemaListViewController.h"
#import "AllCinemaListViewController.h"
@implementation CinemaListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.delegate = self;
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

-(void)loadView{
    [super loadView];
    
    //导航条
    UIImageView *_navigationHeader = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://titlebar.png")] autorelease];
    [_navigationHeader setUserInteractionEnabled:YES];
    _navigationHeader.frame = CGRectMake(0, 0, 320, 44);
    
    //背景
    UIImageView *_backGround = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://background.png")] autorelease];
    _backGround.frame = CGRectMake(0, 0, 320, 460);
    
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.text = @"影院选择";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0, (22/2), 320, 22);
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
    
    UIViewController * a = [kAppDelegate loadFromVC:@"AllCinemaListViewController"];
    a.title = @"全部影院";
    ((AllCinemaListViewController*)a).controller = self;
    UIViewController * b = [kAppDelegate loadFromVC:@"MyCinemaListViewController"];
    b.title = @"我去过的";
    self.viewControllers = [NSArray arrayWithObjects:a,b, nil ];
}


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
