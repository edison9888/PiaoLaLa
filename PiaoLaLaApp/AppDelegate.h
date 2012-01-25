//
//  AppDelegate.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    TTNavigator* _navigator;
    NSMutableDictionary *_temporaryValues;
    MBProgressHUD *HUD;
}
@property (nonatomic, readonly) MBProgressHUD *HUD;
@property (nonatomic, retain) NSMutableDictionary *temporaryValues;
@property (nonatomic, readonly) TTNavigator* navigator;
- (UIViewController*)loadFromNib:(NSString*)className;
- (UIViewController *)loadFromVC:(NSString *)className;
-(void)HUDShow:(NSString*)labelText yOffset:(NSString*)yOffset;
-(void)HUDHide;
- (void)showWithCustomView:(NSString*)labelText;
- (void)alert:(NSString*)title message:(NSString*)message;
+ (BOOL) IsEnableWIFI;
+ (BOOL) IsEnable3G;
@end
