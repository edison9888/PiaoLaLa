//
//  LoginViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  登陆
@class UserLoginView;

@interface LoginViewController : TTViewController{
    UserLoginView *_login;
    UITextField *_nameField;
    UITextField *_passField;
}
@end
