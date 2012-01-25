//
//  MyCinemaListViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyCinemaListViewController.h"
#import "MyCinemaListDataSource.h"

@implementation MyCinemaListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    //NSLog(@"UserProfileViewController initWithNibName");
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

-(void) loadView{
	[super loadView];
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 62;
    self.tableView.frame = CGRectMake(0, 0, 320, 361);
	self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    self.dataSource = [[[MyCinemaListDataSource alloc] init] autorelease];
}

//点击进入详细页
-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([object isMemberOfClass:[TTTableTextItem class]]) {
        if ([kAppDelegate.temporaryValues objectForKey:@"order" ]) {
            TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/SchedulingViewController"];
            urlAction.animated = YES;
            [[TTNavigator navigator] openURLAction:urlAction];
        }else{
            TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/CinemaSchedulingListViewController"];
            urlAction.animated = YES;
            [[TTNavigator navigator] openURLAction:urlAction];
        }
    }
}

@end
