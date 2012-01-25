//
//  UserHeaderView.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@interface UserHeaderView : UIView{
    UIImageView *_imageFrame;
    UIImageView *_avatar;
    UIButton *_modfiyButton;
    UILabel *_name;
}
@property (nonatomic,readonly) IBOutlet UIImageView *imageFrame;
@property (nonatomic,readonly) IBOutlet UIImageView *avatar;
@property (nonatomic,readonly) IBOutlet UIButton *modfiyButton;
@property (nonatomic,readonly) IBOutlet UILabel *name;
@end
