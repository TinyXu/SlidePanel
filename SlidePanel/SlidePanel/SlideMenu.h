//
//  SlideMenu.h
//  SlidePanel
//
//  Created by 虫爷 on 14-3-6.
//  Copyright (c) 2014年 xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenu : UIViewController
{
    UIImageView *_backgroundImageView;
}

@property(nonatomic,strong,readwrite) UIViewController *currentViewController;
@property(nonatomic,strong,readwrite) UIViewController *menuViewController;
@property(nonatomic,strong,readwrite) UIImage *backgroundImage;
@end
