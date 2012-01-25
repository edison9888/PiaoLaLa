//
//  UserViewCell.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserViewCell.h"
#import "UserViewItem.h"
@implementation UserViewCell

-(void) dealloc{
	TT_RELEASE_SAFELY(_captionLabel);
    TT_RELEASE_SAFELY(_line);
	[super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
		self.textLabel.highlightedTextColor = [UIColor blackColor];
		self.detailTextLabel.highlightedTextColor = [UIColor blackColor];
		self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		self.detailTextLabel.numberOfLines = 0;
	}
	return self;
}

-(void) layoutSubviews{
	[super layoutSubviews];
    if (((UserViewItem*)_item).top) {
        self.line.frame = CGRectMake(10, 63, 280, 0.5);
    }
}


-(UILabel *) captionLabel{
	if (!_captionLabel) {
		_captionLabel = [[UILabel alloc] init];
		_captionLabel.highlightedTextColor = [UIColor blackColor];
		_captionLabel.lineBreakMode = UILineBreakModeWordWrap;
		_captionLabel.numberOfLines = 0;
		_captionLabel.textAlignment = UITextAlignmentRight;
		_captionLabel.font = TTSTYLEVAR(tableFont);
		[self.contentView addSubview:_captionLabel];
	}
	return _captionLabel;
}

- (void)setObject:(id)object {
	[super setObject:object];
	self.accessoryType = UITableViewCellAccessoryNone;
	self.selectionStyle = UITableViewCellSelectionStyleBlue;
	self.textLabel.text = ((UserViewItem*)_item).text;
    self.captionLabel.text = ((UserViewItem*)_item).caption;
	self.textLabel.font = [UIFont boldSystemFontOfSize:18];
	self.textLabel.textColor = TTSTYLEVAR(textColor);
	self.textLabel.textAlignment = UITextAlignmentLeft;
}

-(UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line1.png")];
        [self addSubview:_line];
    }
    return  _line;
}

@end
