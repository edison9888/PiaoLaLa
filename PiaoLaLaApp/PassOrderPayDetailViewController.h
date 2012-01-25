//
//  PassOrderPayDetailViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  电子通票已付订单详情
@class AlipayConnect;

@interface PassOrderPayDetailViewController : TTViewController{
    TTView *_back;
    UILabel *_timeLabel;
    UILabel *_cinemaLabel;
    UILabel *_typeLabel;
    UILabel *_numLabel;
    UILabel *_priceLabel;
    UILabel *_phoneLabel;
    UILabel *_singleLabel;//单号
}
@property (nonatomic,retain) IBOutlet TTView *back;
@property (nonatomic,retain) IBOutlet UILabel *timeLabel;
@property (nonatomic,retain) IBOutlet UILabel *cinemaLabel;
@property (nonatomic,retain) IBOutlet UILabel *typeLabel;
@property (nonatomic,retain) IBOutlet UILabel *numLabel;
@property (nonatomic,retain) IBOutlet UILabel *priceLabel;
@property (nonatomic,retain) IBOutlet UILabel *phoneLabel;
@property (nonatomic,retain) IBOutlet UILabel *singleLabel;


@end
