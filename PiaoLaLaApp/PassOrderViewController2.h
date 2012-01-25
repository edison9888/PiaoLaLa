//
//  PassOrderViewController2.h
//  PiaoLaLaApp
//
//  Created by 高飞 on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//


@interface PassOrderViewController2 : TTViewController{
    TTView *_back;
    UIImageView * _line1;
    UIImageView * _line2;
    UIImageView * _line3;
    UIButton *_type1;
    UIButton *_type2;
    UIButton *_type3;
    UIButton *_num1;
    UIButton *_num2;
    UIButton *_num3;
    UIButton *_num4;
    NSInteger _type;
    NSInteger _num;
    UILabel *_price;
    
    UILabel *_name1;
    UILabel *_name2;
    UILabel *_name3;
}
@property (nonatomic,retain) IBOutlet TTView *back;
@property (nonatomic,retain) IBOutlet UIImageView * line1;
@property (nonatomic,retain) IBOutlet UIImageView * line2;
@property (nonatomic,retain) IBOutlet UIImageView * line3;
@property (nonatomic,retain) IBOutlet UIButton *type1;
@property (nonatomic,retain) IBOutlet UIButton *type2;
@property (nonatomic,retain) IBOutlet UIButton *type3;
@property (nonatomic,retain) IBOutlet UIButton *num1;
@property (nonatomic,retain) IBOutlet UIButton *num2;
@property (nonatomic,retain) IBOutlet UIButton *num3;
@property (nonatomic,retain) IBOutlet UIButton *num4;
@property (nonatomic,retain) IBOutlet UILabel *price;
@property (nonatomic,retain) IBOutlet UILabel *name1;
@property (nonatomic,retain) IBOutlet UILabel *name2;
@property (nonatomic,retain) IBOutlet UILabel *name3;
-(IBAction)typeAction:(id)sender;
-(IBAction)numAction:(id)sender;

@end
