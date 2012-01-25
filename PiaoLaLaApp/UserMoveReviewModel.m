//
//  UserMoveReviewModel.m
//  PiaoLaLaApp
//
//  Created by 高飞 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserMoveReviewModel.h"
#import <extThree20JSON/extThree20JSON.h>

@implementation UserMoveReviewModel

-(void)generateRequest:(TTURLRequestCachePolicy)cachePolicy{
    NSMutableDictionary *postData = [[[NSMutableDictionary alloc] init] autorelease];
	[postData setObject:@"0508" forKey:@"OP"];
    
    [postData setObject:@"0" forKey:@"TYPE"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [postData setObject:[[defaults objectForKey:@"USERINFO"] 
                         objectForKey:@"USERID"]
                 forKey:@"USERID"];
    
	[postData setObject:[NSMutableDictionary 
                         dictionaryWithObjects:[NSArray arrayWithObjects:
                                                [NSString stringWithFormat:@"%d",_page],self.resultsPerPage,nil]
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

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	NSDictionary* feed = response.rootObject;
	
    //NSLog(@"RESULTDESC %@",[response.rootObject objectForKey:@"RESULTDESC"]);
   // NSLog(@"response.rootObject %@",response.rootObject);
	NSArray* entries = [feed objectForKey:@"REPLY"];	
	[self.items addObjectsFromArray:entries];
	_finished = entries.count < [_resultsPerPage intValue];
	[super requestDidFinishLoad:request];
}

@end
