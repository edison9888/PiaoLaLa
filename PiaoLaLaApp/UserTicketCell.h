//
//  UserTicketCell.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  

@interface UserTicketCell : TTTableLinkedItemCell{
    UILabel *_nameLabel;
    UILabel *_statusLabel;
    UILabel *_lineLabel;
    UILabel *_timeLabel;
    UIImageView *_line;
}
@property (nonatomic,readonly) IBOutlet UIImageView *line;
@property (nonatomic,readonly) IBOutlet UILabel *nameLabel;
@property (nonatomic,readonly) IBOutlet UILabel *statusLabel;
@property (nonatomic,readonly) IBOutlet UILabel *lineLabel;
@property (nonatomic,readonly) IBOutlet UILabel *timeLabel;

@end
