//
//  UserNoPayOrderListViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserNoPayOrderListViewController.h"
#import "UserNoPayOrderDataSource.h"

@implementation UserNoPayOrderListViewController

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
    self.tableView.frame = CGRectMake(0, 0, 320, 371);
	self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    self.dataSource = [[[UserNoPayOrderDataSource alloc] init] autorelease];
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([object isMemberOfClass:[TTTableTextItem class]]) {
         [kAppDelegate.temporaryValues setObject:((TTTableTextItem*)object).userInfo forKey:@"orderInfo"];
        if ([[((TTTableTextItem*)object).userInfo objectForKey:@"SEATSTATUS"] intValue]==1) {//通票
            if ([[((TTTableTextItem*)object).userInfo objectForKey:@"ORDERSTATUS"] intValue]==2) {
                TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://nib/PassOrderDetailViewController"];
                urlAction.animated = YES;
                [[TTNavigator navigator] openURLAction:urlAction];
            }else{
                TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://nib/PassOrderPayDetailViewController"];
                urlAction.animated = YES;
                [[TTNavigator navigator] openURLAction:urlAction];
            }
        }else{
            if ([[((TTTableTextItem*)object).userInfo objectForKey:@"ORDERSTATUS"] intValue]==2) {
                TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://nib/DzOrderViewController"];
                urlAction.animated = YES;
                [[TTNavigator navigator] openURLAction:urlAction];
            }else{
                TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://nib/DzOrderPayViewController"];
                urlAction.animated = YES;
                [[TTNavigator navigator] openURLAction:urlAction];
            }
        }
    }
}


@end
