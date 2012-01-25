//
//  HotMoveViewController.h
//  piaoLaLa
//
//  Created by 高飞 on 11-11-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  正在热映
#import "iCarousel.h"

@interface HotMoveViewController : TTViewController <iCarouselDelegate,iCarouselDataSource>{
    iCarousel * _posterCarousel;//海报传送带
    NSDictionary *interestingPhotosDictionary;
    UILabel *_nameLabel;//影片名
    UILabel *_director;//导演
    UILabel *_starring;//主演
    TTStyledTextLabel *_score;//评分
    UIButton *_buyButton;
    UIViewController *_home;
}
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, assign) UIViewController *home;
@end
