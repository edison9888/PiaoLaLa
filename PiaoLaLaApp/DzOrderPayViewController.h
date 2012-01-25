//
//  DzOrderPayViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  订座票已付详细
@class AlipayConnect;
@interface DzOrderPayViewController : TTViewController{
    TTView *_back;
    UILabel *_phoneLabel;
    UILabel *_moveLabel;//影片
    UILabel *_cinemaLabel;//影城
    UILabel *_timeLabel;//时间
    UILabel *_siteLabel;//座位
    UILabel *_hallLabel;//影厅
    UILabel *_priceLabel;//总价
    UILabel *_singleLabel;//单号
   
}
@property (nonatomic,retain) IBOutlet TTView *back;
@property (nonatomic,retain) IBOutlet UILabel *phoneLabel;
@property (nonatomic,retain) IBOutlet UILabel *moveLabel;
@property (nonatomic,retain) IBOutlet UILabel *cinemaLabel;
@property (nonatomic,retain) IBOutlet UILabel *timeLabel;
@property (nonatomic,retain) IBOutlet UILabel *siteLabel;
@property (nonatomic,retain) IBOutlet UILabel *hallLabel;
@property (nonatomic,retain) IBOutlet UILabel *priceLabel;
@property (nonatomic,retain) IBOutlet UILabel *singleLabel;

@end
