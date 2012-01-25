//
//  UserViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  票啦啦(用户)
@class UserHeaderView;
@interface UserHomeViewController : TTTableViewController{
    BOOL _first;
    NSString *_userId;
    UserHeaderView *_header;
}

@end
