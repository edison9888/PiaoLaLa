//
//  AlipayConnect.h
//  MoveDemo
//
//  Created by bill on 11-6-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>


#import <UIKit/UIKit.h>
//@interface AlipayConnect : NSObject {

//
@protocol AFAlipayConnect <NSObject>
- (void)setWebError:(NSString *) str;
- (void)setResponseURL:(NSURL*)url;
@end

@interface AlipayConnect : NSObject {
	NSDictionary    *dicAlipay_;
	NSURLConnection *urlConnection;
	id<AFAlipayConnect> delegate;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) NSURLConnection *urlConnection;
@property (nonatomic, retain) NSDictionary	*dicAlipay_;

//-(void) alipayConnectUrl (NSDictionary*) dic;
-(void) servicesAlipay :(NSDictionary*) dic;
-(void)	destineAlipay :(NSDictionary*) dic;
-(void) unpaiy :(NSDictionary*) dic;

@end
