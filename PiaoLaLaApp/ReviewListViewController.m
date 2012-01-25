//
//  ReviewListViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
// 

#import "ReviewListViewController.h"
#import "ReviewListDataSource.h"
@implementation ReviewListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    //NSLog(@"UserProfileViewController initWithNibName");
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}


-(void) loadView{
     self.tableViewStyle = UITableViewStyleGrouped;
	[super loadView];
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 64;
    
    //导航条
    UIImageView *_navigationHeader = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://titlebar02.png")] autorelease];
    [_navigationHeader setUserInteractionEnabled:YES];
    _navigationHeader.frame = CGRectMake(0, 0, 320, 44);
    //背景
    UIImageView *back = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://background02.png")];
	self.tableView.backgroundView = back;
	[back release];
    self.tableView.backgroundColor = [UIColor blackColor];
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button7_1.png")  forState:UIControlStateNormal];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button7_2.png")  forState:UIControlStateHighlighted];
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    _backButton.frame = CGRectMake(5, (44-29)/2, 60, 29);
    
    [_navigationHeader addSubview:_backButton];
    
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.text = @"影片评论";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0, (22/2), 320, 22);
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_navigationHeader addSubview:_titleLabel];
    [_titleLabel release];
    
    
    self.tableView.frame = CGRectMake(0, 44, 320, 373);
    [self.view addSubview:_navigationHeader];
    
    self.dataSource = [[[ReviewListDataSource alloc] init] autorelease];
    
//     self.dataSource = [ReviewListDataSource dataSourceWithObjects:@"",
//                        [TTTableTextItem itemWithText:@""],
//                        @"",
//                        [TTTableTextItem itemWithText:@""],nil];
}


-(void)backAction{
    [self.navigationController  dismissModalViewControllerAnimated:YES];
}

@end
