//
//  UserTicketDzTableViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserTicketDzTableViewController.h"
#import "UserTicketDzDataSource.h"
@implementation UserTicketDzTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    //NSLog(@"UserProfileViewController initWithNibName");
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

-(void) loadView{
	[super loadView];
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 80;
	self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    self.dataSource = [UserTicketDzDataSource dataSourceWithObjects:[TTTableTextItem itemWithText:@""],nil];
}

@end
