//
//  HotMoveViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HotMoveViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageViewTouch.h"
#import "LoginAndRegisterViewController.h"
@implementation HotMoveViewController
@synthesize items;
@synthesize home = _home;

-(void)dealloc{
    TT_RELEASE_SAFELY(interestingPhotosDictionary);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //set up data
        self.items = [NSMutableArray array];
        for (int i = 0; i < 20; i++){
            [items addObject:[NSNumber numberWithInt:i]];
        }
    }
    return self;
}

-(void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.multipleTouchEnabled = YES;
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont boldSystemFontOfSize:20];
    _nameLabel.textAlignment = UITextAlignmentCenter;
    _nameLabel.frame = CGRectMake(60, 220, 200, 21);
    [self.view addSubview:_nameLabel];
    [_nameLabel release];
    
    _director = [[UILabel alloc] init];
    _director.textColor = [UIColor whiteColor];
    _director.backgroundColor = [UIColor clearColor];
    _director.font = [UIFont systemFontOfSize:15];
    _director.textAlignment = UITextAlignmentCenter;
    _director.frame = CGRectMake(0, 241, 320, 21);
    [self.view addSubview:_director];
    [_director release];
    
    _starring = [[UILabel alloc] init];
    _starring.textColor = [UIColor whiteColor];
    _starring.backgroundColor = [UIColor clearColor];
    _starring.font = [UIFont systemFontOfSize:15];
    _starring.textAlignment = UITextAlignmentCenter;
    _starring.frame = CGRectMake(0, 262, 320, 21);
    [self.view addSubview:_starring];
    [_starring release];
    
    _score = [[TTStyledTextLabel alloc] init];
    _score.font = [UIFont systemFontOfSize:15];
    _score.backgroundColor = [UIColor clearColor];
    _score.textColor = RGBCOLOR(121,171,204);
    [_score sizeToFit];
 
    _score.frame = CGRectMake(260, 220, 40, 21);
    [self.view addSubview:_score];
    [_score release];
    
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyButton setImage:TTIMAGE(@"bundle://gpbutton_2.png") forState:UIControlStateNormal];
    [_buyButton setImage:TTIMAGE(@"bundle://gpbutton_1.png") forState:UIControlStateHighlighted];
    _buyButton.frame = CGRectMake((320-115)/2, 292, 115, 40);
    [_buyButton addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buyButton];
    
    //请求正在热映接口
	NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
	
	[postData setObject:@"0102" forKey:@"OP"];
	[postData setObject:[NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0",@"100",nil]
														   forKeys:[NSArray arrayWithObjects:@"PAGE_NO",@"PAGE_SIZE",nil]]
				 forKey:@"PAGER"];
	
	ASIHTTPRequest *interestingnessRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:kTestUrl]];
	[interestingnessRequest setRequestMethod:@"POST"];
	[interestingnessRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
										  [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	[postData release];
	[interestingnessRequest setDelegate:self];
	interestingnessRequest.didFinishSelector = @selector(finishUpdata:);
	interestingnessRequest.didFailSelector = @selector(failUpdata:);
	
	[interestingnessRequest startAsynchronous];
}

-(void)failUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	[kAppDelegate alert:@"" message:@"超时或者服务器错误"];
}

-(void)finishUpdata:(ASIHTTPRequest *)request{
	interestingPhotosDictionary = [[[JSONDecoder decoder] 
									objectWithData:[request responseData]] retain];
    [kAppDelegate.temporaryValues setObject:[interestingPhotosDictionary objectForKey:@"list"] 
                                     forKey:@"hotMove"];
    _posterCarousel = [[[iCarousel alloc] init] autorelease];
    _posterCarousel.type = iCarouselTypeCoverFlow;
    _posterCarousel.delegate = self;
    _posterCarousel.dataSource = self;
    _posterCarousel.frame = CGRectMake(5, 0, 320, 220);
    _posterCarousel.multipleTouchEnabled = YES;
    if ([[interestingPhotosDictionary objectForKey:@"list"] count]>3) {
        [_posterCarousel scrollToItemAtIndex:2 animated:YES];
    }
    [self.view addSubview:_posterCarousel];
}

#pragma mark -
#pragma mark iCarousel methods

-(void) carouselCurrentItemIndexUpdated:(iCarousel *)carousel{
    NSDictionary *moveData =  [[interestingPhotosDictionary objectForKey:@"list"]
                               objectAtIndex:carousel.currentItemIndex];
    
    _nameLabel.text = [moveData objectForKey:@"MOVIENAME"];
    
    _director.text = [NSString stringWithFormat:@"导演:%@",[moveData objectForKey:@"MOVIEDIRECTOR"]];
    
    _starring.text = [NSString stringWithFormat:@"主演:%@",[moveData objectForKey:@"MOVIEVID"]];
    
    _score.text = [TTStyledText textFromXHTML:[NSString stringWithFormat:@"<span class=\"largeText\">%@</span><span class=\"smallText\">分</span>",
                                               [moveData objectForKey:@"MOVIEPOINT"]]];
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [[interestingPhotosDictionary objectForKey:@"list"] count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return 150;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    
    NSString * urls = [[[interestingPhotosDictionary objectForKey:@"list"] objectAtIndex:index] objectForKey:@"MOVIEPICURL"];
    NSURL *photoURL = [NSURL URLWithString:urls];
    
	UIView *view = [[[UIImageViewTouch alloc] initWithImage:[UIImage imageNamed:@"mrtp.png"]] autorelease];
    [((UIImageView*)view) setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"mrtp.png"]];
    view.userInteractionEnabled = YES;
    view.multipleTouchEnabled = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(moveDeatil) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 150, 200);
    [view addSubview:btn];
    
	return view;
}

-(void)moveDeatil{
    [kAppDelegate.temporaryValues removeObjectForKey:@"moveNUM"];
    //海报选中
	[kAppDelegate HUDShow:@"查询中" yOffset:@"0"];
	//请求详情
	NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
	
	[postData setObject:@"0103" forKey:@"OP"];
    
    [kAppDelegate.temporaryValues setObject:[[[interestingPhotosDictionary objectForKey:@"list"]
                                              objectAtIndex:_posterCarousel.currentItemIndex] 
                                             objectForKey:@"MOVIECODE"]
                                     forKey:@"MOVIECODE"];
    
	[postData setObject:[[[interestingPhotosDictionary objectForKey:@"list"]
                              objectAtIndex:_posterCarousel.currentItemIndex] 
                         objectForKey:@"MOVIECODE"]
				 forKey:@"MOVIECODE"];//影片ID
	
	ASIHTTPRequest *detailRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
	
	[detailRequest setRequestMethod:@"POST"];
	[detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
                                 [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
	[postData release];
	[detailRequest setDelegate:self];
	detailRequest.didFinishSelector = @selector(moveFinishUpdata:);
	detailRequest.didFailSelector = @selector(failUpdata:);
	[detailRequest startAsynchronous];
}

-(void)moveFinishUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	NSDictionary *detailDictionary = [[JSONDecoder decoder] 
                                      objectWithData:[request responseData]];
    
	[kAppDelegate.temporaryValues setValue:[detailDictionary objectForKey:@"FILMINFO"]
								   forKey:@"moveDetail"];
    
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/MoveDetailViewController"];
    urlAction.animated = YES;
    [[TTNavigator navigator] openURLAction:urlAction];
}

-(void)buyAction{
    [kAppDelegate.temporaryValues removeObjectForKey:@"moveNUM"];
    //海报选中
	[kAppDelegate HUDShow:@"查询中" yOffset:@"0"];
	//请求详情
	NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
	
	[postData setObject:@"0103" forKey:@"OP"];
    
    [kAppDelegate.temporaryValues setObject:[[[interestingPhotosDictionary objectForKey:@"list"]
                                              objectAtIndex:_posterCarousel.currentItemIndex] 
                                             objectForKey:@"MOVIECODE"]
                                     forKey:@"MOVIECODE"];
    
	[postData setObject:[[[interestingPhotosDictionary objectForKey:@"list"]
                          objectAtIndex:_posterCarousel.currentItemIndex] 
                         objectForKey:@"MOVIECODE"]
				 forKey:@"MOVIECODE"];//影片ID
	
	ASIHTTPRequest *detailRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
	
	[detailRequest setRequestMethod:@"POST"];
	[detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
                                 [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
	[postData release];
	[detailRequest setDelegate:self];
	detailRequest.didFinishSelector = @selector(buyFinishUpdata:);
	detailRequest.didFailSelector = @selector(failUpdata:);
	[detailRequest startAsynchronous];
    
}

-(void)buyFinishUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	NSDictionary *detailDictionary = [[JSONDecoder decoder] 
                                      objectWithData:[request responseData]];
    
	[kAppDelegate.temporaryValues setValue:[detailDictionary objectForKey:@"FILMINFO"]
                                    forKey:@"moveDetail"];
    [kAppDelegate.temporaryValues setObject:@"1" forKey:@"order" ];
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/CinemaListViewController"];
    urlAction.animated = YES;
    [[TTNavigator navigator] openURLAction:urlAction];

}


@end
