//
//  UIImageViewSite.h
//  MoveDemo
//
//  Created by 高飞 on 11-8-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


@interface UIImageViewSite : UIImageView {
	NSDictionary *_userInfo;
	BOOL _select;
}
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, assign, getter=is_select) BOOL select;

@end
