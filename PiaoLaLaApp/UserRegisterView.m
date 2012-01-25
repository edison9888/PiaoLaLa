//
//  UserRegisterView.m
//  piaoLaLa
//
//  Created by 高飞 on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserRegisterView.h"

@implementation UserRegisterView

-(void) dealloc{
    TT_RELEASE_SAFELY(_passField);
    TT_RELEASE_SAFELY(_backFrame);
    TT_RELEASE_SAFELY(_nameField);
    TT_RELEASE_SAFELY(_emailField);
    TT_RELEASE_SAFELY(_aliasField);
	[super dealloc];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backFrame.frame = CGRectMake(10, 10, 300, 134);
    self.emailField.frame = CGRectMake(123,25,200,21);
    self.passField.frame = CGRectMake(68, 67, 200, 21);
    self.aliasField.frame = CGRectMake(68, 111, 200, 21);
    //self.nameField.frame = CGRectMake(84, 158, 200, 21);
    self.loginButton.frame = CGRectMake(10, 148, 300, 45);
}

-(UIImageView *) backFrame{
	if (!_backFrame) {
		_backFrame = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://zcmb.png")];
		[self addSubview:_backFrame];
	}
	return _backFrame;
}

-(UITextField *) nameField{
	if (!_nameField) {
		_nameField = [[UITextField alloc] init];
		_nameField.placeholder = @"请输入手机号";
        _nameField.text = @"";
		_nameField.borderStyle =  UITextBorderStyleNone;
		_nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_nameField.keyboardType = UIKeyboardTypeEmailAddress;
		_nameField.font = [UIFont systemFontOfSize:15];
		[self addSubview:_nameField];
	}
	return _nameField;
}

-(UITextField *) passField{
	if (!_passField) {
		_passField = [[UITextField alloc] init];
		_passField.placeholder = @"请输入密码";
        _passField.text = @"";
		_passField.borderStyle =  UITextBorderStyleNone;
		_passField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_passField.keyboardType = UIKeyboardTypeASCIICapable;
        _passField.secureTextEntry = YES;
		_passField.font = [UIFont systemFontOfSize:15];
		[self addSubview:_passField];
	}
	return _passField;
}

-(UITextField *) emailField{
	if (!_emailField) {
		_emailField = [[UITextField alloc] init];
		_emailField.placeholder = @"请输入手机或/邮箱";
        _emailField.text = @"";
		_emailField.borderStyle =  UITextBorderStyleNone;
		_emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_emailField.keyboardType = UIKeyboardTypeEmailAddress;
		_emailField.font = [UIFont systemFontOfSize:15];
		[self addSubview:_emailField];
	}
	return _emailField;
}

-(UITextField *) aliasField{
	if (!_aliasField) {
		_aliasField = [[UITextField alloc] init];
		_aliasField.placeholder = @"请输入昵称";
        _aliasField.text = @"";
		_aliasField.borderStyle =  UITextBorderStyleNone;
		_aliasField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_aliasField.font = [UIFont systemFontOfSize:15];
		[self addSubview:_aliasField];
	}
	return _aliasField;
}

-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundImage:TTIMAGE(@"bundle://buttonlogin_1.png") forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:TTIMAGE(@"bundle://buttonlogin_2.png") forState:UIControlStateHighlighted];
        [_loginButton setTitle:@"注 册" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:20];
        _loginButton.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_loginButton];
    }
    return _loginButton;
}

@end
