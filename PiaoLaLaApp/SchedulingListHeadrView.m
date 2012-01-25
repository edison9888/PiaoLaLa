//
//  SchedulingListHeadr.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SchedulingListHeadrView.h"

@implementation SchedulingListHeadrView

-(id)init{
    if (self = [super init]) {
        self.redSC.frame =  CGRectMake(105, 5, 108, 30);
    }
    return self;
}

-(SVSegmentedControl *)redSC{
    if (!_redSC) {
        _redSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"今天", @"明天", nil]];
        _redSC.thumb.shadowColor = [UIColor clearColor];
        _redSC.selectedIndex = 0;
        [self addSubview:_redSC];
        [_redSC release];
    }
    return  _redSC;
}



@end
