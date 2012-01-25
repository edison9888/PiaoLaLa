//
//  MoveDetailViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  影片详情

@interface MoveDetailViewController : TTViewController{
    UILabel *_moveName;//名称
	UILabel *_director;//导演
	UILabel *_starring;//主演
	UILabel *_time;//时间
    UILabel *_length;//片长
    TTStyledTextLabel *_score;//评分
    UIImageView *_poster;//海报
	UILabel *_screen;//票房or期待
    TTView* _Introduction;//简介
    TTView *_review;//评论
    UIImageView *_openArrow;
    UITextView *_introductionText;
    BOOL _isOpen;
}


@end
