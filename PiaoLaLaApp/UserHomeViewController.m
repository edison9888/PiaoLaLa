//
//  UserViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserHomeViewController.h"
#import "UserViewDataSource.h"
#import "UserViewItem.h"
#import "UserHeaderView.h"
#import "LoginAndRegisterViewController.h"
#import "UIImageView+WebCache.h"
@implementation UserHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _first = YES;
        _userId = @"";
    }
    return self;
}


-(void) loadView{
    self.tableViewStyle = UITableViewStyleGrouped;
	[super loadView];
    self.tableView.separatorColor = [UIColor clearColor];
    
    //导航条
    UIImageView *_navigationHeader = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://titlebar.png")] autorelease];
    [_navigationHeader setUserInteractionEnabled:YES];
    _navigationHeader.frame = CGRectMake(0, 0, 320, 44);
    //背景
    UIImageView *_backGround = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://background.png")] autorelease];
    _backGround.frame = CGRectMake(0, 0, 320, 460);
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button1_1.png")  forState:UIControlStateNormal];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button1_2.png")  forState:UIControlStateHighlighted];
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    _backButton.frame = CGRectMake(5, (44-29)/2, 50, 29);
    [_navigationHeader addSubview:_backButton];
    
    UIButton *_logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_logoutButton setBackgroundImage:TTIMAGE(@"bundle://button7_1.png")  forState:UIControlStateNormal];
    [_logoutButton setBackgroundImage:TTIMAGE(@"bundle://button7_2.png")  forState:UIControlStateHighlighted];
    [_logoutButton setTitle:@"注销" forState:UIControlStateNormal];
    [_logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    _logoutButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _logoutButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    _logoutButton.frame = CGRectMake((320-55), (44-29)/2, 50, 29);
    
    [_navigationHeader addSubview:_logoutButton];
    
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.text = @"我的票啦啦";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0, (22/2), 320, 22);
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_navigationHeader addSubview:_titleLabel];
    [_titleLabel release];
    
    [self.view addSubview:_backGround];
    [self.view sendSubviewToBack:_backGround];
    [self.view addSubview:_navigationHeader];
    
    self.tableView.frame = CGRectMake(0, 44, 320, 392);
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 64;
	self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    _header = [[UserHeaderView alloc] init];
    _header.frame = CGRectMake(0, 0, 320, 90);
    _header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = _header;
    [_header release];
    
    self.dataSource = [UserViewDataSource dataSourceWithObjects:
                      [UserViewItem itemWithText:@"我的订单"  caption:@"" imageURL:@"bundle://icon1.png" 
                                             top:YES],
//                      [UserViewItem itemWithText:@"我的电子票" caption:@"" imageURL:@"bundle://icon2.png"
//                                             top:YES],
                      [UserViewItem itemWithText:@"我的评论" caption:@"" imageURL:@"bundle://icon4.png"
                                              top:NO],
                       nil];
}

-(void)logout{
    _first = NO;
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"USERINFO"];
    [defaults synchronize];
    [self pushLogin:@"getUserData"];
}

-(void)viewWillAppear:(BOOL)animated{
   	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //NSLog(@"USERINFO %@",[defaults dictionaryForKey:@"USERINFO"]);
	if (![defaults dictionaryForKey:@"USERINFO"] &&_first) {
        _first = NO;
        [self pushLogin:@"getUserData"];
    }else if(![defaults dictionaryForKey:@"USERINFO"] && !_first){
         _first = YES;
         [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![_userId isEqualToString:[[defaults dictionaryForKey:@"USERINFO"] objectForKey:@"USERID"]]) {
        _userId = [[defaults dictionaryForKey:@"USERINFO"] objectForKey:@"USERID"];
        //海报选中
        [kAppDelegate HUDShow:@"查询中" yOffset:@"0"];
        //请求详情
        NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
        
        [postData setObject:@"0501" forKey:@"OP"];
        
        
        //    NSLog(@"MOVIECODE1 %@",[[[interestingPhotosDictionary objectForKey:@"list"]
        //                             objectAtIndex:_posterCarousel.currentItemIndex] 
        //                            objectForKey:@"MOVIECODE"]);
        
        
        
        [postData setObject:_userId
                     forKey:@"USERID"];//影片ID
        
        ASIHTTPRequest *detailRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
        
        [detailRequest setRequestMethod:@"POST"];
        [detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
                                     [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData release];
        [detailRequest setDelegate:self];
        detailRequest.didFinishSelector = @selector(userFinishUpdata:);
        detailRequest.didFailSelector = @selector(failUpdata:);
        [detailRequest startAsynchronous];
    }
}

-(void)userFinishUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
    NSDictionary *json = [[JSONDecoder decoder] 
                          objectWithData:[request responseData]];
   // NSLog(@"city %@",json);
    if ([[json objectForKey:@"RESULTCODE"] isEqualToString:@"0"]){
        [_header.avatar setImageWithURL:
         [NSURL URLWithString:[[json objectForKey:@"USERINFO"] objectForKey:@"HEADURL"]]
                       placeholderImage:TTIMAGE(@"")];
        _header.name.text = [[json objectForKey:@"USERINFO"] objectForKey:@"USERNAME"];
    }else{
        [kAppDelegate alert:@"错误" message:[json objectForKey:@"RESULTDESC"] ]; 
    }
    
}

-(void)failUpdata{
    [kAppDelegate HUDHide];
    [kAppDelegate alert:@"错误" message:@"用户数据获取失败"];
}


-(void)pushLogin:(NSString*)selectName{
	LoginAndRegisterViewController *controller =  (LoginAndRegisterViewController*)[kAppDelegate loadFromVC:@"LoginAndRegisterViewController"];
	controller.delegate = self;
	controller.stringSelect = selectName;
	[self.navigationController pushViewController:controller animated:YES];
}

-(void)getUserData{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    NSString *_url = nil;
    switch (indexPath.row) {
        case 0:
            _url = @"tt://viewController/UserOrderViewContrller";
            break;
//        case 1:
//            _url = @"tt://viewController/UserTicketViewController";
//            break;
        case 1:
            _url = @"tt://viewController/UserReviewViewController";
            break;
        default:
            break;
    }
    if (_url) {
        TTURLAction *urlAction = [TTURLAction actionWithURLPath:_url];
        urlAction.animated = YES;
        [[TTNavigator navigator] openURLAction:urlAction];
    }
}

@end
