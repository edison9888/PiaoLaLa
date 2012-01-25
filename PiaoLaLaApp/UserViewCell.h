//
//  UserViewCell.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//


@interface UserViewCell : TTTableImageItemCell{
    UIImageView *_line;
    UILabel *_captionLabel;
}
@property (nonatomic,readonly) IBOutlet UIImageView *line;
@property (nonatomic,readonly) IBOutlet UILabel *captionLabel;
@end
