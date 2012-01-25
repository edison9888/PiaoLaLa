//
//  SchedulingListViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SchedulingListViewController.h"
#import "SchedulingListHeadrView.h"
#import "SchedulingListDataSource.h"
#import "NSStringAdditions.h"
#import "LoginAndRegisterViewController.h"
@implementation SchedulingListViewController
@synthesize  cinemaId = _cinemaId;
@synthesize  rootController = _rootController;
-(void) loadView{
	[super loadView];
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 40;
    self.tableView.frame = CGRectMake(0, 40, 320, 325);
	self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    
    _header = [[SchedulingListHeadrView alloc] init];
    _header.frame = CGRectMake(0, 0, 320, 40);
    _header.backgroundColor = [UIColor clearColor];
//    self.tableView.tableHeaderView = _header;
    [self.view addSubview:_header];
    [_header release];
    _header.redSC.delegate = self;
    

    
    self.cinemaId = @"";
    [self getPaiqi];
}

-(void)getPaiqi{
    //请求订座票排期
    [kAppDelegate HUDShow:@"查询中" yOffset:@"0"];
    //请求详情
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    
    [postData setObject:@"0806" forKey:@"OP"];
    
    [postData setObject:[[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"] 
                         objectForKey:@"CINEMACODE"]
                 forKey:@"FIRMID"];//影院ID
    
    NSLog(@"FIRMID %@",[[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"] 
                        objectForKey:@"CINEMACODE"]);
    
    NSLog(@"FILMID %@",[[kAppDelegate.temporaryValues objectForKey:@"moveDetail"] 
                        objectForKey:@"MOVIECODE"]);
    
    [postData setObject:[[kAppDelegate.temporaryValues objectForKey:@"moveDetail"] 
                         objectForKey:@"MOVIECODE"]
                 forKey:@"FILMID"];//影片ID
    
    [postData setObject:@"0"
                 forKey:@"START"];
    
    [postData setObject:@"1"
                 forKey:@"END"];
    
    ASIHTTPRequest *detailRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
    
    [detailRequest setRequestMethod:@"POST"];
    [detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
                                 [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
    [postData release];
    [detailRequest setDelegate:self];
    detailRequest.didFinishSelector = @selector(paiqiFinsh:);
    detailRequest.didFailSelector = @selector(failUpdata:);
    [detailRequest startAsynchronous];
}

-(void)paiqiFinsh:(ASIHTTPRequest *)request{
    [kAppDelegate HUDHide];
    NSDictionary *json = [[JSONDecoder decoder] 
                          objectWithData:[request responseData]];
    //NSLog(@"json %@",json);
    NSMutableArray * items = [NSMutableArray array];
    
    NSInteger i=0;
    for (NSDictionary *_streak in [[[json objectForKey:@"DAYS"] 
                                    objectAtIndex:_header.redSC.selectedIndex] 
                                   objectForKey:@"STREAKS"]) {
        TTTableTextItem *item1 = [TTTableTextItem itemWithText:@""];
        NSMutableDictionary *_temp1 =  [NSMutableDictionary dictionaryWithDictionary:_streak];
        if ((i%2)==0) {
            [_temp1 setObject:@"1" forKey:@"color"];
        }else{
            [_temp1 setObject:@"2" forKey:@"color"];
        }
        
        item1.userInfo = _temp1;
        [items addObject:item1];
        i++;
    }
    self.dataSource = [SchedulingListDataSource dataSourceWithItems:items];
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [kAppDelegate.temporaryValues setObject:((TTTableTextItem*)object).userInfo
                                     forKey:@"STREAK"];
    NSLog(@"STREAK %@",((TTTableTextItem*)object).userInfo);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults dictionaryForKey:@"USERINFO"]) {
        TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/SiteViewController"];
        urlAction.animated = YES;
        [[TTNavigator navigator] openURLAction:urlAction];
    }else{
        [self.rootController orderLogin];
        
    }
}



-(void)failUpdata{
    [kAppDelegate HUDHide];
    [kAppDelegate alert:@"错误" message:@"数据获取失败"];
}

- (void)segmentedControl:(SVSegmentedControl*)segmentedControl didSelectIndex:(NSUInteger)index{
    [self getPaiqi];
    //选择当天的影院订座票排期
}

@end
