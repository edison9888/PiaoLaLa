//
//  MyCinemaListDataSource.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyCinemaListDataSource.h"
#import "CinemaListCell.h"

@implementation MyCinemaListDataSource

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [CinemaListCell class];
	}else {
		return [super tableView:tableView cellClassForObject:object];
	}
}


- (NSString*)titleForEmpty {
	return @"暂无影院!";
}


@end
