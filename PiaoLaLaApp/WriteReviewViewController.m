//
//  WriteReviewViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "WriteReviewViewController.h"
#import "DLStarRatingControl.h"
#import "NSStringAdditions.h"
@implementation WriteReviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    //NSLog(@"UserProfileViewController initWithNibName");
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
    [_introductionText becomeFirstResponder];

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
    
    [self.view addSubview:_backGround];
    [self.view sendSubviewToBack:_backGround];
    [self.view addSubview:_navigationHeader];
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button7_1.png")  forState:UIControlStateNormal];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button7_2.png")  forState:UIControlStateHighlighted];
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setTitle:@"取消" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    _backButton.frame = CGRectMake(5, (44-29)/2, 50, 29);
    [_navigationHeader addSubview:_backButton];
    
    UIButton *_reviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reviewButton setBackgroundImage:TTIMAGE(@"bundle://button7_1.png")  forState:UIControlStateNormal];
    [_reviewButton setBackgroundImage:TTIMAGE(@"bundle://button7_2.png")  forState:UIControlStateHighlighted];
    [_reviewButton setTitle:@"发布" forState:UIControlStateNormal];
    [_reviewButton addTarget:self action:@selector(sendReview) forControlEvents:UIControlEventTouchUpInside];
    _reviewButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _reviewButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    _reviewButton.frame = CGRectMake((320-55), (44-29)/2, 50, 29);
    
    [_navigationHeader addSubview:_reviewButton];
    
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.text = @"我要评论";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0, (22/2), 320, 22);
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_navigationHeader addSubview:_titleLabel];
    [_titleLabel release];
    
     TTView *_back = [[[TTView alloc] initWithFrame:CGRectMake(10,54, 300, 120)] autorelease];
    _back.backgroundColor = [UIColor clearColor];
    _back.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
                     [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                      [TTSolidBorderStyle styleWithColor:RGBCOLOR(158, 163, 172) width:1 next:nil]]];
    [self.view addSubview:_back];
    
    _introductionText = [[UITextView alloc] initWithFrame:CGRectMake(1, 1, 299, 119)];
    _introductionText.delegate = self;
    _introductionText.backgroundColor = [UIColor clearColor];
    _introductionText.font = [UIFont systemFontOfSize:14];
    [_back addSubview:_introductionText];
    
    _wordsLabel = [[UILabel alloc] init];
    _wordsLabel.font = [UIFont systemFontOfSize:14];
    _wordsLabel.textColor = [UIColor whiteColor];
    _wordsLabel.backgroundColor = [UIColor clearColor];
    _wordsLabel.text = @"还可以输入140字";
    _wordsLabel.frame = CGRectMake(200, 179, 120, 21);
    [self.view addSubview:_wordsLabel];
    [_wordsLabel release];
    
    UILabel *_scoresLabel = [[UILabel alloc] init];
    _scoresLabel.font = [UIFont systemFontOfSize:14];
    _scoresLabel.textColor = [UIColor whiteColor];
    _scoresLabel.backgroundColor = [UIColor clearColor];
    _scoresLabel.text = @"评分";
    _scoresLabel.frame = CGRectMake(10, 179, 30, 21);
    [self.view addSubview:_scoresLabel];
    [_scoresLabel release];
    
    
    DLStarRatingControl *customNumberOfStars = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(40, 165, 100, 30) andStars:5];
	customNumberOfStars.backgroundColor = [UIColor clearColor];
	customNumberOfStars.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	customNumberOfStars.rating = 4;
	[self.view addSubview:customNumberOfStars];
    [customNumberOfStars release];
}

//发送评论
-(void)sendReview{    
    if ([_introductionText.text isEmptyOrWhitespace]) {
        [kAppDelegate alert:@"提示" message:@"请输入评论内容"];
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[kAppDelegate HUDShow:@"查询中" yOffset:@"0"];
		NSDictionary *moveData = [kAppDelegate.temporaryValues objectForKey:@"moveDetail"];
		NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
		
		[postData setObject:@"0105" forKey:@"OP"];
		[postData setObject:@"0" forKey:@"PARENTCODE"];
		[postData setObject:[moveData objectForKey:@"MOVIECODE"] forKey:@"MOVIECODE"];
		[postData setObject:[[defaults dictionaryForKey:@"USERINFO"] objectForKey:@"USERID"] forKey:@"USERCODE"];
		[postData setObject:_introductionText.text forKey:@"MOVIECOMMENTCONTENT"];
		
		ASIHTTPRequest *post  = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
		[post setRequestMethod:@"POST"];
		[post setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
							[postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
		[postData release];
		
		[post startSynchronous];
		[kAppDelegate HUDHide];
		NSError *error = [post error];
		if (!error&&[[[[JSONDecoder decoder] objectWithData:[post responseData]] objectForKey:@"RESULTCODE"] intValue]==0) {
			[kAppDelegate showWithCustomView:@"发表成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"msgAdd" object:nil];
            [self backAction];
            
		}else {
			[kAppDelegate alert:@"" message:@"提交失败超时或者服务器错误"];
		}
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    _wordsLabel.text = [NSString stringWithFormat:@"还可以输入%d字",(140-textView.text.length)];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text {
    if (range.location>=140)   
    {  
        return  NO;  
    }  
    else   
    {  
        return YES;  
    }  
}

-(void)backAction{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
