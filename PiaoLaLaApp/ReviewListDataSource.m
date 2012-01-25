//
//  ReviewListDataSource.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ReviewListDataSource.h"
#import "ReviewListCell.h"
#import "ReviewListModel.h"

@implementation ReviewListDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[ReviewListModel alloc] initWithResultsPerPage:@"10"];
	}
	return _model;
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [ReviewListCell class];
	}else {
		return [super tableView:tableView cellClassForObject:object];
	}
}


- (void)tableViewDidLoadModel:(UITableView*)tableView {
    NSMutableArray *items= [[NSMutableArray alloc] init];
    NSMutableArray *sections= [[NSMutableArray alloc] init];
    for (NSDictionary* feed in ((BaseRequestModel*)_model).items) {
        TTTableTextItem *_item = [TTTableTextItem itemWithText:@""];
        _item.userInfo = feed;
        [items addObject:[NSArray arrayWithObject:_item]];
        [sections addObject:@""];
    }
    
    if (!((BaseRequestModel*)_model).finished) {
		TTTableMoreButton *button = [TTTableMoreButton itemWithText:@"加载更多..."];
		[items addObject:[NSArray arrayWithObject:button]];
        [sections addObject:@""];
	}
    
    self.items = items;
    self.sections = sections;
    TT_RELEASE_SAFELY(items);
    TT_RELEASE_SAFELY(sections);
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
