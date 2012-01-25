//
//  UserViewItem.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserViewItem.h"

@implementation UserViewItem

@synthesize caption = _caption;
@synthesize top = _top;

-(void) dealloc{
	TT_RELEASE_SAFELY(_caption);
	[super dealloc];
}

+ (id)itemWithText:(NSString*)text caption:(NSString*)caption imageURL:(NSString*)imageURL top:(BOOL)top{
	UserViewItem* item = [[[self alloc] init] autorelease];
	item.text = text;
	item.caption = caption;
	item.imageURL = imageURL;
    item.top = top;
	return item;
}

@end
