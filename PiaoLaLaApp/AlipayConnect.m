//
//  AlipayConnect.m
//  MoveDemo
//
//  Created by bill on 11-6-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlipayConnect.h"
#import <commoncrypto/CommonDigest.h> 
#import "ASIHTTPRequest.h"
#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "AlixPay.h"
#import "DataSigner.h"

@implementation AlipayConnect

@synthesize delegate;
@synthesize dicAlipay_;
@synthesize urlConnection;


-(NSString*)URLDecodedString:(NSString *)str
{
    NSString *result = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)str,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8);
	
    [result autorelease];
    return result;
}

//第一次 支付  通票
-(void) servicesAlipay :(NSDictionary*) dic {
	
	if (dic ==nil) {
		if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
						[self.delegate setWebError:@"Dictionary Data is Nil"];
			}
		return;

	}

	//请求详情

	NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithDictionary:dic];
	[postData setObject:@"0604" forKey:@"OP"];

	ASIHTTPRequest *detailRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:kTestUrl]];
	[detailRequest setRequestMethod:@"POST"];
	[detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
								 [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
	[postData release];
	[detailRequest setDelegate:self];
	[detailRequest startSynchronous];
	NSError *error =[detailRequest error];
	if(!error)
	{
		NSDictionary *detailDictionary = [[JSONDecoder decoder] 
										  objectWithData:[detailRequest responseData]];
		//NSLog(@"订单字典 %@",detailDictionary);
		
		[detailRequest release];
		if (detailDictionary ==nil) {
			if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
				[self.delegate setWebError:@"Dictionary Data is Nil"];
			}
			return;

		}
		NSString *appScheme = @"PiaoLaLaApp";
		NSString *base64String = [detailDictionary objectForKey:@"URL"];
		NSString *orderString =[self URLDecodedString:base64String];
		NSLog(@"orderString: %@",orderString);
		
		AlixPay * alixpay = [AlixPay shared];
		int ret = [alixpay pay:orderString applicationScheme:appScheme];
		if (ret == kSPErrorAlipayClientNotInstalled) {
			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
																 message:@"您还没有安装支付宝的客户端，请先装。" 
																delegate:self 
													   cancelButtonTitle:@"确定" 
													   otherButtonTitles:nil];
			[alertView setTag:123];
			[alertView show];
			[alertView release];
		}
		else if (ret == kSPErrorSignError) {
			//NSLog(@"签名错误！");
			if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
				[self.delegate setWebError:@"签名错误！"];
			}
			return;
		}
		
		
			
	}else {
		if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
			[self.delegate setWebError:@"Data is error"];
		}
		return;

	}
}

//第一次 支付  订座票
-(void) destineAlipay :(NSDictionary*) dic {
	
	if (dic ==nil) {
		if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
			[self.delegate setWebError:@"Dictionary Data is Nil"];
		}
		return;

	}
	
	//请求详情
	
	NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithDictionary:dic];
	[postData setObject:@"0711" forKey:@"OP"];
	
	ASIHTTPRequest *detailRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:kTestUrl]];
	[detailRequest setRequestMethod:@"POST"];
	[detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
								 [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
	[postData release];
	[detailRequest setDelegate:self];
	[detailRequest startSynchronous];
	NSError *error =[detailRequest error];
	if(!error)
	{
		NSDictionary *detailDictionary = [[JSONDecoder decoder] 
										  objectWithData:[detailRequest responseData]];
		NSLog(@"订单字典 %@",detailDictionary);
		NSString *str=[detailDictionary objectForKey:@"RESULTCODE"];
		if ([str isEqualToString:@"1"]==YES) {
			if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
				[self.delegate setWebError:@"虚拟锁坐失败"];
			}
			return;
			
		}else if ([str isEqualToString:@"2"]==YES) {
			if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
				[self.delegate setWebError:@"下订单失败"];
			}
			return;
			
		}else if ([str isEqualToString:@"3"]==YES){
			if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
				[self.delegate setWebError:@"生成订单失败，锁坐失败，或者手机号码输入不正确"];
			}
			return;
			
		}
		if (nil ==detailDictionary) {
			if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
				[self.delegate setWebError:@"Dictionary Data is Nil"];
			}
			return;

		}
		[detailRequest release];
		NSString *appScheme = @"PiaoLaLaApp";
		NSString *base64String = [detailDictionary objectForKey:@"URL"];
		NSString *orderString =[self URLDecodedString:base64String];
		NSLog(@"orderString: %@",orderString);
		
		AlixPay * alixpay = [AlixPay shared];
		int ret = [alixpay pay:orderString applicationScheme:appScheme];
		if (ret == kSPErrorAlipayClientNotInstalled) {
			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
																 message:@"您还没有安装支付宝的客户端，请先装。" 
																delegate:self 
													   cancelButtonTitle:@"确定" 
													   otherButtonTitles:nil];
			[alertView setTag:123];
			[alertView show];
			[alertView release];
		}
		else if (ret == kSPErrorSignError) {
			//NSLog(@"签名错误！");
			if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
				[self.delegate setWebError:@"签名错误！"];
			}
			return;
		}
	}else {
		if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
			[self.delegate setWebError:@"Data is error"];
		}
		return;

	}
}

//延迟支付 通票
-(void) unpaiy :(NSDictionary*) dic {
	
	if (dic ==nil) {
		if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
			[self.delegate setWebError:@"Dictionary Data is Nil"];
		}
		return;

	}
	
	//请求详情

	NSMutableDictionary *postData = [[NSMutableDictionary alloc] initWithDictionary:dic];
	[postData setObject:@"0605" forKey:@"OP"];
	
	ASIHTTPRequest *detailRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:kTestUrl]];
	[detailRequest setRequestMethod:@"POST"];
	[detailRequest setPostBody:[[NSString stringWithFormat:@"%@%@",[[NSString stringWithFormat:@"%@%@",[postData JSONString],kMD5Key] MD5],
								 [postData JSONString]]dataUsingEncoding:NSUTF8StringEncoding]];
	[postData release];
	[detailRequest setDelegate:self];
	[detailRequest startSynchronous];
	NSError *error =[detailRequest error];
	if(!error)
	{
		NSDictionary *detailDictionary = [[JSONDecoder decoder] 
										  objectWithData:[detailRequest responseData]];
		NSLog(@"订单字典 %@",detailDictionary);
		[detailRequest release];
		if (detailDictionary ==nil) {
			if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
				[self.delegate setWebError:@"Dictionary Data is Nil"];
			}
			return;

		}
		NSString *appScheme = @"PiaoLaLaApp";
		NSString *base64String = [detailDictionary objectForKey:@"URL"];
		NSString *orderString =[self URLDecodedString:base64String];
		NSLog(@"orderString: %@",orderString);
		
		AlixPay * alixpay = [AlixPay shared];
		int ret = [alixpay pay:orderString applicationScheme:appScheme];
		if (ret == kSPErrorAlipayClientNotInstalled) {
			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
																 message:@"您还没有安装支付宝的客户端，请先装。" 
																delegate:self 
													   cancelButtonTitle:@"确定" 
													   otherButtonTitles:nil];
			[alertView setTag:123];
			[alertView show];
			[alertView release];
		}
		else if (ret == kSPErrorSignError) {
			//NSLog(@"签名错误！");
			if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
				[self.delegate setWebError:@"签名错误！"];
			}
			return;
		}
		

		
	}else {
		if (self.delegate && [self.delegate respondsToSelector:@selector(setWebError:)]) {
			[self.delegate setWebError:@"Data is error"];
		}
		return;

	}
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 123) {
		NSString * URLString = [NSString stringWithString:@"http://itunes.apple.com/cn/app/id333206289?mt=8"];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	self.dicAlipay_ =nil;
	self.urlConnection =nil;
    [super dealloc];
	
}

@end
