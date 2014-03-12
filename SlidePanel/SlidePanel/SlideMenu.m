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
    _currentScaleisOn = YES;
    _currentScaleValue = 0.9;
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
    _currentTopButton = ({
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectNull];
        [button addTarget:self action:@selector(hideMenu) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    
    [self.view addSubview:_backgroundImageView];
    //∫_backgroundImageView.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
    [self displayController:_menuViewController frame:self.view.bounds];
    _menuViewController.view.alpha = 0;
    [self displayController:_currentViewController frame:self.view.bounds];
    NSLog(@"%@",self.view.subviews);
  
}

- (void)showMenu
{
    [self.view.window endEditing:YES];
    [self addButtonOnCurrentTop];
    NSLog(@"%@",[_currentViewController.view subviews]);
    [UIView animateWithDuration:1.0f animations:^{
        //控制内容视图缩放
        if (_currentScaleisOn) {
            _currentViewController.view.transform = CGAffineTransformMakeScale(_currentScaleValue, _currentScaleValue);
        }
        _currentViewController.view.center = CGPointMake(CGRectGetWidth(self.view.frame) + 30, self.view.center.y);
        //menu显示控制
        _menuViewController.view.alpha = 1.0f;
        _menuViewController.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)hideMenu
{
    [_currentTopButton removeFromSuperview];
    
    [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
    [UIView animateWithDuration:1.0f animations:^{
        _currentViewController.view.transform = CGAffineTransformIdentity;
        _currentViewController.view.frame = self.view.bounds;
        _menuViewController.view.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        _menuViewController.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication]endIgnoringInteractionEvents];
    }];
}

- (void)addButtonOnCurrentTop
{
    if (_currentTopButton.superview) {
        return;
    }
    _currentTopButton.autoresizingMask = UIViewAutoresizingNone;
    _currentTopButton.frame = _currentViewController.view.bounds;
    _currentTopButton.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_currentViewController.view addSubview:_currentTopButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayController:(UIViewController *)controller frame:(CGRect)frame
{
    [self addChildViewController:controller];
    [controller.view setFrame:frame];
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}

-(void)hideController:(UIViewController *)controller
{
    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
}


@end
