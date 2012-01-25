//
//  PassOrderViewController.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PassOrderViewController.h"

@implementation PassOrderViewController
@synthesize back = _back;
@synthesize line1 = _line1;
@synthesize line2 = _line2;
@synthesize line3 = _line3;
@synthesize type1 = _type1;
@synthesize type2 = _type2;
@synthesize type3 = _type3;
@synthesize num1 = _num1;
@synthesize num2 = _num2;
@synthesize num3 = _num3;
@synthesize num4 = _num4;
@synthesize price = _price;
@synthesize name1 = _name1;
@synthesize name2 = _name2;
@synthesize name3 = _name3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
       
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

-(void)loadView{
    [super loadView];
//    UIImageView *_line = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line1.png")];
//    _line.frame =CGRectMake(0, 81, 300, 0.5);
//    [self.back addSubview:_line];
    [self.type1 setImage:TTIMAGE(@"bundle://radio2.png") forState:UIControlStateNormal];
    [self.type1 setImage:TTIMAGE(@"bundle://radio1.png") forState:UIControlStateHighlighted];
    
    _type = 10;
    _num = 22;
    [self.num2 setBackgroundImage:TTIMAGE(@"bundle://button6_2.png") forState:UIControlStateNormal];
    [self.num2 setBackgroundImage:TTIMAGE(@"bundle://button6_1.png") forState:UIControlStateHighlighted];
    //背景
    self.line1.frame = CGRectMake(self.line1.frame.origin.x, self.line1.frame.origin.y, self.line1.frame.size.width, 0.5);
    self.line2.frame = CGRectMake(self.line2.frame.origin.x, self.line2.frame.origin.y, self.line2.frame.size.width, 0.5);
    self.line3.frame = CGRectMake(self.line3.frame.origin.x, self.line3.frame.origin.y, self.line3.frame.size.width, 0.5);
    UIImageView *_backGround = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://background.png")] autorelease];
    _backGround.frame = CGRectMake(0, 0, 320, 460);
    [self.view addSubview:_backGround];
    [self.view sendSubviewToBack:_backGround];
    self.back.backgroundColor = [UIColor clearColor];
    self.back.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
                 [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                  [TTSolidBorderStyle styleWithColor:RGBCOLOR(158, 163, 172) width:1 next:nil]]];
    
    
    NSArray *tickets =  [[kAppDelegate.temporaryValues 
                          objectForKey:@"SelsectCINEMA"] 
                         objectForKey:@"TICKETS"];
    
    if ([tickets count]>=1) {
        self.name1.text = [NSString stringWithFormat:@"%@(%d/张)",
                           [[tickets objectAtIndex:0] objectForKey:@"TICKETNAME"],
                           [[[tickets objectAtIndex:0] objectForKey:@"TICKETPRICE"] intValue]];
        UIImageView *_line01 = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line1.png")];
        _line01.frame = CGRectMake(1, 91, 298, 1);
        [self.back addSubview:_line01];
        [_line01 release];
    }else{
        self.name1.hidden = YES;
        self.type1.hidden = YES;
        self.name2.hidden = YES;
        self.type2.hidden = YES;
        self.name3.hidden = YES;
        self.type3.hidden = YES;
    }
    
    if ([tickets count]>=2) {
        self.name2.text = [NSString stringWithFormat:@"%@(%d/张)",
                                   [[tickets objectAtIndex:1] objectForKey:@"TICKETNAME"],
                                   [[[tickets objectAtIndex:1] objectForKey:@"TICKETPRICE"] intValue]];
        UIImageView *_line02 = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line1.png")];
        _line02.frame = CGRectMake(1, 143, 298, 1);
        [self.back addSubview:_line02];
        [_line02 release];
    }else{
        self.name2.hidden = YES;
        self.type2.hidden = YES;
        self.name3.hidden = YES;
        self.type3.hidden = YES;
    }
        
    if ([tickets count]>=3) {
        self.name3.text = [NSString stringWithFormat:@"%@(%d/张)",
                           [[tickets objectAtIndex:2] objectForKey:@"TICKETNAME"],
                           [[[tickets objectAtIndex:2] objectForKey:@"TICKETPRICE"] intValue]];
        UIImageView *_line03 = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://line1.png")];
        _line03.frame = CGRectMake(1, 191, 298, 1);
        [self.back addSubview:_line03];
        [_line03 release];
    }else{
        self.name3.hidden = YES;
        self.type3.hidden = YES;
    }
    
    
    _price.text = [NSString stringWithFormat:@"总价: %d 元",([[[tickets objectAtIndex:(_type-10)] 
                                                             objectForKey:@"TICKETPRICE"] 
                                                            intValue] * (_num-20))];
}

-(IBAction)typeAction:(id)sender{
    if (_type!=((UIButton*)sender).tag) {
        [(UIButton*)sender setImage:TTIMAGE(@"bundle://radio2.png") forState:UIControlStateNormal];
        [(UIButton*)sender setImage:TTIMAGE(@"bundle://radio1.png") forState:UIControlStateHighlighted];
        
        [(UIButton*)[self.view viewWithTag:_type] setImage:TTIMAGE(@"bundle://radio1.png") forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:_type] setImage:TTIMAGE(@"bundle://radio2.png") forState:UIControlStateHighlighted];
        
        _type = ((UIButton*)sender).tag;
        

        

        
        _price.text = [NSString stringWithFormat:@"总价: %d 元",([[[[[kAppDelegate.temporaryValues 
                                                                            objectForKey:@"SelsectCINEMA"] 
                                                                           objectForKey:@"TICKETS"] objectAtIndex:(_type-10)] 
                                                                         objectForKey:@"TICKETPRICE"] 
                                                                        intValue] * (_num-20))];

    }
}

//确认购买
-(IBAction)confirm{
    //10 20 30 类型
    //21 22 23 24 数量
    [kAppDelegate.temporaryValues setObject:[[[kAppDelegate.temporaryValues 
                                               objectForKey:@"SelsectCINEMA"] 
                                              objectForKey:@"TICKETS"] objectAtIndex:(_type-10)]
                                     forKey:@"orderTicket"];
    
    [kAppDelegate.temporaryValues setObject:[NSString stringWithFormat:@"%d",(_num-20)] 
                                     forKey:@"orderNum"];
    
    [kAppDelegate.temporaryValues setObject:[NSString stringWithFormat:@"%d",([[[[[kAppDelegate.temporaryValues 
                                                                                   objectForKey:@"SelsectCINEMA"] 
                                                                                  objectForKey:@"TICKETS"] objectAtIndex:(_type-10)] 
                                                                                objectForKey:@"TICKETPRICE"] 
                                                                               intValue] * (_num-20))]
                                     forKey:@"orderPrice"];
    
    TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://nib/TPOrderDetailViewController"];
	urlAction.animated = YES;
	[[TTNavigator navigator] openURLAction:urlAction];
    
}

-(IBAction)numAction:(id)sender{
   // NSLog(@"tag %d",((UIButton*)sender).tag);
    if (_num !=((UIButton*)sender).tag) {
        [(UIButton*)sender setBackgroundImage:TTIMAGE(@"bundle://button6_2.png") forState:UIControlStateNormal];
        [(UIButton*)sender setBackgroundImage:TTIMAGE(@"bundle://button6_1.png") forState:UIControlStateHighlighted];
        
        [(UIButton*)[self.view viewWithTag:_num] setBackgroundImage:TTIMAGE(@"bundle://button6_1.png") forState:UIControlStateNormal];
        [(UIButton*)[self.view viewWithTag:_num] setBackgroundImage:TTIMAGE(@"bundle://button6_2.png") forState:UIControlStateHighlighted];
        
        _num = ((UIButton*)sender).tag;
        
        _price.text = [NSString stringWithFormat:@"总价: %d 元",( [[[[[kAppDelegate.temporaryValues 
                                                                    objectForKey:@"SelsectCINEMA"] 
                                                                   objectForKey:@"TICKETS"] objectAtIndex:(_type-10)] 
                                                                 objectForKey:@"TICKETPRICE"] 
                                                                intValue] * (_num-20))];
    }
}
@end
