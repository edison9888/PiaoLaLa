//
//  UIImageViewTouch.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  响应双击事件

@interface UIImageViewTouch : UIImageView{
    id _userInfo;
    Boolean isSingleTap;
	Boolean isDoubleTap;
}

@property (nonatomic, retain) id userInfo;

@end
