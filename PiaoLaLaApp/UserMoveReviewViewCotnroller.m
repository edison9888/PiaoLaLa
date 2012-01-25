//
//  UserMoveReviewViewCotnroller.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
// 

#import "UserMoveReviewViewCotnroller.h"
#import "UserMoveReviewDataSource.h"
@implementation UserMoveReviewViewCotnroller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    //NSLog(@"UserProfileViewController initWithNibName");
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

-(void) loadView{
	[super loadView];
    self.variableHeightRows = YES;
    self.tableView.frame = CGRectMake(0, 0, 320, 371);
	self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    self.dataSource = [[[UserMoveReviewDataSource alloc] init] autorelease];
}


@end
