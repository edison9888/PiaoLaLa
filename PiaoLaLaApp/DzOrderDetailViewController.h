//
//  DzOrderDetailViewController.h
//  PiaoLaLaApp
//
//  Created by 高飞 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@class AlipayConnect;

@interface DzOrderDetailViewController :TTViewController<UITextFieldDelegate>{
    TTView *_back;
    UILabel *_areaLabel;
    UILabel *_siteLabel;
    UILabel *_hallLabel;
    UILabel *_timeLabel;
    UILabel *_cinemaLabel;
    UILabel *_typeLabel;
    UILabel *_numLabel;
    UILabel *_priceLabel;
    UITextField *_phoneField;
    UILabel *_singleLabel;//单号
    AlipayConnect *_pay;
}
@property (nonatomic,retain) IBOutlet TTView *back;
@property (nonatomic,retain) IBOutlet UILabel *areaLabel;
@property (nonatomic,retain) IBOutlet UILabel *siteLabel;
@property (nonatomic,retain) IBOutlet UILabel *hallLabel;
@property (nonatomic,retain) IBOutlet UILabel *timeLabel;
@property (nonatomic,retain) IBOutlet UILabel *cinemaLabel;
@property (nonatomic,retain) IBOutlet UILabel *typeLabel;
@property (nonatomic,retain) IBOutlet UILabel *numLabel;
@property (nonatomic,retain) IBOutlet UILabel *priceLabel;
@property (nonatomic,retain) IBOutlet UITextField *phoneField;
@property (nonatomic,retain) IBOutlet UILabel *singleLabel;
@property (nonatomic,retain) AlipayConnect *pay;
-(IBAction)buyConfirm;

@end
