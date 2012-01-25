//
//  UserHeaderView.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserHeaderView.h"
#import "UIImageView+WebCache.h"
@implementation UserHeaderView

-(void)dealloc{
    TT_RELEASE_SAFELY(_imageFrame);
    TT_RELEASE_SAFELY(_avatar);
    TT_RELEASE_SAFELY(_name);
    [super dealloc];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageFrame.frame = CGRectMake(10, 10, 85, 85);
    self.avatar.frame = CGRectMake(17, 17, 68, 68);
    self.modfiyButton.frame = CGRectMake(10, 10, 85, 85);
    self.name.frame = CGRectMake(105, 42, 210, 21);
}


-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont boldSystemFontOfSize:20];
        _name.textColor = [UIColor whiteColor];
        _name.backgroundColor = [UIColor clearColor];
        [self addSubview:_name];
    }
    return _name;
}

-(UIButton *)modfiyButton{
    if (!_modfiyButton) {
        _modfiyButton =[UIButton buttonWithType:UIButtonTypeCustom];
    }
    return  _modfiyButton;
}


-(UIImageView *)imageFrame{
    if (!_imageFrame) {
        _imageFrame = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://face_bg.png")];
        [self addSubview:_imageFrame];
    }
    return _imageFrame;
}

-(UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
        _avatar.backgroundColor = [UIColor clearColor];
        [self addSubview:_avatar];
    }
    return _avatar;
}

@end
