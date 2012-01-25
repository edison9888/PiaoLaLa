//
//  UserReviewCell.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserReviewCell.h"
#import "Three20UI/TTTableSubtitleItem.h"
#import "Three20UI/UIViewAdditions.h"
#import "Three20Style/UIFontAdditions.h"

static const CGFloat kMaxLabelHeight = 2000;
static const UILineBreakMode kLineBreakMode = UILineBreakModeWordWrap;

static const CGFloat kLeft = 15;
static const CGFloat kWidth = 295;

@implementation UserReviewCell

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		self.textLabel.font = [UIFont boldSystemFontOfSize:20];
		self.textLabel.textColor = RGBCOLOR(88, 169, 242);
		self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.textLabel.textAlignment = UITextAlignmentLeft;
		self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.textLabel.adjustsFontSizeToFitWidth = YES;
		
		self.detailTextLabel.font = [UIFont systemFontOfSize:15];
		self.detailTextLabel.textColor = [UIColor whiteColor];
		self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.detailTextLabel.textAlignment = UITextAlignmentLeft;
		self.detailTextLabel.contentMode = UIViewContentModeTop;
		self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		self.detailTextLabel.numberOfLines = 0;
	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	TTTableTextItem* item = object;
	
	UIFont* font = [UIFont systemFontOfSize:15];
	CGSize size = [[item.userInfo objectForKey:@"Content"] sizeWithFont:font
                                                      constrainedToSize:CGSizeMake(kWidth, CGFLOAT_MAX)
                                                          lineBreakMode:kLineBreakMode];
	size.height +=5;
	if (size.height > kMaxLabelHeight) {
		size.height = kMaxLabelHeight;
	}else if (size.height < 40) {
		return size.height = 38 + kTableCellVPadding*2+5;
	}
	//NSLog(@"size1 %f",(size.height + kTableCellVPadding*2+10));
	return size.height + kTableCellVPadding*2+20;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat height = self.contentView.height;
	CGFloat width = self.contentView.width - (height + kTableCellSmallMargin);
	CGFloat left = kLeft;
	
	self.timeLabel.frame = CGRectMake(240, 10, 80, 15);
    
    
	if (self.detailTextLabel.text.length) {
		CGFloat textHeight = self.textLabel.font.ttLineHeight;
		
		self.textLabel.frame = CGRectMake(left, 10, 240, textHeight);
		
		CGSize captionSize =
		[self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font
							  constrainedToSize:CGSizeMake(kWidth, CGFLOAT_MAX)
								  lineBreakMode:kLineBreakMode];
		
		self.detailTextLabel.frame = CGRectMake(left, self.textLabel.bottom, captionSize.width, captionSize.height);
        
        //NSLog(@"size2 %f",(captionSize.height + kTableCellVPadding*2+10));
		self.line.frame = CGRectMake(8, (captionSize.height + kTableCellVPadding*2+25), 304, 0.5);

	} else {
		self.textLabel.frame = CGRectMake(5, 0, width, height);
		self.detailTextLabel.frame = CGRectZero;
	}
    
    }


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[super setObject:object];
		
		TTTableTextItem* item = object;
		//if (item.text.length) {
		self.textLabel.text = [item.userInfo objectForKey:@"TITILE"];
        
		//}
		//if (item.subtitle.length) {
		self.detailTextLabel.text = [item.userInfo objectForKey:@"REPLYCONTENT"];
		//}

		self.timeLabel.text = [item.userInfo objectForKey:@"PUBLISHTIME"];
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.accessoryType = UITableViewCellAccessoryNone;
	}
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_line);
	TT_RELEASE_SAFELY(_timeLabel);
	[super dealloc];
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


-(UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line2.png")];
        [self addSubview:_line];
    }
    return  _line;
}

@end
