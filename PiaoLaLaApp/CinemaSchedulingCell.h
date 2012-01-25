//
//  CinemaSchedulingCell.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//


@interface CinemaSchedulingCell : TTTableLinkedItemCell{
    UILabel *_moveName;//名称
	UILabel *_director;//导演
	UILabel *_starring;//主演
	UILabel *_time;//时间
    UILabel *_score;
    UIImageView *_line;
}
@property (nonatomic,readonly) IBOutlet UILabel *moveName;
@property (nonatomic,readonly) IBOutlet UILabel *director;
@property (nonatomic,readonly) IBOutlet UILabel *starring;
@property (nonatomic,readonly) IBOutlet UILabel *time;
@property (nonatomic,readonly) IBOutlet UILabel *score;
@property (nonatomic,readonly) IBOutlet UIImageView *line;
@end
