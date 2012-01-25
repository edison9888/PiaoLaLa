//
//  TPOrderDetailViewController.m
//  PiaoLaLaApp
//
//  Created by 高飞 on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "TPOrderDetailViewController.h"
#import "AlipayConnect.h"
#import "NSStringAdditions.h"
@implementation TPOrderDetailViewController
@synthesize back = _back;
@synthesize areaLabel = _areaLabel;
@synthesize timeLabel = _timeLabel;
@synthesize cinemaLabel = _cinemaLabel;
@synthesize typeLabel = _typeLabel;
@synthesize numLabel =_numLabel;
@synthesize priceLabel =_priceLabel;
@synthesize phoneField = _phoneField;
@synthesize singleLabel = _singleLabel;
@synthesize pay = _pay;

-(void)dealloc{
    TT_RELEASE_SAFELY(_pay);
    [super dealloc];
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

-(void)loadView{
    [super loadView];
    //导航条
    UIImageView *_navigationHeader = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://titlebar02.png")] autorelease];
    [_navigationHeader setUserInteractionEnabled:YES];
    _navigationHeader.frame = CGRectMake(0, 0, 320, 44);
    
    
    UIImageView *_backGround = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://background02.png")] autorelease];
    _backGround.frame = CGRectMake(0, 44, 320, 420);
    [self.view addSubview:_backGround];
    [self.view sendSubviewToBack:_backGround];
    [self.view addSubview:_navigationHeader];
    
    self.back.backgroundColor = [UIColor clearColor];
    self.back.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
                       [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                        [TTSolidBorderStyle styleWithColor:RGBCOLOR(158, 163, 172) width:1 next:nil]]];
    
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.text = @"订单确认";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0, (22/2), 320, 22);
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_navigationHeader addSubview:_titleLabel];
    [_titleLabel release];
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button1_1.png")  forState:UIControlStateNormal];
    [_backButton setBackgroundImage:TTIMAGE(@"bundle://button1_2.png")  forState:UIControlStateHighlighted];
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    _backButton.frame = CGRectMake(5, (44-29)/2, 50, 29);
    [_navigationHeader addSubview:_backButton];
    
    self.cinemaLabel.text = [[kAppDelegate.temporaryValues 
                              objectForKey:@"SelsectCINEMA"] 
                             objectForKey:@"CINEMANAME"];
    
   // NSLog(@"orderTicket %@",[kAppDelegate.temporaryValues objectForKey:@"orderTicket"]);
    
    self.typeLabel.text = [[kAppDelegate.temporaryValues objectForKey:@"orderTicket"] 
                           objectForKey:@"TICKETNAME"];
    
    self.priceLabel.text = [kAppDelegate.temporaryValues objectForKey:@"orderPrice"];
    
    self.areaLabel.text = [[kAppDelegate.temporaryValues 
                            objectForKey:@"selectCity"]
                           objectForKey:@"CITYNAME"] ;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![[defaults objectForKey:@"userPhone"] isEmptyOrWhitespace]) {
        self.phoneField.text = [defaults objectForKey:@"userPhone"];
    }
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)buyConfirm{
    if ([self.phoneField.text isEmptyOrWhitespace]||[self.phoneField.text length]<11) {
        [kAppDelegate alert:@"错误" message:@"请正确输入电话号码！"];
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.phoneField.text forKey:@"userPhone"];
    [defaults synchronize];
    
    NSMutableDictionary *_order = [NSMutableDictionary dictionaryWithCapacity:9];
    [_order setObject:[[kAppDelegate.temporaryValues 
                        objectForKey:@"selectCity"]
                       objectForKey:@"CITYCODE"] forKey:@"CITYID"];
    
    
    [_order setObject:[[kAppDelegate.temporaryValues 
                        objectForKey:@"SelsectCINEMA"] 
                       objectForKey:@"CINEMACODE"]
               forKey:@"FIRMID"];
    
    [_order setObject:[[kAppDelegate.temporaryValues 
                        objectForKey:@"orderTicket"] 
                       objectForKey:@"TICKETCODE"]
               forKey:@"TICKETID"];
    
    [_order setObject:[kAppDelegate.temporaryValues 
                        objectForKey:@"orderNum"] 
               forKey:@"TICKETNUM"];
    
    [_order setObject:[[defaults objectForKey:@"USERINFO"] 
                       objectForKey:@"USERID"]
               forKey:@"USERID"];
    
    [_order setObject:self.phoneField.text forKey:@"MOBILENO"];
    
    [_order setObject:@"102" forKey:@"PAYWAYID"];
    
    [_order setObject:@"000001" forKey:@"CHANELID"];
    
    [_order setObject:@"1" forKey:@"ORDERDETAILSEAT"];
    
    //NSLog(@"order %@",_order);
    
    [kAppDelegate HUDShow:@"" yOffset:@"0"];
    AlipayConnect *temp = [[AlipayConnect alloc] init];
    self.pay = temp;
    [temp release];
    self.pay.delegate = self;
    [self.pay servicesAlipay:_order];
}

- (void)setWebError:(NSString *) str{
	[kAppDelegate HUDHide];
	[kAppDelegate alert:@"" message:str];
}



-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.back.frame = CGRectMake(self.back.frame.origin.x, -90, self.back.frame.size.width, self.back.frame.size.height);
}
@end
