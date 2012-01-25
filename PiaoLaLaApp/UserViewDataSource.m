//
//  UserViewDataSource.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserViewDataSource.h"
#import "UserViewCell.h"
#import "UserViewItem.h"
#import "CustomCellBackgroundView.h"
@implementation UserViewDataSource


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
	CustomCellBackgroundView *custview = [[CustomCellBackgroundView alloc] init];
	custview.fillColor = RGBCOLOR(173, 189, 205);
	custview.borderColor = [UIColor clearColor];
	if(([tableView numberOfRowsInSection:indexPath.section]-1) == 0){
        custview.position = CustomCellBackgroundViewPositionSingle;
    }
    else if(indexPath.row == 0){
        custview.position = CustomCellBackgroundViewPositionTop;
    }
    else if (indexPath.row == ([tableView numberOfRowsInSection:indexPath.section]-1)){
        custview.position  = CustomCellBackgroundViewPositionBottom;
    }
    else{
        custview.position = CustomCellBackgroundViewPositionMiddle;
    }
	cell.selectedBackgroundView =custview;
	
	[custview release];
	return cell;
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[UserViewItem class]]) {
		return [UserViewCell class];
	}else {
		return [super tableView:tableView cellClassForObject:object];
	}
}


@end
