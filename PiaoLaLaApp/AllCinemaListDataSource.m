//
//  AllCinemaListDataSource.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AllCinemaListDataSource.h"
#import "CinemaListCell.h"
@implementation AllCinemaListDataSource

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [CinemaListCell class];
	}else {
		return [super tableView:tableView cellClassForObject:object];
	}
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];
	for (NSDictionary* feed in [kAppDelegate.temporaryValues objectForKey:@"cityMoveData"]) {
		TTTableTextItem *item = [TTTableTextItem itemWithText:@""];
		item.userInfo = feed;
		[items addObject:item];
	}

	self.items = items;
	TT_RELEASE_SAFELY(items);
}

@end
