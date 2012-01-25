//
//  SiteViewController.m
//  PiaoLaLaApp
//
//  Created by 高飞 on 11-12-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SiteViewController.h"
#import "ToolUntil.h"
#import "JSONKit.h"
#import "ASIHTTPRequest.h"
#import "UIImageViewSite.h"

@implementation SiteViewController

-(void) dealloc{
	
	TT_RELEASE_SAFELY(_selectArray);
	TT_RELEASE_SAFELY(_nameLabel);
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
       
	}
	return self;
}


-(void)backAction{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void) loadView{
	[super loadView];
    //导航条
    _navigationHeader = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://titlebar02.png")] autorelease];
    [_navigationHeader setUserInteractionEnabled:YES];
    _navigationHeader.frame = CGRectMake(0, 0, 320, 44);
    
    
    UIButton *_reviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reviewButton setBackgroundImage:TTIMAGE(@"bundle://button7_1.png")  forState:UIControlStateNormal];
    [_reviewButton setBackgroundImage:TTIMAGE(@"bundle://button7_2.png")  forState:UIControlStateHighlighted];
    [_reviewButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [_reviewButton setTitle:@"确定" forState:UIControlStateNormal];
    _reviewButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _reviewButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    _reviewButton.frame = CGRectMake((320-65), (44-29)/2, 60, 29);
    [_navigationHeader addSubview:_reviewButton];
    
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.text =[[kAppDelegate.temporaryValues objectForKey:@"STREAK"] 
                       objectForKey:@"HALLNAME"];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0, (22/2), 320, 22);
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_navigationHeader addSubview:_titleLabel];
    [_titleLabel release];
    
    UIImageView *_backGround = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://background02.png")] autorelease];
    _backGround.frame = CGRectMake(0, 44, 320, 420);
    [self.view addSubview:_backGround];
    [self.view sendSubviewToBack:_backGround];
    [self.view addSubview:_navigationHeader];
	
    _screenImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 37)];
	_screenImage.image = TTIMAGE(@"bundle://yszs.png");
	[self.view addSubview:_screenImage];
	[_screenImage release];

    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button1_1.png")  forState:UIControlStateNormal];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button1_2.png")  forState:UIControlStateHighlighted];
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    _backButton.frame = CGRectMake(5, (44-29)/2, 50, 29);
    [_navigationHeader addSubview:_backButton];
    
	_touching = NO;
	
}

-(UILabel *) nameLabel{
	if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 310, 21)];
		_nameLabel.font = [UIFont systemFontOfSize:17];
		_nameLabel.textAlignment = UITextAlignmentCenter;
		_nameLabel.backgroundColor= [UIColor clearColor];
		_nameLabel.textColor = RGBCOLOR(244,240,0);
		[self.view addSubview:_nameLabel];
	}
	return _nameLabel;
}

-(void)confirmAction{
	if ([_selectArray count]>0) {
		[kAppDelegate.temporaryValues setObject:_selectArray forKey:@"orderSelects"];
        [kAppDelegate.temporaryValues setObject:[NSString stringWithFormat:@"%d",[_selectArray count]*
                                                         [[[kAppDelegate.temporaryValues objectForKey:@"STREAK"] 
                                                           objectForKey:@"VALUE"] intValue]] 
                                         forKey:@"orderPrice"];


        
		TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://nib/DzOrderDetailViewController"];
		urlAction.animated = YES;
		[[TTNavigator navigator] openURLAction:urlAction];
	}else {
		[kAppDelegate alert:@"" message:@"请选择您想要的座位"];
	}
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    notif = [[NSNotificationCenter defaultCenter] addObserverForName:@"selectSite" 
                                                              object:nil 
                                                               queue:[NSOperationQueue mainQueue] 
                                                          usingBlock:^(NSNotification *notification){
                                                            //  NSLog(@"selectSite");
                                                              UIImageViewSite *site = ((UIImageViewSite*)[notification object]);
                                                              int x = ([[site.userInfo objectForKey:@"SEATX"] intValue]-1);
                                                              int y = ([[site.userInfo objectForKey:@"SEATY"] intValue]-1);
                                                              if (!_touching) {
                                                                  _touching = YES;
                                                                  if ([[ site.userInfo objectForKey:@"SEATSTATUS"] intValue]==2&&!site.select) {//座位状态可选
                                                                      if ([_selectArray count]<4) {//是否已经选了四个
                                                                          if([self isSelect:x y:y]){
                                                                              //NSLog(@"select");
                                                                              site.image = TTIMAGE(@"bundle://gSeat.png");
                                                                              site.select = YES;
                                                                              a[x][y]=4;
                                                                              [_selectArray addObject:site];
                                                                              //seletTotal+=1;
                                                                          }else {
                                                                              [kAppDelegate alert:@"" message:@"您只能购买连号的座位"];
                                                                          }
                                                                      }else {
                                                                          [kAppDelegate alert:@"" message:@"一次最多购买四张票"];
                                                                      }
                                                                  }else if ([[ site.userInfo objectForKey:@"SEATSTATUS"] intValue]==2&&site.select) {
                                                                      //NSLog(@"unselect");
                                                                      [self unSelect:x y:y site:site];
                                                                  }
                                                                  _touching = NO;
                                                              }
                                                              
                                                          }];
	[self refreshAction];
}

-(void) viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:notif];
}

-(void)refreshAction{
	[kAppDelegate HUDShow:@"" yOffset:@"0"];
	_selectArray = [[NSMutableArray alloc] initWithCapacity:4];
	if (_siteScroll) {
		[_siteScroll removeAllSubviews];
		[_siteScroll removeFromSuperview];
		//TT_RELEASE_SAFELY(_siteScroll);
		for (int i=0; i<200; i++) {
			for (int j=0; j<200; j++) {
				a[i][j]=0;
			}
		}
	}
    if (_colView) {
        [_colView removeAllSubviews];
        [_colView removeFromSuperview];
       // TT_RELEASE_SAFELY(_colView);
    }
    
	NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
	[postData setObject:@"0704" forKey:@"OP"];
	
	
	[postData setObject:[[kAppDelegate.temporaryValues objectForKey:@"STREAK"] objectForKey:@"APPNO"]
				 forKey:@"APPNO"];
	ASIHTTPRequest * request  = [ToolUntil requestCreate:self postData:postData];
	request.didFinishSelector = @selector(finishUpdata:);
	request.didFailSelector = @selector(failUpdata:);
	[postData release];
	[request startAsynchronous];
}

-(void)finishUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	NSDictionary *data = [[JSONDecoder decoder] objectWithData:[request responseData]];
    
	if ([[data objectForKey:@"RESULTCODE"] intValue]==0) {
		
		_siteScroll = [[UIScrollView alloc ] initWithFrame:CGRectMake(0, 83, 320, 455)];
        _siteScroll.delegate = self;
        [self.view addSubview:_siteScroll];
        [_siteScroll release];
        
        _rowView = [[UIView alloc] initWithFrame:CGRectMake(0, 83, 25, 100)];
        _rowView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_rowView];
        [_rowView release];
        
        _colView = [[UIView alloc] initWithFrame:CGRectMake(25, 83, 25, 20)];
        _colView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_colView];
        [_colView release];
        
        
        [self.view bringSubviewToFront:_screenImage];
        [self.view bringSubviewToFront:_navigationHeader];
        
		[_siteScroll setCanCancelContentTouches:NO];
		_siteScroll.clipsToBounds = YES;	// default is NO, we want to restrict drawing within our scrollview
		_siteScroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;
		_siteScroll.contentSize =CGSizeMake([[data objectForKey:@"MAXCOL"] intValue]*40, [[data objectForKey:@"MAXROW"] intValue]*40+120);
		[_siteScroll setScrollEnabled:YES];
		_siteScroll.userInteractionEnabled = YES;
		maxCol = [[data objectForKey:@"MAXCOL"] intValue];
		
		for (int i=0; i<[[data objectForKey:@"MAXROW"] intValue]; i++) {
			UILabel * _row = [[UILabel alloc] initWithFrame:CGRectMake(0, i*35+20, 25, 56)];
            _rowView.frame = CGRectMake(0, 83, 25, i*35+113);
			_row.text = [NSString stringWithFormat:@"%d",(i+1)];
			_row.font = [UIFont systemFontOfSize:15];
			_row.backgroundColor = [UIColor blackColor];
			_row.textColor = [UIColor whiteColor];
			[_rowView addSubview:_row];
			[_row release];
		}
		
		for (int i=0; i<[[data objectForKey:@"MAXCOL"] intValue]; i++) {
			UILabel * _row = [[UILabel alloc] initWithFrame:CGRectMake(i*35+20, 5, 20, 21)];
            _colView.frame = CGRectMake(25, 83, i*35+40, 30);
			_row.text = [NSString stringWithFormat:@"%d",(i+1)];
			_row.font = [UIFont systemFontOfSize:15];
			_row.backgroundColor = [UIColor clearColor];
			_row.textColor = [UIColor whiteColor];
			[_colView addSubview:_row];
			[_row release];
		}
		
		
		for (NSDictionary * site in [data objectForKey:@"list"]) {
			UIImageViewSite *siteView = [[UIImageViewSite alloc] initWithFrame:CGRectMake(30*[[site objectForKey:@"SEATY"] intValue]+([[site objectForKey:@"SEATY"] intValue])*5,
                                                                                          30*[[site objectForKey:@"SEATX"] intValue]+[[site objectForKey:@"SEATX"] intValue]*5,
                                                                                          30, 30)];
            
			
			siteView.userInteractionEnabled = YES;
			a[([[site objectForKey:@"SEATX"] intValue]-1)][([[site objectForKey:@"SEATY"] intValue]-1)]=[[site objectForKey:@"SEATSTATUS"] intValue];
			
			
			
			//[[siteAarry objectAtIndex:([[site objectForKey:@"SEATX"] intValue]-1)] insertObject:site
            //																					 atIndex:([[site objectForKey:@"SEATY"] intValue]-1)];
			
			if ([[site objectForKey:@"SEATSTATUS"] intValue]==2) {
				siteView.image = TTIMAGE(@"bundle://hSeat.png");
			}else {
				siteView.image = TTIMAGE(@"bundle://rSeat.png");
			}
			siteView.userInfo = site;
			[_siteScroll addSubview:siteView];
			[siteView release];
		}
		
	}
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _rowView.frame = CGRectMake(0, 83-scrollView.contentOffset.y, 25, _rowView.frame.size.height);
    _colView.frame = CGRectMake(25-scrollView.contentOffset.x, 83, _colView.frame.size.width, 30);
}

-(void)unSelect:(int)x y:(int)y site:(UIImageViewSite*)site{
	if ([_selectArray count]==0) {
		return;
	}
    //	NSLog(@"y %d",y);
    //	NSLog(@"count %d",[_selectArray count]);
    //	NSLog(@"a[x][y-1] %d",a[x][y-1]);
    //	NSLog(@"a[x][y+1] %d",a[x][y+1]);
	if (([_selectArray count]==1)||(a[x][y-1]!=4&&a[x][y+1]!=4)) {//只有一个被选 或者 左右都无选择  则直接取消 
		[self removeSite:site];
		a[x][y]=2;
		return;
	}
	
	if ((a[x][y-1]==4||a[x][y-1]==1)&&a[x][y+1]==2) {//右边为空，左边有人
		if (a[x][y-2]==2&&((y-3)<0||a[x][y-3]==4||a[x][y-3]==1)) {// 左边+1为空并且左边+2有人或者为边缘
			NSInteger index = [_selectArray indexOfObjectPassingTest:
							   ^(id obj, NSUInteger idx, BOOL *stop){
								   int sx = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATX"] intValue]-1);
								   int sy = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATY"] intValue]-1);
								   if (sx==x&&sy==(y-1)) {
									   return YES;
								   }else {
									   return NO;
								   }
							   }];
			UIImageViewSite *Lsite =[_selectArray objectAtIndex:index];
			Lsite.image = TTIMAGE(@"bundle://hSeat.png");
			Lsite.select = NO;
			a[x][y-1]=2;
			//同时取消左边和自身
			[_selectArray removeObjectAtIndex:index];
			[self removeSite:site];
			a[x][y]=2;
		}else {
			[self removeSite:site];
			a[x][y]=2;
			return;
		}
	}else if(a[x][y-1]==2&&(a[x][y+1]==4||a[x][y+1]==1)){//左边为空，右边有人
		if (a[x][y+2]==2&&(a[x][y+3]==4||a[x][y+3]==0||a[x][y+3]==1)) {// 右边+1为空并且右边+2有人或者为边缘
			NSInteger index = [_selectArray indexOfObjectPassingTest:
							   ^(id obj, NSUInteger idx, BOOL *stop){
								   int sx = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATX"] intValue]-1);
								   int sy = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATY"] intValue]-1);
								   if (sx==x&&sy==(y+1)) {
									   return YES;
								   }else {
									   return NO;
								   }
							   }];
			UIImageViewSite *Rsite =[_selectArray objectAtIndex:index];
			Rsite.image = TTIMAGE(@"bundle://hSeat.png");
			Rsite.select = NO;
			a[x][y+1]=2;
			//同时取消右边和自身
			[_selectArray removeObjectAtIndex:index];
			[self removeSite:site];
			a[x][y]=2;
		}else {
			[self removeSite:site];
			a[x][y]=2;
		}
	}else if (a[x][y-1]!=0&&a[x][y+1]!=0&&a[x][y-1]!=2&&a[x][y+1]!=2) {//左右同时被选定
		
		if (a[x][y-1]==1&&a[x][y+1]==4) {//左边为已定右边为自己选
			NSInteger index = [_selectArray indexOfObjectPassingTest:
							   ^(id obj, NSUInteger idx, BOOL *stop){
								   int sx = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATX"] intValue]-1);
								   int sy = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATY"] intValue]-1);
								   if (sx==x&&sy==(y+1)) {
									   return YES;
								   }else {
									   return NO;
								   }
							   }];
			UIImageViewSite *Rsite =[_selectArray objectAtIndex:index];
			Rsite.image = TTIMAGE(@"bundle://hSeat.png");
			Rsite.select = NO;
			a[x][y+1]=2;
			//同时取消右边和自身
			[_selectArray removeObjectAtIndex:index];
			[self removeSite:site];
			a[x][y]=2;
		}else if (a[x][y+1]==1&&a[x][y-1]==4) {//右边为已定左边为自己选
			NSInteger index = [_selectArray indexOfObjectPassingTest:
							   ^(id obj, NSUInteger idx, BOOL *stop){
								   int sx = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATX"] intValue]-1);
								   int sy = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATY"] intValue]-1);
								   if (sx==x&&sy==(y-1)) {
									   return YES;
								   }else {
									   return NO;
								   }
							   }];
			UIImageViewSite *Rsite =[_selectArray objectAtIndex:index];
			Rsite.image = TTIMAGE(@"bundle://hSeat.png");
			Rsite.select = NO;
			a[x][y-1]=2;
			//同时取消左边和自身
			[_selectArray removeObjectAtIndex:index];
			[self removeSite:site];
			a[x][y]=2;
		}else if(a[x][y+1]==1&&a[x][y-1]==1){
			[self removeSite:site];
			a[x][y]=2;
		}else if (a[x][y+1]==4&&a[x][y-1]==4) {
			if(a[x][y+2]==2) {// 右边+1为空
				if (a[x][y+3]==4||a[x][y+3]==0||a[x][y+3]==1) {//右边+2有人或者为边缘
					//左右同时取消
					NSInteger rindex = [_selectArray indexOfObjectPassingTest:
										^(id obj, NSUInteger idx, BOOL *stop){
											int sx = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATX"] intValue]-1);
											int sy = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATY"] intValue]-1);
											if (sx==x&&sy==(y+1)) {
												return YES;
											}else {
												return NO;
											}
										}];
					UIImageViewSite *Rsite =[_selectArray objectAtIndex:rindex];
					Rsite.image = TTIMAGE(@"bundle://hSeat.png");
					Rsite.select = NO;
					a[x][y+1]=2;
					
					NSInteger lindex = [_selectArray indexOfObjectPassingTest:
										^(id obj, NSUInteger idx, BOOL *stop){
											int sx = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATX"] intValue]-1);
											int sy = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATY"] intValue]-1);
											if (sx==x&&sy==(y-1)) {
												return YES;
											}else {
												return NO;
											}
										}];
					UIImageViewSite *Lsite =[_selectArray objectAtIndex:lindex];
					Lsite.image = TTIMAGE(@"bundle://hSeat.png");
					Lsite.select = NO;
					a[x][y-1]=2;
					
					[_selectArray removeObjectAtIndex:lindex];
					[self removeSite:site];
					a[x][y]=2;
				}else{
					NSInteger index = [_selectArray indexOfObjectPassingTest:
									   ^(id obj, NSUInteger idx, BOOL *stop){
										   int sx = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATX"] intValue]-1);
										   int sy = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATY"] intValue]-1);
										   if (sx==x&&sy==(y-1)) {
											   return YES;
										   }else {
											   return NO;
										   }
									   }];
					UIImageViewSite *Rsite =[_selectArray objectAtIndex:index];
					Rsite.image = TTIMAGE(@"bundle://hSeat.png");
					Rsite.select = NO;
					a[x][y-1]=2;
					//同时取消左边和自身
					[_selectArray removeObjectAtIndex:index];
					[self removeSite:site];
					a[x][y]=2;
				}
			}else {
				NSInteger index = [_selectArray indexOfObjectPassingTest:
								   ^(id obj, NSUInteger idx, BOOL *stop){
									   int sx = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATX"] intValue]-1);
									   int sy = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATY"] intValue]-1);
									   if (sx==x&&sy==(y-1)) {
										   return YES;
									   }else {
										   return NO;
									   }
								   }];
				UIImageViewSite *Rsite =[_selectArray objectAtIndex:index];
				Rsite.image = TTIMAGE(@"bundle://hSeat.png");
				Rsite.select = NO;
				a[x][y-1]=2;
				//同时取消左边和自身
				[_selectArray removeObjectAtIndex:index];
				[self removeSite:site];
				a[x][y]=2;
			}
		}
	}else if((a[x][y-1]==4||a[x][y-1]==1)&&a[x][y+1]==0){
		if (a[x][y-1]==1) {
			[self removeSite:site];
			a[x][y]=2;
		}else {
			NSInteger index = [_selectArray indexOfObjectPassingTest:
							   ^(id obj, NSUInteger idx, BOOL *stop){
								   int sx = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATX"] intValue]-1);
								   int sy = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATY"] intValue]-1);
								   if (sx==x&&sy==(y-1)) {
									   return YES;
								   }else {
									   return NO;
								   }
							   }];
			UIImageViewSite *Rsite =[_selectArray objectAtIndex:index];
			Rsite.image = TTIMAGE(@"bundle://hSeat.png");
			Rsite.select = NO;
			a[x][y-1]=2;
			//同时取消左边和自身
			[_selectArray removeObjectAtIndex:index];
			[self removeSite:site];
			a[x][y]=2;
		}
	}else if((a[x][y+1]==4||a[x][y+1]==1)&&a[x][y-1]==0){
		if (a[x][y+1]==1) {
			[self removeSite:site];
			a[x][y]=2;
		}else {
			NSInteger index = [_selectArray indexOfObjectPassingTest:
							   ^(id obj, NSUInteger idx, BOOL *stop){
								   int sx = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATX"] intValue]-1);
								   int sy = ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATY"] intValue]-1);
								   if (sx==x&&sy==(y+1)) {
									   return YES;
								   }else {
									   return NO;
								   }
							   }];
			UIImageViewSite *Rsite =[_selectArray objectAtIndex:index];
			Rsite.image = TTIMAGE(@"bundle://hSeat.png");
			Rsite.select = NO;
			a[x][y+1]=2;
			//同时取消左边和自身
			[_selectArray removeObjectAtIndex:index];
			[self removeSite:site];
			a[x][y]=2;
		}
	}
    
    
    
    
}

-(void)removeSite:(UIImageViewSite*)site{
	site.image = TTIMAGE(@"bundle://hSeat.png");
	site.select = NO;
	[_selectArray removeObjectAtIndex:[_selectArray indexOfObjectPassingTest:
									   ^(id obj, NSUInteger idx, BOOL *stop){
										   return ([[((UIImageViewSite*)obj).userInfo objectForKey:@"SEATNO"] isEqualToString:
													[site.userInfo objectForKey:@"SEATNO"]]);
									   }]];
}

//2 可选 1 不可选 0 边缘 4已选
-(BOOL)isSelect:(int)x y:(int)y{
    //	NSLog(@"y %d",y);
    //	NSLog(@"count %d",[_selectArray count]);
	if((y==0||a[x][y-1]==0)||(a[x][y+1]==0)||a[x][y-1]!=2||a[x][y+1]!=2){//是边缘或者相邻有被选择的 
		return  YES;
	}else if (a[x][y-1]==2&&a[x][y+1]==2){//左右都未被选择
		if (a[x][y-2]==2&&a[x][y+2]==2) {
			return  YES;
		}
	}
	return NO;
}

-(void)failUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	NSLog(@"error %@",[request error]);
	[kAppDelegate alert:@"" message:@"超时或者服务器错误"];
}

- (NSString *)iconImageName {
	return @"sz.png";
}

@end
