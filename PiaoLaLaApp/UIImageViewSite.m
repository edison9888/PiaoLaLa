//
//  UIImageViewSite.m
//  MoveDemo
//
//  Created by 高飞 on 11-8-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImageViewSite.h"


@implementation UIImageViewSite
@synthesize userInfo = _userInfo;
@synthesize select = _select;

-(void) dealloc{
	TT_RELEASE_SAFELY(_userInfo);
	[super dealloc];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"selectSite" object:self];
}

@end
