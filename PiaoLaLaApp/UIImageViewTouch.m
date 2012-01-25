//
//  UIImageViewTouch.m
//  piaoLaLa
//
//  Created by 高飞 on 11-11-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIImageViewTouch.h"

@implementation UIImageViewTouch
@synthesize userInfo = _userInfo;

-(void)dealloc{
    TT_RELEASE_SAFELY(_userInfo);
    [super dealloc];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (isSingleTap){
       // NSLog(@"isDoubleTap");
    }
    
	isSingleTap = ([touches count] == 1);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	isSingleTap = NO;
	isDoubleTap = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { 
    
    //Get all the touches.
    NSSet *allTouches = [event allTouches];
    
    //Number of touches on the screen
    switch ([allTouches count])
    {
        case 1:
        {
            //Get the first touch.
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
            
            switch([touch tapCount])
            {
                case 1://Single tap
                    
                    break;
                case 2://Double tap.
                    
                    NSLog(@"Double tap");
                    
                    break;
            }
        } 
            break;
    }
}

@end
