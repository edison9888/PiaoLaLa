//
//  UserTicketCell.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserTicketCell.h"

@implementation UserTicketCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_nameLabel);
    TT_RELEASE_SAFELY(_lineLabel);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_line);
    [super dealloc];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.frame = CGRectMake(10, 10, 260, 21);
    self.statusLabel.frame = CGRectMake(260, 10, 60, 21);
    self.lineLabel.frame = CGRectMake(10, 31, 300, 21);
    self.timeLabel.frame = CGRectMake(10, 52, 300, 21);
    self.line.frame = CGRectMake(10, 79, 280, 0.5);
}

-(void)setObject:(id)object{
    if (_item != object) {
		[_item release];
		_item = [object retain];
        self.accessoryType = UITableViewCellAccessoryNone;
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.nameLabel.text = @"王府井影院";
        self.lineLabel.text = @"兑票数量:2张 剩余张数:1张";
        self.timeLabel.text = @"有效期至:2011-08-03";
        self.statusLabel.text = @"未兑完";
    }
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_nameLabel];
        
    }
    return _nameLabel;
}


-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.textColor = [UIColor whiteColor];
        _lineLabel.backgroundColor = [UIColor clearColor];
        _lineLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_lineLabel];
    }
    return _lineLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = RGBCOLOR(248, 128, 7);
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_statusLabel];
    }
    return _statusLabel;
}

-(UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line2.png")];
        [self addSubview:_line];
    }
    return  _line;
}


@end
