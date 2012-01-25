//
//  SchedulingListCell.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SchedulingListCell.h"

@implementation SchedulingListCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_lineLabel);
    [super dealloc];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.lineLabel.frame = CGRectMake(15, 10, 300, 21);
}

-(void) setObject:(id)object{
	if (_item != object) {
		[_item release];
		_item = [object retain];
		self.accessoryType = UITableViewCellAccessoryNone;
		self.selectionStyle = UITableViewCellSelectionStyleBlue;

        self.lineLabel.text = [TTStyledText textFromXHTML:[NSString stringWithFormat:@"%@                   <span class=\"whiteText\">%@</span>               ￥%@   <span class=\"whiteText\"></span>",
                                                                   [((TTTableTextItem*)_item).userInfo objectForKey:@"STREAKPLAYTIME"],                                                                   [((TTTableTextItem*)_item).userInfo objectForKey:@"HALLNAME"],
                                                           [((TTTableTextItem*)_item).userInfo objectForKey:@"VALUE"]]];
        
        //NSLog(@"((TTTableTextItem*)_item).userInfo %@",((TTTableTextItem*)_item).userInfo);
        if ([[((TTTableTextItem*)_item).userInfo objectForKey:@"color"] isEqualToString:@"1"]) {
            UIView *_back = [[[UIView alloc] init] autorelease];
            _back.backgroundColor = RGBCOLOR(25, 38, 54);
            self.backgroundView = _back;
        }else{
            UIView *_back = [[[UIView alloc] init] autorelease];
            _back.backgroundColor = RGBCOLOR(1, 11, 21);
            self.backgroundView = _back;
        }
    }
}

-(TTStyledTextLabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[TTStyledTextLabel alloc] init];
        _lineLabel.font = [UIFont systemFontOfSize:15];
        _lineLabel.backgroundColor = [UIColor clearColor];
        _lineLabel.textColor = RGBCOLOR(221, 170, 28);
        [_lineLabel sizeToFit];
        [self addSubview:_lineLabel];
    }
    return  _lineLabel;
}

@end
