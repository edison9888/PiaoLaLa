//
//  CinemaListCell.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CinemaListCell.h"

@implementation CinemaListCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_cinemaName);
    TT_RELEASE_SAFELY(_cinemaAddress);
    TT_RELEASE_SAFELY(_line);
    TT_RELEASE_SAFELY(_status);
    [super dealloc];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.line.frame = CGRectMake(8, 61, 304, 0.5);
    self.cinemaName.frame = CGRectMake(10, 10, 300, 21);
    self.cinemaAddress.frame = CGRectMake(10, 31, 280, 21);
    self.status.frame = CGRectMake(280, 10, 30, 21);
    
}

-(void) setObject:(id)object{
	if (_item != object) {
		[_item release];
		_item = [object retain];
        NSDictionary *cinemaData = _item.userInfo;
		self.accessoryType = UITableViewCellAccessoryNone;
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.cinemaName.text = [cinemaData objectForKey:@"CINEMANAME"];
        self.cinemaAddress.text = [cinemaData objectForKey:@"CINEMAADDREDSS"];
        if ([[cinemaData objectForKey:@"CINEMASEATSTATUS"] intValue]==0) {
            self.status.hidden = NO;
        }else{
            self.status.hidden = YES;
        }
       // NSLog(@"CINEMASEATSTATUS %@",[cinemaData objectForKey:@"CINEMASEATSTATUS"]);
    }
}


-(UIImageView *)status{
    if (!_status) {
        _status = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://dzStatus.png")];
        [self addSubview:_status];
    }
    return _status;
}

-(UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line2.png")];
        [self addSubview:_line];
    }
    return  _line;
}



-(UILabel *)cinemaName{
    if (!_cinemaName) {
        _cinemaName = [[UILabel alloc] init];
        _cinemaName.textColor = [UIColor whiteColor];
        _cinemaName.backgroundColor = [UIColor clearColor];
        _cinemaName.font = [UIFont systemFontOfSize:20];
        [self addSubview:_cinemaName];
    }
    return _cinemaName;
}

-(UILabel *)cinemaAddress{
    if (!_cinemaAddress) {
        _cinemaAddress = [[UILabel alloc] init];
        _cinemaAddress.textColor = [UIColor whiteColor];
        _cinemaAddress.backgroundColor = [UIColor clearColor];
        _cinemaAddress.font = [UIFont systemFontOfSize:13];
        [self addSubview:_cinemaAddress];
    }
    return _cinemaAddress;
}

@end
