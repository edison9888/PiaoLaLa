//
//  UserReviewCell.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//


@interface UserReviewCell : TTTableLinkedItemCell{
    UILabel *_timeLabel;
    UIImageView *_line;
}
@property (nonatomic,readonly) IBOutlet UIImageView *line;
@property (nonatomic,readonly) IBOutlet UILabel *timeLabel;
@end
