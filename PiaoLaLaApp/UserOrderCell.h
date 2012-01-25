//
//  UserOrderCell.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@interface UserOrderCell : TTTableLinkedItemCell{
     UIImageView *_line;
     UILabel *_firstLabel;
     UILabel *_secondLabel;
     UILabel *_typeLabel;
}
@property (nonatomic,readonly) IBOutlet UIImageView *line;
@property (nonatomic,readonly) IBOutlet UILabel *firstLabel;
@property (nonatomic,readonly) IBOutlet UILabel *secondLabel;
@property (nonatomic,readonly) IBOutlet UILabel *typeLabel;
@end
