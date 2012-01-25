//
//  UserOrderCell.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserOrderCell.h"

@implementation UserOrderCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_firstLabel);
    TT_RELEASE_SAFELY(_secondLabel);
    TT_RELEASE_SAFELY(_typeLabel);
    TT_RELEASE_SAFELY(_line);
    [super dealloc];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.line.frame = CGRectMake(8, 61, 304, 0.5);
    self.firstLabel.frame = CGRectMake(10, 10, 260, 21);
    self.typeLabel.frame = CGRectMake(265, 13, 55, 21); 
    self.secondLabel.frame = CGRectMake(10, 31, 300, 21);
}


-(void) setObject:(id)object{
	if (_item != object) {
		[_item release];
		_item = [object retain];
        NSDictionary *orderData = _item.userInfo;
        //NSLog(@"orderData %@",orderData);
		self.accessoryType = UITableViewCellAccessoryNone;
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.firstLabel.text =[orderData objectForKey:@"FIRMNAME"];
        self.secondLabel.text = [NSString stringWithFormat:@"%@ 票数:%@张 %@",
                                         [orderData objectForKey:@"ORDERDATE"],
                                         [orderData objectForKey:@"ORDERNUM"],
                                         [orderData objectForKey:@"TICKETNAME"]];
        switch ([[orderData objectForKey:@"ORDERSTATUS"] intValue]) {
            case 0:
                self.typeLabel.text = @"已付款";
                break;
            case 2:
                self.typeLabel.text = @"支付中";
                break;
            case 3:
                self.typeLabel.text = @"支付失败";
                break;
            case 4:
                self.typeLabel.text = @"锁定";
                break;
            case 5:
                self.typeLabel.text = @"已取消";
                break;
            case 6:
                self.typeLabel.text = @"退订";
                break;
            case 7:
                self.typeLabel.text = @"支付成功,订座失败";
                break; 
            case 9:
                self.typeLabel.text = @"作废";
                break;
            case 10:
                self.typeLabel.text = @"支付成功回调失败";
                break;    
            default:
                break;
        }
    }
}

-(UILabel *)firstLabel{
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.textColor = [UIColor whiteColor];
        _firstLabel.backgroundColor = [UIColor clearColor];
        _firstLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_firstLabel];
    }
    return _firstLabel;
}

-(UILabel *)secondLabel{
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.textColor = [UIColor whiteColor];
        _secondLabel.backgroundColor = [UIColor clearColor];
        _secondLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_secondLabel];
    }
    return _secondLabel;
}


-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textColor = RGBCOLOR(248, 135, 8);
        _typeLabel.backgroundColor = [UIColor clearColor];
        _typeLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_typeLabel];
    }
    return _typeLabel;
}

-(UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line2.png")];
        [self addSubview:_line];
    }
    return  _line;
}



@end
