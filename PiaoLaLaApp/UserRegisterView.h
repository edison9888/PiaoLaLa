//
//  UserRegisterView.h
//  piaoLaLa
//
//  Created by 高飞 on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//


@interface UserRegisterView : UIView{
    UIImageView *_backFrame;
    UITextField *_nameField;
    UITextField *_passField;
    UITextField *_emailField;
    UITextField *_aliasField;
    UIButton *_loginButton;
}
@property (nonatomic, readonly) IBOutlet UITextField *nameField;
@property (nonatomic, readonly) IBOutlet UITextField *passField;
@property (nonatomic, readonly) IBOutlet UITextField *emailField;
@property (nonatomic, readonly) IBOutlet UITextField *aliasField;
@property (nonatomic, readonly) IBOutlet UIImageView *backFrame;
@property (nonatomic, readonly) IBOutlet UIButton *loginButton;
@end
