//
//  RegisterViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserRegisterView.h"
#import "NSStringAdditions.h"
#import "ToolUntil.h"
@implementation RegisterViewController


-(void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor clearColor];
    _registerView = [[UserRegisterView alloc] init];
    _registerView.frame = CGRectMake(0, 0, 320, 450);
    scro = [[UIScrollView alloc] init];
    scro.frame = CGRectMake(0, 0, 320, 300);
    [scro addSubview:_registerView];
    [_registerView release];
    [_registerView.loginButton addTarget:self
                                  action:@selector(loginAction)
                        forControlEvents:UIControlEventTouchUpInside];
    
    scro.contentSize = CGSizeMake(320, 400);
     [self.view addSubview:scro];
    [scro release];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _registerView.aliasField.delegate = self;
    _registerView.nameField.delegate = self;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    scro.contentOffset = CGPointMake(0, 90);
    return  YES;
}

//登陆
-(void)loginAction{
//    if ( [_registerView.nameField.text isEmptyOrWhitespace]) {
//        [kAppDelegate alert:@"" message:@"请输入登录的手机号码"];
//		return;
//    }
//    if ([_registerView.aliasField.text isEmptyOrWhitespace]) {
//        [kAppDelegate alert:@"" message:@"请输入昵称"];
//		return;
//    }
    if ([_registerView.passField.text isEmptyOrWhitespace]) {
        [kAppDelegate alert:@"" message:@"请输密码"];
		return;
    }
    if ([_registerView.emailField.text isEmptyOrWhitespace]) {
        [kAppDelegate alert:@"" message:@"请输手机或邮箱"];
		return;
    }
    
    [kAppDelegate HUDShow:@"登录中" yOffset:@"0"];
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    [postData setObject:@"0402" forKey:@"OP"];
    [postData setObject:_registerView.nameField.text forKey:@"MOBILENO"];
    [postData setObject:[_registerView.passField.text MD5] forKey:@"PWD"];
    [postData setObject:_registerView.aliasField.text forKey:@"NICKNAME"];
    [postData setObject:@"" forKey:@"BIRTHDAY"];
    [postData setObject:@"" forKey:@"USERIMG"];
    [postData setObject:_registerView.emailField.text forKey:@"EMAIL"];
    [postData setObject:@"000001" forKey:@"CHANELID"];
    ASIHTTPRequest * request = [ToolUntil requestCreate:self postData:postData];
    request.didFailSelector = @selector(fail:);
    request.didFinishSelector = @selector(finishRequest:);
    [request startAsynchronous];
    [postData release];
}

-(void)finishRequest:(ASIHTTPRequest *)request{
    [kAppDelegate HUDHide];
	NSDictionary *json =[[JSONDecoder decoder] objectWithData:[request responseData]];
    // NSLog(@"json %@",json);
    if ([[json objectForKey:@"RESULTCODE"] isEqualToString:@"0"]) {
		//保存用户ID　
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        
        [userInfo setObject:[[json objectForKey:@"REGISTERINFO"] objectForKey:@"MOBILE"]
                     forKey:@"MOBILE"];
        
        [userInfo setObject:[[json objectForKey:@"REGISTERINFO"] objectForKey:@"USERID"] forKey:@"USERID"];
        [defaults setObject:userInfo forKey:@"USERINFO"];
        [defaults synchronize];
        
		[[NSNotificationCenter defaultCenter] postNotificationName:@"userLogin" object:nil];
    }else{
        [kAppDelegate alert:@"" message:[json objectForKey:@"RESULTDESC"] ];
    }
}

-(void)fail:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	[kAppDelegate alert:@"" message:@"超时或者服务器错误"];
}


@end
