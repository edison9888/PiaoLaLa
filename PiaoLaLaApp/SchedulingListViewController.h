//
//  SchedulingListViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#import "SVSegmentedControl.h"
#import "SchedulingListHeadrView.h"
@interface SchedulingListViewController : TTTableViewController <SVSegmentedControlDelegate>{
    SchedulingListHeadrView *_header;
    NSString *_cinemaId;
    id _rootController;
}
@property (nonatomic, copy) NSString *cinemaId;
@property (nonatomic, assign) id rootController;
@end
