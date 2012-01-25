//
//  ComingMoveListDataSource.m
//  PiaoLaLaApp
//
//  Created by 高飞 on 11-12-4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ComingMoveListDataSource.h"
#import "ComingMoveListModel.h"
@implementation ComingMoveListDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[ComingMoveListModel alloc] initWithResultsPerPage:@"10"];
	}
	return _model;
}

@end
