//
//  LoginViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "NSStringAdditions.h"
#import "ASIHTTPRequest.h"
#import "ToolUntil.h"
@implementation LoginViewController




-(void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView *_back = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://dlmb.png")];
    _back.frame = CGRectMake(10, 5, 300, 89);
    [self.view addSubview:_back];
    [_back release];
    
    _nameField = [[UITextField alloc] init];
    _nameField.placeholder = @"请输入手机或邮箱";
    _nameField.borderStyle =  UITextBorderStyleNone;
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameField.keyboardType = UIKeyboardTypeEmailAddress;
    _nameField.font = [UIFont systemFontOfSize:14];
    _nameField.textColor = [UIColor grayColor];
    //_nameField.keyboardType = UIKeyboardTypePhonePad;
    _nameField.frame = CGRectMake(105, 19, 200, 21);
    [self.view addSubview:_nameField];
    [_nameField release];
    
    
    _passField = [[UITextField alloc] init];
    _passField.placeholder = @"请输入密码";
    _passField.secureTextEntry = YES;
    _passField.borderStyle =  UITextBorderStyleNone;
    _passField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passField.keyboardType = UIKeyboardTypeASCIICapable;
    _passField.font = [UIFont systemFontOfSize:14];
    _passField.textColor = [UIColor grayColor];
    _passField.frame = CGRectMake(105, 63, 200, 21);
    [self.view addSubview:_passField];
    [_passField release];
    
    UIButton *_loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setBackgroundImage:TTIMAGE(@"bundle://buttonlogin_1.png") forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:TTIMAGE(@"bundle://buttonlogin_2.png") forState:UIControlStateHighlighted];
    [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:20];
    _loginButton.titleLabel.textColor = [UIColor whiteColor];
    _loginButton.frame = CGRectMake(10, 100, 300, 45);
    [self.view addSubview:_loginButton];
}

-(void)login{
    //验证是否正确为手机号码
    
	if (![_nameField.text isEmptyOrWhitespace]) {
		
		[kAppDelegate HUDShow:@"登陆中" yOffset:@"0"];
		NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
		[postData setObject:@"0403" forKey:@"OP"];
		
		[postData setObject:_nameField.text forKey:@"MOBILENO"];
		[postData setObject:[_passField.text MD5] forKey:@"PWD"];
		
		ASIHTTPRequest * request = [ToolUntil requestCreate:self postData:postData];
		request.didFailSelector = @selector(fail:);
		request.didFinishSelector = @selector(finishRequest:);
		[request startAsynchronous];
		[postData release];
	}else{
		[kAppDelegate alert:@"" message:@"请填写账号"];
		[_nameField performSelector:@selector(becomeFirstResponder)
						withObject:nil
						afterDelay:0.0];
	}
}

-(void)finishRequest:(ASIHTTPRequest *)request{
    [kAppDelegate HUDHide];
	NSDictionary *json =[[JSONDecoder decoder] objectWithData:[request responseData]];
    NSLog(@"json %@",[json objectForKey:@"RESULTDESC"]);
    if ([[json objectForKey:@"RESULTCODE"] isEqualToString:@"0"]) {
		//保存用户ID　
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        
        [userInfo setObject:[[json objectForKey:@"LOGININFO"] objectForKey:@"MOBILE"]
                     forKey:@"MOBILE"];
        
        [userInfo setObject:[[json objectForKey:@"LOGININFO"] objectForKey:@"USERID"] forKey:@"USERID"];
        [defaults setObject:userInfo forKey:@"USERINFO"];
        [defaults synchronize];
        
		[[NSNotificationCenter defaultCenter] postNotificationName:@"userLogin" object:nil];
    }else{
        [kAppDelegate alert:@"" message:[json objectForKey:@"RESULTDESC"] ];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_nameField becomeFirstResponder];
}


@end
