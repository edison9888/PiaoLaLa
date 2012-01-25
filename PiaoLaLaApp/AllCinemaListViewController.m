//
//  AllCinemaListViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AllCinemaListViewController.h"
#import "AllCinemaListDataSource.h"
#import "LoginAndRegisterViewController.h"
@implementation AllCinemaListViewController
@synthesize controller =  _controller;
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    //NSLog(@"UserProfileViewController initWithNibName");
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cityChange)
                                                     name:@"cityChange" 
                                                   object:nil];
    }
    return self;
}

-(void)cityChange{
    self.dataSource = [[[AllCinemaListDataSource alloc] init] autorelease];
}

-(void) loadView{
	[super loadView];
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 62;
    self.tableView.frame = CGRectMake(0, 0, 320, 361);
	self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    self.dataSource = [[[AllCinemaListDataSource alloc] init] autorelease];
}

//点击进入详细页
-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([object isMemberOfClass:[TTTableTextItem class]]) {
        [kAppDelegate.temporaryValues setObject:((TTTableTextItem*)object).userInfo
                                         forKey:@"SelsectCINEMA"];
      //  NSLog(@"SelsectCINEMA %@",((TTTableTextItem*)object).userInfo);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults dictionaryForKey:@"USERINFO"]) {
            [self buy];
        }else{
            [self pushLogin:@"perLoadData"];
        }
    }
}

-(void)pushLogin:(NSString*)selectName{
	LoginAndRegisterViewController *controller =  (LoginAndRegisterViewController*)[kAppDelegate loadFromVC:@"LoginAndRegisterViewController"];
	controller.delegate = self;
	controller.stringSelect = selectName;
	[((UIViewController*)self.controller).navigationController
     pushViewController:controller animated:YES];
}

-(void)perLoadData{
	[((UIViewController*)self.controller).navigationController popViewControllerAnimated:NO ];
	[self buy];
}

-(void)buy{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    //NSLog(@"SelsectCINEMA %@",[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"] );
    for (NSDictionary* feed in [[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"] 
                                objectForKey:@"FILMSTATES"]) {
        TTTableTextItem *item = [TTTableTextItem itemWithText:@""];
        if ([[[kAppDelegate.temporaryValues objectForKey:@"hotMove"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"MOVIECODE = %@",[feed objectForKey:@"MOVIECODE"]]] count]>0)
        {
            item.userInfo = [[[kAppDelegate.temporaryValues objectForKey:@"hotMove"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"MOVIECODE = %@",[feed objectForKey:@"MOVIECODE"]]] objectAtIndex:0];
            [items addObject:item];
        }
    }

        if ([kAppDelegate.temporaryValues objectForKey:@"order" ]) {//从影片过来
            TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/SchedulingViewController"];
            urlAction.animated = YES;
            [[TTNavigator navigator] openURLAction:urlAction];
        }else{
            //如果没有排期
            if ([items count]<=0) {
                TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://nib/PassOrderViewController2"];
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
