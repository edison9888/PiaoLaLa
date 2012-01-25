//
//  ReviewListCell.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ReviewListCell.h"
#import "UIImageView+WebCache.h"
#import "NSStringAdditions.h"

@implementation ReviewListCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_userNameLable);
    TT_RELEASE_SAFELY(_userTimeLable);
    TT_RELEASE_SAFELY(_avatar);
    TT_RELEASE_SAFELY(_reviewLable);
    [super dealloc];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.avatar.frame = CGRectMake(20, 8, 50, 50);
    self.userNameLable.frame = CGRectMake(75, 7, 200, 21);
    self.userTimeLable.frame = CGRectMake(223, 7, 85, 21);
    self.reviewLable.frame = CGRectMake(75, 37, 230, 21);
}

-(void) setObject:(id)object{
	if (_item != object) {
		[_item release];
		_item = [object retain];
        TTTableTextItem* item = object;
		self.accessoryType = UITableViewCellAccessoryNone;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.avatar.image = TTIMAGE(@"bundle://face1.png");
        
        [self.avatar setImageWithURL:[NSURL URLWithString:[item.userInfo objectForKey:@"USERHEADPICURL"]] 
                    placeholderImage:TTIMAGE(@"bundle://face1.png")];
        
        self.userNameLable.text = [[item.userInfo objectForKey:@"USERNAME"] isEmptyOrWhitespace]?
        @"票啦啦":[item.userInfo objectForKey:@"USERNAME"];
        self.userTimeLable.text = [item.userInfo objectForKey:@"PUBLISHTIME"];
        self.reviewLable.text = [item.userInfo objectForKey:@"MOVIECOMMENTCONTENT"];
    }
}


-(UILabel *)userNameLable{
    if (!_userNameLable) {
        _userNameLable = [[UILabel alloc] init];
        _userNameLable.textColor = RGBCOLOR(40, 94, 198);
        _userNameLable.backgroundColor = [UIColor clearColor];
        _userNameLable.font = [UIFont systemFontOfSize:16];
        [self addSubview:_userNameLable];
    }
    return _userNameLable;
}

-(UILabel *)userTimeLable{
    if (!_userTimeLable) {
        _userTimeLable = [[UILabel alloc] init];
        _userTimeLable.backgroundColor = [UIColor clearColor];
        _userTimeLable.font = [UIFont systemFontOfSize:14];
        _userTimeLable.textColor = RGBCOLOR(167, 167, 167);
        [self addSubview:_userTimeLable];
    }
    return _userTimeLable;
}

-(UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
        [self addSubview:_avatar];
    }
    return _avatar;
}

-(UILabel *)reviewLable{
    if (!_reviewLable) {
        _reviewLable =  [[UILabel alloc] init];
        _reviewLable.font = [UIFont systemFontOfSize:15];
        _reviewLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_reviewLable];
    }
    return _reviewLable;
}


@end
