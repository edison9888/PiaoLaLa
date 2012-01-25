//
//  ComingMoveListModel.m
//  PiaoLaLaApp
//
//  Created by 高飞 on 11-12-4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ComingMoveListModel.h"
#import <extThree20JSON/extThree20JSON.h>

@implementation ComingMoveListModel

-(void)generateRequest:(TTURLRequestCachePolicy)cachePolicy{
    NSMutableDictionary *postData = [[[NSMutableDictionary alloc] init] autorelease];
	[postData setObject:@"0101" forKey:@"OP"];
    
	[postData setObject:[NSMutableDictionary 
                         dictionaryWithObjects:[NSArray arrayWithObjects:
                                                [NSString stringWithFormat:@"%d",(_page-1)],self.resultsPerPage,nil]
                         forKeys:[NSArray arrayWithObjects:@"PAGE_NO",@"PAGE_SIZE",nil]]
				 forKey:@"PAGER"];
    
    TTURLRequest* request = [TTURLRequest
                             requestWithURL: kTestUrl
                             delegate: self];
    
    request.httpMethod = @"POST";
    request.httpBody = [[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
                         [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding];
    
	request.cachePolicy = TTURLRequestCachePolicyNone;
	request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
	
	TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	[request send];
}

- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error{
	[kAppDelegate HUDHide];
	[super request:request didFailLoadWithError:error];
}

@end
