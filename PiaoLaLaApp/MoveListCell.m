//
//  MoveListCell.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MoveListCell.h"
#import "UIImageView+WebCache.h"
#import "NSStringAdditions.h"
@implementation MoveListCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_moveName);
    TT_RELEASE_SAFELY(_director);
    TT_RELEASE_SAFELY(_starring);
    TT_RELEASE_SAFELY(_time);
    TT_RELEASE_SAFELY(_poster);
    TT_RELEASE_SAFELY(_line);
    TT_RELEASE_SAFELY(_screen);
    [super dealloc];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.line.frame = CGRectMake(8, 140, 304, 0.5);
    self.poster.frame = CGRectMake(10, 10, 83, 122);
    self.moveName.frame = CGRectMake(103, 10, 210, 21);
    self.time.frame = CGRectMake(103, 51, 210, 21);
    self.director.frame = CGRectMake(103, 72, 210, 21);
    self.starring.frame = CGRectMake(103, 93, 210, 21);
    self.screen.frame =  CGRectMake(103, 113, 210, 21);
}

-(void) setObject:(id)object{
	if (_item != object) {
		[_item release];
		_item = [object retain];
        NSDictionary *moveData = _item.userInfo;
		self.accessoryType = UITableViewCellAccessoryNone;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        //NSLog(@"userinfo %@",_item.userInfo);
        [self.poster setImageWithURL:[NSURL URLWithString:[moveData objectForKey:@"MOVIEPICURL"]] 
                    placeholderImage:TTIMAGE(@"")];
        self.moveName.text = [moveData objectForKey:@"MOVIENAME"];
        self.time.text = [NSString stringWithFormat:@"上映时间:%@",[moveData objectForKey:@"PLAYDATE"]];
        self.director.text =[NSString stringWithFormat:@"导演:%@",[moveData objectForKey:@"MOVIEDIRECTOR"]];
        self.starring.text = [NSString stringWithFormat:@"主演:%@",[moveData objectForKey:@"MOVIEVID"]];
        if (![[moveData objectForKey:@"NUM"] isMemberOfClass:[NSNull class]]) {
             self.screen.text =  [NSString stringWithFormat:@"期待人数:%@",[moveData objectForKey:@"NUM"]];
        }else{
            self.screen.text =  [NSString stringWithFormat:@"票房:%@",[moveData objectForKey:@"BOXOFFICE"]];
        }
    }
}




-(UILabel *)moveName{
    if (!_moveName) {
        _moveName = [[UILabel alloc] init];
        _moveName.textColor = RGBCOLOR(77, 170, 255);
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

-(UILabel *)screen{
    if (!_screen) {
        _screen = [[UILabel alloc] init];
        _screen.textColor = [UIColor whiteColor];
        _screen.backgroundColor = [UIColor clearColor];
        _screen.font = [UIFont systemFontOfSize:16];
        [self addSubview:_screen];
    }
    return _screen;
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

-(UIImageView *)poster{
    if (!_poster) {
        _poster = [[UIImageView alloc] init];
        [self addSubview:_poster];
    }
    return  _poster;
}

-(UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line2.png")];
        [self addSubview:_line];
    }
    return  _line;
}

@end
