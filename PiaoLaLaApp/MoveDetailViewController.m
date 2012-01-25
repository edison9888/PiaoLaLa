//
//  MoveDetailViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MoveDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "NSStringAdditions.h"
#import "LoginAndRegisterViewController.h"
@implementation MoveDetailViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    //NSLog(@"UserProfileViewController initWithNibName");
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(msgAdd) 
                                                     name:@"msgAdd"
                                                   object:nil];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
    [kAppDelegate.temporaryValues removeObjectForKey:@"order"];
}

-(void) loadView{
	[super loadView];
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

    
    UIButton *_reviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reviewButton setBackgroundImage:TTIMAGE(@"bundle://button7_1.png")  forState:UIControlStateNormal];
    [_reviewButton setBackgroundImage:TTIMAGE(@"bundle://button7_2.png")  forState:UIControlStateHighlighted];
    [_reviewButton addTarget:self action:@selector(reviewAction) forControlEvents:UIControlEventTouchUpInside];
    [_reviewButton setTitle:@"写评论" forState:UIControlStateNormal];
    _reviewButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _reviewButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    _reviewButton.frame = CGRectMake((320-65), (44-29)/2, 60, 29);
    
    [_navigationHeader addSubview:_reviewButton];
    
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.text = @"影片详情";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0, (22/2), 320, 22);
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_navigationHeader addSubview:_titleLabel];
    [_titleLabel release];
    
    NSDictionary *moveData = [kAppDelegate.temporaryValues objectForKey:@"moveDetail"];
    //NSLog(@"moveData %@",moveData);
    
    _poster = [[UIImageView alloc] init];
    
    NSURL *photoURL = [NSURL URLWithString:[moveData objectForKey:@"MOVIEPICURL"]];
    
    [_poster setImageWithURL:photoURL placeholderImage:TTIMAGE(@"bundle://picshow.png")];
    _poster.frame =  CGRectMake(10, 54, 110, 157);
    [self.view addSubview:_poster];
    [_poster release];
    
    _moveName = [[UILabel alloc] init];
    _moveName.textColor = RGBCOLOR(77, 170, 255);
    _moveName.backgroundColor = [UIColor clearColor];
    _moveName.font = [UIFont systemFontOfSize:20];
    _moveName.frame = CGRectMake(130, 54, 160, 21);
    _moveName.text = [moveData objectForKey:@"MOVIENAME"];
    [self.view addSubview:_moveName];
    [_moveName release];
    
    _score = [[TTStyledTextLabel alloc] init];
    _score.font = [UIFont systemFontOfSize:15];
    _score.backgroundColor = [UIColor clearColor];
    _score.textColor = RGBCOLOR(121,171,204);
    [_score sizeToFit];
    _score.text = [TTStyledText textFromXHTML:[NSString stringWithFormat:@"<span class=\"largeText\">%@</span><span class=\"smallText\">分</span>",
                    [moveData objectForKey:@"MOVIEPOINT"]]];
    _score.frame = CGRectMake(270, 50, 40, 21);
    [self.view addSubview:_score];
    [_score release];
    
    _director = [[UILabel alloc] init];
    _director.textColor = [UIColor whiteColor];
    _director.backgroundColor = [UIColor clearColor];
    _director.font = [UIFont systemFontOfSize:15];
    _director.frame = CGRectMake(130, 75, 170, 21);
    _director.text = [NSString stringWithFormat:@"导演:%@",[moveData objectForKey:@"MOVIEDIRECTOR"]];
    [self.view addSubview:_director];
    [_director release];
    
    _starring = [[UILabel alloc] init];
    _starring.textColor = [UIColor whiteColor];
    _starring.backgroundColor = [UIColor clearColor];
    _starring.font = [UIFont systemFontOfSize:15];
    _starring.frame = CGRectMake(130, 96, 170, 21);
    _starring.text = [NSString stringWithFormat:@"主演:%@",[moveData objectForKey:@"MOVIEVID"]];
    [self.view addSubview:_starring];
    [_starring release];
    
    
    _length = [[UILabel alloc] init];
    _length.textColor = [UIColor whiteColor];
    _length.backgroundColor = [UIColor clearColor];
    _length.font = [UIFont systemFontOfSize:15];
    _length.frame = CGRectMake(130, 117, 170, 21);
    _length.text = [NSString stringWithFormat:@"片长:%@分钟",[moveData objectForKey:@"MOVIELENGTH"]];
    [self.view addSubview:_length];
    [_length release];
    
    _time = [[UILabel alloc] init];
    _time.textColor = [UIColor whiteColor];
    _time.backgroundColor = [UIColor clearColor];
    _time.font = [UIFont systemFontOfSize:15];
    _time.frame = CGRectMake(130, 138, 170, 21);
    _time.text = [NSString stringWithFormat:@"上映时间:%@",[moveData objectForKey:@"PLAYDATE"]];
    [self.view addSubview:_time];
    [_time release];
    
    
   if ([[moveData objectForKey:@"NUM"] isMemberOfClass:[NSNull class]]) {
        //正在热映时为票房、即将上映是期待人数  
        _screen = [[UILabel alloc] init];
        _screen.textColor = [UIColor whiteColor];
        _screen.backgroundColor = [UIColor clearColor];
        _screen.font = [UIFont systemFontOfSize:15];
        _screen.frame = CGRectMake(130, 159, 170, 21);
        _screen.text = [NSString stringWithFormat:@"票房:%@",[moveData objectForKey:@"BOXOFFICE"]];
        [self.view addSubview:_screen];
        [_screen release];
    }else{
        _screen = [[UILabel alloc] init];
        _screen.textColor = [UIColor whiteColor];
        _screen.backgroundColor = [UIColor clearColor];
        _screen.font = [UIFont systemFontOfSize:15];
        _screen.frame = CGRectMake(130, 159, 170, 21);
        _screen.text = [NSString stringWithFormat:@"期待人数:%@",[moveData objectForKey:@"NUM"]];
        [self.view addSubview:_screen];
        [_screen release];
    }

    
    UIButton *_payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_payButton setBackgroundImage:TTIMAGE(@"bundle://button8_1.png") forState:UIControlStateNormal];
    [_payButton setBackgroundImage:TTIMAGE(@"bundle://button8_2.png") forState:UIControlStateHighlighted];
    
    [_payButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:15];
    if ([[moveData objectForKey:@"NUM"] isMemberOfClass:[NSNull class]]) {
        _payButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [_payButton setTitle:@"立即购票" forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    }else{
        _payButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        [_payButton setTitle:@"期待" forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(forwardAction) forControlEvents:UIControlEventTouchUpInside];
    }
    _payButton.frame = CGRectMake(220, 183, 86, 29);
    [self.view addSubview:_payButton];
    
    //影片简介
    _Introduction = [[[TTView alloc] initWithFrame:CGRectMake(10, 216, 300, 44)] autorelease];
    _Introduction.backgroundColor = [UIColor clearColor];
    _Introduction.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
                               [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                                [TTSolidBorderStyle styleWithColor:RGBCOLOR(158, 163, 172) width:1 next:nil]]];
    
    UILabel *_nameLable = [[UILabel alloc] init];
    _nameLable.backgroundColor = [UIColor clearColor];
    _nameLable.font = [UIFont systemFontOfSize:18];
    _nameLable.textAlignment = UITextAlignmentLeft;
    _nameLable.text = @"影片简介";
    _nameLable.frame = CGRectMake(10, 12, 200, 20);
    
    _isOpen = NO;
    _openArrow = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://arrow3.png")];
    _openArrow.frame = CGRectMake(280, 16, 6, 12);
    [_Introduction addSubview:_openArrow];
    [_openArrow release];
    [_Introduction addSubview:_nameLable];
    [_nameLable release];
    
    UIControl * _touch = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    [_touch addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
    [_Introduction addSubview:_touch];
    [_touch release];
    
    _introductionText = [[UITextView alloc] initWithFrame:CGRectMake(10, 30, 280, 205)];
    _introductionText.backgroundColor = [UIColor clearColor];
    _introductionText.font = [UIFont systemFontOfSize:16];
    _introductionText.editable = NO;
    _introductionText.hidden = YES;
    _introductionText.text = [NSString stringWithFormat:@"  %@",[moveData objectForKey:@"MOVIEDES"]];
    [_Introduction addSubview:_introductionText];
    [_introductionText release];
    [self.view addSubview:_Introduction];
    
    if (TTIsArrayWithItems([moveData objectForKey:@"list"])) {
        _review = [[[TTView alloc] initWithFrame:CGRectMake(10, 265, 300, 190)] autorelease];
        _review.backgroundColor = [UIColor clearColor];
        _review.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
                         [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                          [TTSolidBorderStyle styleWithColor:RGBCOLOR(158, 163, 172) width:1 next:nil]]];
        [self.view addSubview:_review];
        //[self.view sendSubviewToBack:_review];
        
        UILabel *_nameLable1 = [[UILabel alloc] init];
        _nameLable1.backgroundColor = [UIColor clearColor];
        _nameLable1.font = [UIFont systemFontOfSize:18];
        _nameLable1.textAlignment = UITextAlignmentLeft;
        _nameLable1.text = @"影片评论";
        _nameLable1.frame = CGRectMake(10, 12, 200, 20);
        [_review addSubview:_nameLable1];
        [_nameLable1 release];
        
        
        NSDictionary *reviewInfo = [[moveData objectForKey:@"list"] objectAtIndex:0];
        UIImageView *_avatar = [[UIImageView alloc] init];
        [_avatar setImageWithURL:[NSURL URLWithString:[reviewInfo objectForKey:@"USERHEADPICURL"]]
                placeholderImage:TTIMAGE(@"bundle://face1.png")];
        _avatar.frame = CGRectMake(10, 40, 50, 50);
        [_review addSubview:_avatar];
        [_avatar release];
        
        UILabel *_userNameLable = [[UILabel alloc] init];
        _userNameLable.frame = CGRectMake(65, 37, 145, 21);
        _userNameLable.font = [UIFont systemFontOfSize:16];
        _userNameLable.textColor = RGBCOLOR(40, 94, 198);
        _userNameLable.text =[[reviewInfo objectForKey:@"USERNAME"] isEmptyOrWhitespace]?@"票啦啦":[reviewInfo objectForKey:@"USERNAME"];
        [_review addSubview:_userNameLable];
        [_userNameLable release];
        
        UILabel *_userTimeLable = [[UILabel alloc] init];
        _userTimeLable.frame = CGRectMake(210, 37, 85, 21);
        _userTimeLable.font = [UIFont systemFontOfSize:14];
        _userTimeLable.textColor = RGBCOLOR(167, 167, 167);
        
    
        _userTimeLable.text = [reviewInfo objectForKey:@"PUBLISHTIME"];
        [_review addSubview:_userTimeLable];
        [_userTimeLable release];
        
        UILabel *_reviewLable =  [[UILabel alloc] init];
        _reviewLable.frame = CGRectMake(65, 70, 230, 21);
        _reviewLable.font = [UIFont systemFontOfSize:15];
        _reviewLable.text = [reviewInfo objectForKey:@"MOVIECOMMENTCONTENT"];
        [_review addSubview:_reviewLable];
        [_reviewLable release];
        
        if ([[moveData objectForKey:@"list"] count]>=2) {
            UIImageView *_line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line1.png")];
            _line.frame = CGRectMake(1, 98, 298, 1);
            [_review addSubview:_line];
            [_line release];
            
            reviewInfo = [[moveData objectForKey:@"list"] objectAtIndex:1];
            UIImageView *_avatar2 = [[UIImageView alloc] init];
            [_avatar2 setImageWithURL:[NSURL URLWithString:[reviewInfo objectForKey:@"USERHEADPICURL"]]
                    placeholderImage:TTIMAGE(@"bundle://face1.png")];
            _avatar2.frame = CGRectMake(10, 110, 50, 50);
            [_review addSubview:_avatar2];
            [_avatar2 release];
            
            UILabel *_userNameLable2 = [[UILabel alloc] init];
            _userNameLable2.frame = CGRectMake(65, 110, 145, 21);
            _userNameLable2.font = [UIFont systemFontOfSize:16];
            _userNameLable2.textColor = RGBCOLOR(40, 94, 198);
            _userNameLable2.text = [[reviewInfo objectForKey:@"USERNAME"] isEmptyOrWhitespace]?@"票啦啦":[reviewInfo objectForKey:@"USERNAME"];
            [_review addSubview:_userNameLable2];
            [_userNameLable2 release];
            
            UILabel *_userTimeLable2 = [[UILabel alloc] init];
            _userTimeLable2.frame = CGRectMake(210, 110, 85, 21);
            _userTimeLable2.font = [UIFont systemFontOfSize:14];
            _userTimeLable2.textColor = RGBCOLOR(167, 167, 167);
            _userTimeLable2.text = [reviewInfo objectForKey:@"PUBLISHTIME"];
            [_review addSubview:_userTimeLable2];
            [_userTimeLable2 release];
            
            UILabel *_reviewLable2 =  [[UILabel alloc] init];
            _reviewLable2.frame = CGRectMake(65, 140, 230, 21);
            _reviewLable2.font = [UIFont systemFontOfSize:15];
            _reviewLable2.text =[reviewInfo objectForKey:@"MOVIECOMMENTCONTENT"];
            [_review addSubview:_reviewLable2];
            [_reviewLable2 release];
        }else{
            _review.frame = CGRectMake(10, 265, 300, 100);
        }
        
        if ([[moveData objectForKey:@"list"] count]>=3) {
            UIButton *_reviewListButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_reviewListButton setBackgroundImage:TTIMAGE(@"bundle://tag1_button.png") forState:UIControlStateNormal];
            [_reviewListButton setBackgroundImage:TTIMAGE(@"bundle://tag1_button_1.png") forState:UIControlStateHighlighted];
            [_reviewListButton addTarget:self action:@selector(reviewListAction) 
                        forControlEvents:UIControlEventTouchUpInside];
            _reviewListButton.frame = CGRectMake(225, 430, 73, 29);
            [_reviewListButton setTitle:@"全部评论▲" forState:UIControlStateNormal];
            _reviewListButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [self.view addSubview:_reviewListButton];
            
        }
    }else{
        [self openAction:nil];
    }
    
    [self.view bringSubviewToFront:_Introduction];
    [self.view addSubview:_backGround];
    [self.view sendSubviewToBack:_backGround];
    [self.view addSubview:_navigationHeader];
}

-(void)msgAdd{
    if (_isOpen) {
        [self openAction:nil];
    }
    [_review removeFromSuperview];
    //海报选中
    [kAppDelegate HUDShow:@"查询中" yOffset:@"0"];
    //请求详情
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    
    [postData setObject:@"0103" forKey:@"OP"];
    
    
    //    NSLog(@"MOVIECODE1 %@",[[[interestingPhotosDictionary objectForKey:@"list"]
    //                             objectAtIndex:_posterCarousel.currentItemIndex] 
    //                            objectForKey:@"MOVIECODE"]);
    

    
    [postData setObject:[kAppDelegate.temporaryValues  
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
    
    
    
    //NSLog(@"list %@",detailDictionary);
    if (TTIsArrayWithItems([[detailDictionary objectForKey:@"FILMINFO"] objectForKey:@"list"])) {
        _review = [[[TTView alloc] initWithFrame:CGRectMake(10, 265, 300, 190)] autorelease];
        _review.backgroundColor = [UIColor clearColor];
        _review.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
                         [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                          [TTSolidBorderStyle styleWithColor:RGBCOLOR(158, 163, 172) width:1 next:nil]]];
        [self.view addSubview:_review];
        //[self.view sendSubviewToBack:_review];
        
        UILabel *_nameLable1 = [[UILabel alloc] init];
        _nameLable1.backgroundColor = [UIColor clearColor];
        _nameLable1.font = [UIFont systemFontOfSize:18];
        _nameLable1.textAlignment = UITextAlignmentLeft;
        _nameLable1.text = @"影片评论";
        _nameLable1.frame = CGRectMake(10, 12, 200, 20);
        [_review addSubview:_nameLable1];
        [_nameLable1 release];
        
        
        NSDictionary *reviewInfo = [[[detailDictionary objectForKey:@"FILMINFO"] objectForKey:@"list"] objectAtIndex:0];
        UIImageView *_avatar = [[UIImageView alloc] init];
        [_avatar setImageWithURL:[NSURL URLWithString:[reviewInfo objectForKey:@"USERHEADPICURL"]]
                placeholderImage:TTIMAGE(@"bundle://face1.png")];
        _avatar.frame = CGRectMake(10, 40, 50, 50);
        [_review addSubview:_avatar];
        [_avatar release];
        
        UILabel *_userNameLable = [[UILabel alloc] init];
        _userNameLable.frame = CGRectMake(65, 37, 145, 21);
        _userNameLable.font = [UIFont systemFontOfSize:16];
        _userNameLable.textColor = RGBCOLOR(40, 94, 198);
        _userNameLable.text =[[reviewInfo objectForKey:@"USERNAME"] isEmptyOrWhitespace]?@"票啦啦":[reviewInfo objectForKey:@"USERNAME"];
        [_review addSubview:_userNameLable];
        [_userNameLable release];
        
        UILabel *_userTimeLable = [[UILabel alloc] init];
        _userTimeLable.frame = CGRectMake(210, 37, 85, 21);
        _userTimeLable.font = [UIFont systemFontOfSize:14];
        _userTimeLable.textColor = RGBCOLOR(167, 167, 167);
        
        
        _userTimeLable.text = [reviewInfo objectForKey:@"PUBLISHTIME"];
        [_review addSubview:_userTimeLable];
        [_userTimeLable release];
        
        UILabel *_reviewLable =  [[UILabel alloc] init];
        _reviewLable.frame = CGRectMake(65, 70, 230, 21);
        _reviewLable.font = [UIFont systemFontOfSize:15];
        _reviewLable.text = [reviewInfo objectForKey:@"MOVIECOMMENTCONTENT"];
        [_review addSubview:_reviewLable];
        [_reviewLable release];
        
        if ([[[detailDictionary objectForKey:@"FILMINFO"] objectForKey:@"list"] count]>=2) {
            UIImageView *_line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line1.png")];
            _line.frame = CGRectMake(1, 98, 298, 1);
            [_review addSubview:_line];
            [_line release];
            
            reviewInfo = [[[detailDictionary objectForKey:@"FILMINFO"] objectForKey:@"list"] objectAtIndex:1];
            UIImageView *_avatar2 = [[UIImageView alloc] init];
            [_avatar2 setImageWithURL:[NSURL URLWithString:[reviewInfo objectForKey:@"USERHEADPICURL"]]
                     placeholderImage:TTIMAGE(@"bundle://face1.png")];
            _avatar2.frame = CGRectMake(10, 110, 50, 50);
            [_review addSubview:_avatar2];
            [_avatar2 release];
            
            UILabel *_userNameLable2 = [[UILabel alloc] init];
            _userNameLable2.frame = CGRectMake(65, 110, 145, 21);
            _userNameLable2.font = [UIFont systemFontOfSize:16];
            _userNameLable2.textColor = RGBCOLOR(40, 94, 198);
            _userNameLable2.text = [[reviewInfo objectForKey:@"USERNAME"] isEmptyOrWhitespace]?@"票啦啦":[reviewInfo objectForKey:@"USERNAME"];
            [_review addSubview:_userNameLable2];
            [_userNameLable2 release];
            
            UILabel *_userTimeLable2 = [[UILabel alloc] init];
            _userTimeLable2.frame = CGRectMake(210, 110, 85, 21);
            _userTimeLable2.font = [UIFont systemFontOfSize:14];
            _userTimeLable2.textColor = RGBCOLOR(167, 167, 167);
            _userTimeLable2.text = [reviewInfo objectForKey:@"PUBLISHTIME"];
            [_review addSubview:_userTimeLable2];
            [_userTimeLable2 release];
            
            UILabel *_reviewLable2 =  [[UILabel alloc] init];
            _reviewLable2.frame = CGRectMake(65, 140, 230, 21);
            _reviewLable2.font = [UIFont systemFontOfSize:15];
            _reviewLable2.text =[reviewInfo objectForKey:@"MOVIECOMMENTCONTENT"];
            [_review addSubview:_reviewLable2];
            [_reviewLable2 release];
        }else{
            _review.frame = CGRectMake(10, 265, 300, 100);
        }
        
        if ([[[detailDictionary objectForKey:@"FILMINFO"] objectForKey:@"list"] count]>=3) {
            UIButton *_reviewListButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_reviewListButton setBackgroundImage:TTIMAGE(@"bundle://tag1_button.png") forState:UIControlStateNormal];
            [_reviewListButton setBackgroundImage:TTIMAGE(@"bundle://tag1_button_1.png") forState:UIControlStateHighlighted];
            [_reviewListButton addTarget:self action:@selector(reviewListAction) 
                        forControlEvents:UIControlEventTouchUpInside];
            _reviewListButton.frame = CGRectMake(225, 430, 73, 29);
            [_reviewListButton setTitle:@"全部评论▲" forState:UIControlStateNormal];
            _reviewListButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [self.view addSubview:_reviewListButton];
            
        }
        [self.view bringSubviewToFront:_Introduction];
    }else{
        [self openAction:nil];
    }
}

-(void)openAction:(id)sender{
    [UIView beginAnimations:@"" context:nil];
    
    _Introduction.frame = CGRectMake(10, 216, 300, (_isOpen?44:240));
    _openArrow.image = (_isOpen?TTIMAGE(@"bundle://arrow3.png"):TTIMAGE(@"bundle://arrow4.png"));
    _openArrow.transform = CGAffineTransformRotate(_openArrow.transform, ((_isOpen?-90:90)/57.3));
    _introductionText.hidden = _isOpen;
    [UIView setAnimationDuration:0.5];
    [UIView commitAnimations];
    _isOpen = !_isOpen;
}

-(void)failUpdata{
    [kAppDelegate HUDHide];
    [kAppDelegate alert:@"错误" message:@"网络链接失败"];
}

-(void)reviewListAction{
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://modal/viewController/ReviewListViewController"];
    urlAction.animated = YES;
    [[TTNavigator navigator] openURLAction:urlAction];
}

-(void)reviewAction{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults dictionaryForKey:@"USERINFO"]) {
        TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://modal/viewController/WriteReviewViewController"];
        urlAction.animated = YES;
        [[TTNavigator navigator] openURLAction:urlAction];
    }else{
        [self pushLogin:@"perLoadData"];

    }
//    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://modal/viewController/WriteReviewViewController"];
}

-(void)pushLogin:(NSString*)selectName{
	LoginAndRegisterViewController *controller =  (LoginAndRegisterViewController*)[kAppDelegate loadFromVC:@"LoginAndRegisterViewController"];
	controller.delegate = self;
	controller.stringSelect = selectName;
	[self.navigationController pushViewController:controller animated:YES];
}

-(void)perLoadData{
	[self.navigationController popViewControllerAnimated:YES];
	[self reviewAction];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)payAction{
    [kAppDelegate.temporaryValues setObject:@"1" forKey:@"order" ];
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/CinemaListViewController"];
    urlAction.animated = YES;
    [[TTNavigator navigator] openURLAction:urlAction];
}

-(void)forwardAction{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults dictionaryForKey:@"USERINFO"]) {
        [kAppDelegate HUDShow:@"" yOffset:@"0"];
        //请求详情
        NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
        
        [postData setObject:@"0107" forKey:@"OP"];
        
        
        [postData setObject:[kAppDelegate.temporaryValues  
                             objectForKey:@"MOVIECODE"]
                     forKey:@"MOVIECODE"];//影片ID
        
        [postData setObject:[[defaults dictionaryForKey:@"USERINFO"] 
                             objectForKey:@"USERID"]
                     forKey:@"USERCODE"];
        
        ASIHTTPRequest *detailRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
        
        [detailRequest setRequestMethod:@"POST"];
        [detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
                                     [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData release];
        [detailRequest setDelegate:self];
        detailRequest.didFinishSelector = @selector(forwardFinishUpdata:);
        detailRequest.didFailSelector = @selector(failUpdata:);
        [detailRequest startAsynchronous];
    }else{
        [self pushLogin:@"perLoadforward"];
    }
}

-(void)forwardFinishUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	NSDictionary *detailDictionary = [[JSONDecoder decoder] 
                                      objectWithData:[request responseData]];
    //NSLog(@"detailDictionary %@",detailDictionary);
    _screen.text = [NSString stringWithFormat:@"期待人数:%@",[detailDictionary objectForKey:@"NUM"]];
    [kAppDelegate showWithCustomView:[detailDictionary objectForKey:@"RESULTDESC"]];
    
}

-(void)perLoadforward{
	[self.navigationController popViewControllerAnimated:YES];
	[self forwardAction];
}

@end
