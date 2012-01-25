//
//  UserMoveReviewDataSource.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserMoveReviewDataSource.h"
#import "UserReviewCell.h"
#import "UserMoveReviewModel.h"

@implementation UserMoveReviewDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[UserMoveReviewModel alloc] initWithResultsPerPage:@"10"];
	}
	return _model;
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [UserReviewCell class];
	}else {
		return [super tableView:tableView cellClassForObject:object];
	}
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
    NSMutableArray* items = [[NSMutableArray alloc] init];
	for (NSDictionary* feed in ((BaseRequestModel*)_model).items) {
		TTTableTextItem *item = [TTTableTextItem itemWithText:@""];
		item.userInfo = feed;
		[items addObject:item];
	}
	if (!((BaseRequestModel*)_model).finished) {
		TTTableMoreButton *button = [TTTableMoreButton itemWithText:@"加载更多..."];
		[items addObject:button];
	}
	self.items = items;
	TT_RELEASE_SAFELY(items);

}

//滑动到最后一行加载更多
- (void)tableView:(UITableView*)tableView cell:(UITableViewCell*)cell willAppearAtIndexPath:(NSIndexPath*)indexPath {
	[super tableView:tableView cell:cell willAppearAtIndexPath:indexPath];
	if (indexPath.row == self.items.count-1 && [cell isKindOfClass:[TTTableMoreButtonCell class]]) {
		TTTableMoreButton* moreLink = [(TTTableMoreButtonCell *)cell object];
		moreLink.isLoading = YES;
		[(TTTableMoreButtonCell *)cell setAnimating:YES];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		[self.model load:TTURLRequestCachePolicyDefault more:YES];		
	}
}

- (NSString*)titleForLoading:(BOOL)reloading {
	return @"加载中.....";
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
	return @"没有记录!";
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
	return @"对不起加载中出现了错误";
}

@end
