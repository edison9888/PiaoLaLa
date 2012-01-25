//
//  UserCinemaReviewViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  

#import "UserCinemaReviewViewController.h"
#import "UserCinemaReviewDataSource.h"
@implementation UserCinemaReviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    //NSLog(@"UserProfileViewController initWithNibName");
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

-(void) loadView{
	[super loadView];
    self.variableHeightRows = YES;
	self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.frame = CGRectMake(0, 0, 320, 371);
    self.view.backgroundColor = [UIColor clearColor];
    self.dataSource = [[[UserCinemaReviewDataSource alloc] init] autorelease];
}

@end
