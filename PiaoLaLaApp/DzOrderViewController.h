//
//  DzOrderViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  订座票详情
@class  AlipayConnect;

@interface DzOrderViewController : TTViewController<UITextFieldDelegate>{
    TTView *_back;
    UITextField *_phoneField;
    UILabel *_moveLabel;//影片
    UILabel *_cinemaLabel;//影城
    UILabel *_timeLabel;//时间
    UILabel *_siteLabel;//座位
    UILabel *_hallLabel;//影厅
    UILabel *_priceLabel;//总价
    UILabel *_singleLabel;//单号
     AlipayConnect *_pay;
}
@property (nonatomic,retain) IBOutlet TTView *back;
@property (nonatomic,retain) IBOutlet UITextField *phoneField;
@property (nonatomic,retain) IBOutlet UILabel *moveLabel;
@property (nonatomic,retain) IBOutlet UILabel *cinemaLabel;
@property (nonatomic,retain) IBOutlet UILabel *timeLabel;
@property (nonatomic,retain) IBOutlet UILabel *siteLabel;
@property (nonatomic,retain) IBOutlet UILabel *hallLabel;
@property (nonatomic,retain) IBOutlet UILabel *priceLabel;
@property (nonatomic,retain) IBOutlet UILabel *singleLabel;
@property (nonatomic,retain) AlipayConnect *pay;
-(IBAction)buyConfirm;
@end

