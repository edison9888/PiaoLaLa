//
//  CinemaDetailViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  影院详情


@interface CinemaDetailViewController : TTViewController{
    UILabel *_nameLabel;//名称
    TTStyledTextLabel *_scoreLabel;//评分
    UIImageView *_pic;//图片
    UILabel *_addressLable;//地址
    UILabel *_phoneLable;//电话
    UILabel *_wayLable;//路线
}

@end
