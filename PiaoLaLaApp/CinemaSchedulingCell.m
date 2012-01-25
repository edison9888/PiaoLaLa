//
//  CinemaSchedulingCell.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CinemaSchedulingCell.h"

@implementation CinemaSchedulingCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_moveName);
    TT_RELEASE_SAFELY(_director);
    TT_RELEASE_SAFELY(_starring);
    TT_RELEASE_SAFELY(_time);
    TT_RELEASE_SAFELY(_score);
    TT_RELEASE_SAFELY(_line);
    [super dealloc];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.line.frame = CGRectMake(8, 99, 304, 0.5);
    self.moveName.frame = CGRectMake(10, 10, 230, 21);
    self.score.frame = CGRectMake(245, 10, 70, 21);
    self.time.frame = CGRectMake(10, 31, 300, 21);
    self.director.frame = CGRectMake(10, 52, 300, 21);
    self.starring.frame = CGRectMake(10, 73, 300, 21);
    
}

-(void) setObject:(id)object{
	if (_item != object) {
		[_item release];
		_item = [object retain];
        NSDictionary *moveData = _item.userInfo;
        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.moveName.text = [moveData objectForKey:@"MOVIENAME"];
        self.score.text = [moveData objectForKey:@"MOVIEPOINT"];;
        self.time.text = [NSString stringWithFormat:@"上映时间:%@",[moveData objectForKey:@"PLAYDATE"]];
        self.director.text =[NSString stringWithFormat:@"导演:%@",[moveData objectForKey:@"MOVIEDIRECTOR"]];
        self.starring.text = [NSString stringWithFormat:@"主演:%@",[moveData objectForKey:@"MOVIEVID"]];
    }
}

-(UILabel *)moveName{
    if (!_moveName) {
        _moveName = [[UILabel alloc] init];
        _moveName.textColor = RGBCOLOR(48, 209, 254);
        _moveName.backgroundColor = [UIColor clearColor];
        _moveName.font = [UIFont systemFontOfSize:20];
        [self addSubview:_moveName];
    }
    return _moveName;
}

-(UILabel *)director{
    if (!_director) {
        _director = [[UILabel alloc] init];
        _director.textColor = [UIColor whiteColor];
        _director.backgroundColor = [UIColor clearColor];
        _director.font = [UIFont systemFontOfSize:16];
        [self addSubview:_director];
    }
    return _director;
}

-(UILabel *)starring{
    if (!_starring) {
        _starring = [[UILabel alloc] init];
        _starring.textColor = [UIColor whiteColor];
        _starring.backgroundColor = [UIColor clearColor];
        _starring.font = [UIFont systemFontOfSize:16];
        [self addSubview:_starring];
    }
    return _starring;
}

-(UILabel *)score{
    if (!_score) {
        _score = [[UILabel alloc] init];
        _score.textColor = RGBCOLOR(221, 170, 28);
        _score.backgroundColor = [UIColor clearColor];
        _score.textAlignment = UITextAlignmentRight;
        _score.font = [UIFont systemFontOfSize:16];
        [self addSubview:_score];
    }
    return _score;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = [UIColor whiteColor];
        _time.backgroundColor = [UIColor clearColor];
        _time.font = [UIFont systemFontOfSize:16];
        [self addSubview:_time];
    }
    return _time;
}

-(UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line2.png")];
        [self addSubview:_line];
    }
    return  _line;
}


@end
