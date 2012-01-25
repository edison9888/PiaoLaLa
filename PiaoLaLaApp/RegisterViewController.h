//
//  RegisterViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  注册

@class UserRegisterView;

@interface RegisterViewController : TTViewController<UITextFieldDelegate>{
    UserRegisterView *_registerView;
    UIScrollView *scro;
}

@end
