//
//  UserViewItem.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//


@interface UserViewItem :  TTTableImageItem {
	NSString* _caption;
    BOOL _top;
}
@property (nonatomic, copy) NSString* caption;
@property (nonatomic, assign) BOOL top;
+ (id)itemWithText:(NSString*)text caption:(NSString*)caption imageURL:(NSString*)imageURL top:(BOOL)top;

@end
