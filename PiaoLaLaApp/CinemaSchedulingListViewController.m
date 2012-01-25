//
//  CinemaSchedulingListViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CinemaSchedulingListViewController.h"
#import "CinemaSchedulingDataSource.h"

@implementation CinemaSchedulingListViewController

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
    self.tableView.frame = CGRectMake(0, 44, 320, 373);
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 100;
	self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    
    //导航条
    UIImageView *_navigationHeader = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://titlebar02.png")] autorelease];
    [_navigationHeader setUserInteractionEnabled:YES];
    _navigationHeader.frame = CGRectMake(0, 0, 320, 44);
    
    //背景
    UIImageView *back = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://background02.png")];
	self.tableView.backgroundView = back;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[back release];
    
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.text = [[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"] 
                        objectForKey:@"CINEMANAME"];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.frame = CGRectMake(60, (22/2), 185, 22);
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
    
    UIButton *_detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_detailButton setBackgroundImage:TTIMAGE(@"bundle://button7_1.png")  forState:UIControlStateNormal];
    [_detailButton setBackgroundImage:TTIMAGE(@"bundle://button7_2.png")  forState:UIControlStateHighlighted];
    [_detailButton addTarget:self action:@selector(detailAction) 
            forControlEvents:UIControlEventTouchUpInside];
    [_detailButton setTitle:@"影院详情" forState:UIControlStateNormal];
    _detailButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    //_detailButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    _detailButton.frame = CGRectMake((320-75), (44-29)/2, 70, 29);
    
    [_navigationHeader addSubview:_backButton];
    [_navigationHeader addSubview:_detailButton];
    [self.view addSubview:_navigationHeader];
    
    self.dataSource = [[[CinemaSchedulingDataSource alloc] init] autorelease];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)detailAction{
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/CinemaDetailViewController"];
    urlAction.animated = YES;
    [[TTNavigator navigator] openURLAction:urlAction];
}

//点击进入详细页
-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    if ([object isMemberOfClass:[TTTableTextItem class]]) {
        [kAppDelegate.temporaryValues setObject:((TTTableTextItem*)object).userInfo
                                         forKey:@"moveDetail"];
        TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/SchedulingViewController"];
        urlAction.animated = YES;
        [[TTNavigator navigator] openURLAction:urlAction];
    }
}


@end
