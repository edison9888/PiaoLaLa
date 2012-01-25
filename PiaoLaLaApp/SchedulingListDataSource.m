//
//  SchedulingListDataSource.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SchedulingListDataSource.h"
#import "SchedulingListCell.h"

@implementation SchedulingListDataSource

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [SchedulingListCell class];
	}else {
		return [super tableView:tableView cellClassForObject:object];
	}
}


- (NSString*)titleForEmpty {
	return @"暂无排期!";
}

@end
