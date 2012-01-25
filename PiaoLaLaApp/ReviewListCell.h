//
//  ReviewListCell.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@interface ReviewListCell : TTTableLinkedItemCell{
    UILabel *_userNameLable;
    UILabel *_userTimeLable;
    UILabel *_reviewLable;
    UIImageView *_avatar;
}
@property (nonatomic,readonly) IBOutlet UILabel *userNameLable;
@property (nonatomic,readonly) IBOutlet UILabel *userTimeLable;
@property (nonatomic,readonly) IBOutlet UILabel *reviewLable;
@property (nonatomic,readonly) IBOutlet UIImageView *avatar;

@end
