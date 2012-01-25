//
//  CinemaDetailViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CinemaDetailViewController.h"
#import "UIImageView+WebCache.h"

@implementation CinemaDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
      
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
    _titleLabel.text = @"影院详情";
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
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:21];
    
   // NSLog(@"SelsectCINEMA %@",[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"]);
    
    _nameLabel.text = [[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"] 
                       objectForKey:@"CINEMANAME"];
    _nameLabel.textColor = RGBCOLOR(54, 154, 255);
    _nameLabel.frame = CGRectMake(10, 55, 300, 21);
    [self.view addSubview:_nameLabel];
    [_nameLabel release];
    
//    _scoreLabel = [[TTStyledTextLabel alloc] init];
//    _scoreLabel.font = [UIFont systemFontOfSize:15];
//    _scoreLabel.backgroundColor = [UIColor clearColor];
//    _scoreLabel.textColor = RGBCOLOR(249,194,11);
//    [_scoreLabel sizeToFit];
//    _scoreLabel.text = [TTStyledText textFromXHTML:@"<span class=\"whiteText\">综合评分:</span><span class=\"largeText\">9.5</span><span class=\"smallText\">分</span>"];
//    _scoreLabel.frame = CGRectMake(200, 60, 100, 21);
//    [self.view addSubview:_scoreLabel];
//    [_scoreLabel release];
    
    _pic = [[UIImageView alloc] init];
    [_pic setImageWithURL:[NSURL URLWithString:[[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"] 
                                                objectForKey:@"CINEMAURL"]] 
         placeholderImage:TTIMAGE(@"")];
    _pic.frame = CGRectMake(10, 81, 300, 225);
    [self.view addSubview:_pic];
    [_pic release];
    
    _addressLable = [[UILabel alloc] init];
    _addressLable.font = [UIFont systemFontOfSize:15];
    _addressLable.frame = CGRectMake(10, 326, 300, 41);
    _addressLable.backgroundColor = [UIColor clearColor];
    _addressLable.numberOfLines = 2;
    _addressLable.text = [NSString stringWithFormat:@"地址:%@",[[kAppDelegate.temporaryValues 
                                                               objectForKey:@"SelsectCINEMA"] 
                                                              objectForKey:@"CINEMAADDREDSS"]];
    _addressLable.textColor = [UIColor whiteColor];
    [self.view addSubview:_addressLable];
    [_addressLable release];
    
    _phoneLable = [[UILabel alloc] init];
    _phoneLable.font = [UIFont systemFontOfSize:15];
    _phoneLable.frame = CGRectMake(10, 367, 300, 21);
    _phoneLable.backgroundColor = [UIColor clearColor];
    _phoneLable.text = [NSString stringWithFormat:@"电话:%@",[[kAppDelegate.temporaryValues 
                                                             objectForKey:@"SelsectCINEMA"] 
                                                            objectForKey:@"CINEMAPHONE"]];
    _phoneLable.textColor = [UIColor whiteColor];
    [self.view addSubview:_phoneLable];
    [_phoneLable release];
    
    _wayLable = [[UILabel alloc] init];
    _wayLable.font = [UIFont systemFontOfSize:15];
    _wayLable.frame = CGRectMake(10, 388, 300, 62);
    _wayLable.numberOfLines = 3;
    _wayLable.backgroundColor = [UIColor clearColor];
    _wayLable.text = [NSString stringWithFormat:@"行车路线:%@",[[kAppDelegate.temporaryValues 
                                                           objectForKey:@"SelsectCINEMA"] 
                                                          objectForKey:@"CINEMAWAY"]];
    _wayLable.textColor = [UIColor whiteColor];
    [self.view addSubview:_wayLable];
    [_wayLable release];
    
}


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
