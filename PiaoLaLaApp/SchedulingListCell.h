//
//  SchedulingListCell.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@interface SchedulingListCell : TTTableLinkedItemCell{
    TTStyledTextLabel *_lineLabel;
}
@property (nonatomic,readonly) IBOutlet TTStyledTextLabel *lineLabel;    
@end
