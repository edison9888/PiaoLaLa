//
//  CinemaSchedulingDataSource.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CinemaSchedulingDataSource.h"
#import "CinemaSchedulingCell.h"
@implementation CinemaSchedulingDataSource

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [CinemaSchedulingCell class];
	}else {
		return [super tableView:tableView cellClassForObject:object];
	}
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];
    //NSLog(@"SelsectCINEMA %@",[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"] );
	for (NSDictionary* feed in [[kAppDelegate.temporaryValues objectForKey:@"SelsectCINEMA"] 
                                objectForKey:@"FILMSTATES"]) {
		TTTableTextItem *item = [TTTableTextItem itemWithText:@""];
        if ([[[kAppDelegate.temporaryValues objectForKey:@"hotMove"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"MOVIECODE = %@",[feed objectForKey:@"MOVIECODE"]]] count]>0)
        {
            item.userInfo = [[[kAppDelegate.temporaryValues objectForKey:@"hotMove"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"MOVIECODE = %@",[feed objectForKey:@"MOVIECODE"]]] objectAtIndex:0];
            [items addObject:item];
        }
	}
    
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

- (NSString*)titleForEmpty {
	return @"暂无排期!";
}

@end
