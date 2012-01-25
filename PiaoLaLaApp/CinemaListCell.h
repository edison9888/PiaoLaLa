//
//  CinemaListCell.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@interface CinemaListCell : TTTableLinkedItemCell{
    UILabel *_cinemaName;//影院名称
    UILabel *_cinemaAddress;//地址
    UIImageView *_line;
    UIImageView *_status;
}
@property (nonatomic,readonly) IBOutlet UILabel *cinemaName;
@property (nonatomic,readonly) IBOutlet UILabel *cinemaAddress;
@property (nonatomic,readonly) IBOutlet UIImageView *line;
@property (nonatomic,readonly) IBOutlet UIImageView *status;
@end
