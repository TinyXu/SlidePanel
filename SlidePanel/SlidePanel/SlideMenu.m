//
//  SlideMenu.m
//  SlidePanel
//
//  Created by 虫爷 on 14-3-6.
//  Copyright (c) 2014年 xu. All rights reserved.
//

#import "SlideMenu.h"

@interface SlideMenu ()

@end

@implementation SlideMenu

-(id)init
{
    self = [super init];
    if (self) {
        [self menuInit];
    }
    return self;
}
- (NSString *)description
{
    return @"Slide Menu";
}
- (void)menuInit
{
   
}

-(id)initWithCurrentViewController:(UIViewController *)currentViewController menu:(UIViewController *)menuViewController
{
    self = [self init];
    if (self) {
        _currentViewController = currentViewController;
        _menuViewController = menuViewController;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _backgroundImageView = ({
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.bounds];
        imageview.image = [UIImage imageNamed:@"MenuBackground"];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageview;
    });
    
    [self.view addSubview:_backgroundImageView];

  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
