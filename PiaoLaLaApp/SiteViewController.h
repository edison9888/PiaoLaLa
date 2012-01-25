//
//  SiteViewController.h
//  PiaoLaLaApp
//
//  Created by 高飞 on 11-12-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
// 订座界面
@class UIImageViewSite;

@interface SiteViewController : TTViewController<UIScrollViewDelegate>{
	UIScrollView *_siteMapScrll;
	UIView *_siteMap;
	int a[200][200];
	int seletTotal;
	NSMutableArray *_selectArray;
	int maxCol;
	BOOL _touching;
	UIScrollView * _siteScroll;
	UILabel * _nameLabel;
	BOOL _notif;
    id notif;
    UIView *_colView;
    UIView *_rowView;
    UIImageView *_screenImage;
    UIImageView *_navigationHeader;
}
@property (nonatomic, readonly) UILabel *nameLabel;
-(BOOL)isSelect:(int)x y:(int)y;
-(void)unSelect:(int)x y:(int)y site:(UIImageViewSite*)site;
-(void)removeSite:(UIImageViewSite*)site;
-(void)refreshAction;

@end
