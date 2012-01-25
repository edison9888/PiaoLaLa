//
//  ComingMoveListController.m
//  PiaoLaLaApp
//
//  Created by 高飞 on 11-12-4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ComingMoveListController.h"
#import "ComingMoveListDataSource.h"
@implementation ComingMoveListController

-(void)loadView{
    [super loadView];
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 141;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    self.dataSource = [[[ComingMoveListDataSource alloc] init] autorelease];
}

//点击进入详细页
-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    if ([object isMemberOfClass:[TTTableTextItem class]]) {
        //海报选中
        [kAppDelegate HUDShow:@"查询中" yOffset:@"0"];
        //请求详情
        NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
        
        [postData setObject:@"0103" forKey:@"OP"];
        
        
        //    NSLog(@"MOVIECODE1 %@",[[[interestingPhotosDictionary objectForKey:@"list"]
        //                             objectAtIndex:_posterCarousel.currentItemIndex] 
        //                            objectForKey:@"MOVIECODE"]);
        
        [kAppDelegate.temporaryValues setObject:[((TTTableTextItem*)object).userInfo 
                                                 objectForKey:@"MOVIECODE"]
                                         forKey:@"MOVIECODE"];
        
        [postData setObject:[((TTTableTextItem*)object).userInfo 
                             objectForKey:@"MOVIECODE"]
                     forKey:@"MOVIECODE"];//影片ID
        
        ASIHTTPRequest *detailRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
        
        [detailRequest setRequestMethod:@"POST"];
        [detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
                                     [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData release];
        [detailRequest setDelegate:self];
        detailRequest.didFinishSelector = @selector(moveFinishUpdata:);
        detailRequest.didFailSelector = @selector(failUpdata:);
        [detailRequest startAsynchronous];
    }
}

-(void)moveFinishUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	NSDictionary *detailDictionary = [[JSONDecoder decoder] 
                                      objectWithData:[request responseData]];
    
	[kAppDelegate.temporaryValues setValue:[detailDictionary objectForKey:@"FILMINFO"]
                                    forKey:@"moveDetail"];
    
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/MoveDetailViewController"];
    urlAction.animated = YES;
    [[TTNavigator navigator] openURLAction:urlAction];
}

@end
