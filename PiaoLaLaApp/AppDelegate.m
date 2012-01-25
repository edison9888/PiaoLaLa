//
//  AppDelegate.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "NSString+Digest.h"
#import "JSONKit.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

@interface MyStyleSheet : TTDefaultStyleSheet
@end

@implementation MyStyleSheet


- (TTStyle*)whiteText {
	return [TTTextStyle styleWithColor:[UIColor whiteColor] next:nil];
}

- (TTStyle*)yellowText {
	return [TTTextStyle styleWithColor:RGBCOLOR(221, 170, 28) next:nil];
}

- (TTStyle*)largeText {
	return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:18] next:nil];
}

- (TTStyle*)smallText {
	return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:12] next:nil];
}


@end

@implementation AppDelegate
@synthesize temporaryValues = _temporaryValues;

-(void) dealloc{
    [TTStyleSheet setGlobalStyleSheet:nil];
    TT_RELEASE_SAFELY(_temporaryValues);
	[super dealloc];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [TTStyleSheet setGlobalStyleSheet:[[[MyStyleSheet alloc] init] autorelease]];
    NSMutableDictionary *tDic = [[NSMutableDictionary alloc] init];
	self.temporaryValues = tDic;
	[tDic release];
    
    TTURLMap* map = self.navigator.URLMap;
  	[map from:@"tt://nib/(loadFromNib:)" toViewController:self];
	[map from:@"tt://nib/(loadFromNib:)/(withClass:)" toViewController:self];
	[map from:@"tt://viewController/(loadFromVC:)" toViewController:self];
	[map from:@"tt://modal/viewController/(loadFromVC:)" toModalViewController:self];
	[map from:@"tt://modal/(loadFromNib:)" toModalViewController:self];
    [map from:@"*" toViewController:[TTWebController class]];
    
    if (![_navigator restoreViewControllers]) {
		if (![AppDelegate IsEnableWIFI]&&![AppDelegate IsEnable3G]) {
//			[self.navigator openURLAction:
//			 [TTURLAction actionWithURLPath:@"tt://viewController/NoNetworkController"]];
		}else {
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			[defaults setValue:@"浙江"
						forKey:@"PROVNAME"];
			
			[defaults setValue:@"宁波"
						forKey:@"CITYNAME"];
			
			//[self.locationManager startUpdatingLocation];
			[ASIHTTPRequest setDefaultTimeOutSeconds:3];
			//查询地域信息 常量
			NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
			ASIHTTPRequest *area = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kTestUrl]];
			
			[area setRequestMethod:@"POST"];
			[postData removeObjectsForKeys:[NSArray arrayWithObjects:@"PAGE_NO",@"PAGE_SIZE",nil]];
			[postData setObject:@"0201" forKey:@"OP"];
			[area setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
								[postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
			[area startSynchronous];
			[postData release];
			NSError *error = [area error];
			if (!error&&[[JSONDecoder decoder] 
						 objectWithData:[area responseData]] ) {
				[self.temporaryValues setObject:[[JSONDecoder decoder] 
												 objectWithData:[area responseData]] 
										 forKey:@"prove"];
				
                NSDictionary *areas =  [kAppDelegate.temporaryValues objectForKey:@"prove"];
                
                NSArray *temp = [[(NSArray*)[areas objectForKey:@"CITYS"] objectAtIndex:6] objectForKey:@"CITYLIST"];
                
                [kAppDelegate.temporaryValues setObject:[temp objectAtIndex:7] 
                                                 forKey:@"selectCity"];
                
				[self.navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://viewController/HomeViewController"]];
				
			}else {
				[self.navigator openURLAction:
				 [TTURLAction actionWithURLPath:@"tt://viewController/NoNetworkController"]];
				[self alert:@"" message:@"地域信息获取失败"];
			}
			
		}	
	}
}


-(TTNavigator*)navigator{
	if (!_navigator) {
		_navigator = [TTNavigator navigator];
		_navigator.persistenceMode = TTNavigatorPersistenceModeNone;
		_navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
	}
	return _navigator;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller from the nib
 */
- (UIViewController*)loadFromNib:(NSString *)nibName withClass:className {
	UIViewController* newController = [[NSClassFromString(className) alloc]
									   initWithNibName:nibName bundle:nil];
	[newController autorelease];
	
	return newController;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller from the the nib with the same name as the
 * class
 */
- (UIViewController*)loadFromNib:(NSString*)className {
	return [self loadFromNib:className withClass:className];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller by name
 */
- (UIViewController *)loadFromVC:(NSString *)className {
	UIViewController * newController = [[ NSClassFromString(className) alloc] init];
	[newController autorelease];
	return newController;
}

// 是否wifi
+ (BOOL) IsEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 是否3G
+ (BOOL) IsEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

static UIAlertView *sAlert = nil;


- (void)alert:(NSString*)title message:(NSString*)message
{
    if (sAlert) return;
    sAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(title,@"")
                                        message:NSLocalizedString(message,@"")
									   delegate:self
							  cancelButtonTitle:@"关闭"
							  otherButtonTitles:nil];
    [sAlert show];
    [sAlert release];
	sAlert = nil;
}

-(MBProgressHUD *) HUD{
	if (!HUD) {
		HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
		[[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
	}
	return HUD;
}

-(void)HUDShow:(NSString*)labelText yOffset:(NSString*)yOffset{
	self.HUD.labelText = labelText;
	self.HUD.yOffset = [yOffset floatValue];
	[self.HUD show:YES];
}

-(void)HUDHide{
	[self.HUD hide:YES];
	[self.HUD performSelector:@selector(setMode:)
				   withObject:MBProgressHUDModeIndeterminate
				   afterDelay:0.5];
}

- (void)showWithCustomView:(NSString*)labelText {
	TT_RELEASE_SAFELY(HUD);
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	self.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	
    // Set custom view mode
    self.HUD.mode = MBProgressHUDModeCustomView;
	self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.labelText = labelText;
	
    [self.HUD show:YES];
	[self.HUD hide:YES afterDelay:1.5];
	[self.HUD performSelector:@selector(setMode:)
				   withObject:MBProgressHUDModeIndeterminate
				   afterDelay:1.6];
}


@end
