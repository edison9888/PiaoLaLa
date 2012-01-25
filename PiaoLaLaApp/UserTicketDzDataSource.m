//
//  UserTicketDzDataSource.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserTicketDzDataSource.h"
#import "UserTicketCell.h"

@implementation UserTicketDzDataSource

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [UserTicketCell class];
	}else {
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
