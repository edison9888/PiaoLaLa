//
//  ToolUntil.m
//  MoveDemo
//
//  Created by Gao Fei on 11-5-6.
//  Copyright 2011 AlphaB. All rights reserved.
//

#import "ToolUntil.h"
#import "ASIHTTPRequest.h"
#import "NSString+Digest.h"

@implementation ToolUntil

+(ASIHTTPRequest*)requestCreate:(id)delegate postData:(NSMutableDictionary*)postData{
	ASIHTTPRequest * request  = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
	[request setRequestMethod:@"POST"];
	[request setDelegate:delegate];
	[request setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
										  [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
	return request;
}

@end
