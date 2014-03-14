//
//  SlideMenu.m
//  SlidePanel
//
//  Created by 虫爷 on 14-3-6.
//  Copyright (c) 2014年 xu. All rights reserved.
//

#import "SlideMenu.h"

@interface SlideMenu ()

@property(nonatomic,assign)BOOL menuVisible;
@property(nonatomic,assign)CGPoint startPoint;

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
    return [NSString stringWithFormat:@"Slide Menu with menu:%@,and current content view controller is %@",_menuViewController,_currentViewController];
}
- (void)menuInit
{
    _currentScaleisOn = YES;
    _currentScaleValue = 0.9;
    
    _backgroundImageScaleisOn = YES;
    
    _animateDuration = 0.8;
    _menuVisible = NO;
    
    _panEnabled = NO;
    
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
        imageview.image = [UIImage imageNamed:@"background"];
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageview;
    });
    if (_backgroundImageScaleisOn) {
        _backgroundImageView.transform = CGAffineTransformMakeScale(1.6, 1.6);
    }
    _currentTopButton = ({
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectNull];
        [button addTarget:self action:@selector(hideMenu) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    
    [self.view addSubview:_backgroundImageView];
    //∫_backgroundImageView.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
    [self displayController:_menuViewController frame:self.view.bounds];
    _menuViewController.view.alpha = 0;
    _menuViewController.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [self displayController:_currentViewController frame:self.view.bounds];
    if (_panEnabled) {
        //UIGestureRecognizer *pan = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(receiveGestureRecognized:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(receiveGestureRecognized:)];
        pan.delegate = self;
        [self.view addGestureRecognizer:pan];
    }
}

- (void)showMenu
{
    [self.view.window endEditing:YES];
    [self addButtonOnCurrentTop];
    [UIView animateWithDuration:_animateDuration animations:^{
        //控制内容视图缩放
        if (_currentScaleisOn) {
            _currentViewController.view.transform = CGAffineTransformMakeScale(_currentScaleValue, _currentScaleValue);
        }
        _currentViewController.view.center = CGPointMake(CGRectGetWidth(self.view.frame) + 30, self.view.center.y);
        //menu显示控制
        _menuViewController.view.alpha = 1.0f;
        _menuViewController.view.transform = CGAffineTransformIdentity;
        //background 缩放比例
        if (_backgroundImageScaleisOn) {
            _backgroundImageView.transform = CGAffineTransformIdentity;
        }
        
    } completion:^(BOOL finished) {
        _menuVisible = YES;
       
    }];
    
}

- (void)hideMenu
{
    [_currentTopButton removeFromSuperview];
    
    [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
    [UIView animateWithDuration:_animateDuration animations:^{
        _currentViewController.view.transform = CGAffineTransformIdentity;
        _currentViewController.view.frame = self.view.bounds;
        _menuViewController.view.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        _menuViewController.view.alpha = 0;
        if (_backgroundImageScaleisOn) {
            _backgroundImageView.transform = CGAffineTransformMakeScale(1.6, 1.6);
        }
        
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication]endIgnoringInteractionEvents];
        _menuVisible = NO;
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

- (void)setCurrentViewController:(UIViewController *)currentViewController
{
    if(!_currentViewController){
        _currentViewController = currentViewController;
        return;
    }
    CGRect frame = _currentViewController.view.frame;
    CGAffineTransform transform = _currentViewController.view.transform;
    [self hideController:_currentViewController];
    _currentViewController = currentViewController;
    [self displayController:currentViewController frame:self.view.bounds];
    _currentViewController.view.transform = transform;
    _currentViewController.view.frame = frame;
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
#pragma mark
#pragma 手势回调

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //处理何时不接受手势
    /*
       iOS7下 nav后退手势；
     */
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && !_menuVisible) {
        
    }
    
    return YES;
}

- (void)receiveGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
    /*begin receive gesture delegate waiting... */
    if (!_panEnabled) {
        return;
    }
    
    CGPoint point = [recognizer translationInView:self.view];
    
    if (!_menuVisible) {
        if (point.x < 0) {
            return;
        }
    } else {
        if (point.x > 0) {
            return;
        }
    }
    
    //
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        /*menu will show delegate waiting... */
     
        float start_X = _currentViewController.view.center.x - _currentViewController.view.frame.size.width/2;
        float start_Y = _currentViewController.view.center.y - _currentViewController.view.frame.size.height/2;
        _startPoint = CGPointMake(start_X, start_Y);
        [self addButtonOnCurrentTop];
        [self.view.window endEditing:YES];
    }
    
    if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged) {
        //移动计算偏移度,左->右 0->1  右到左 1->0
        CGFloat delta = _menuVisible ? ((_startPoint.x + point.x)/_startPoint.x):(point.x/self.view.frame.size.width);
        //内容视图scale数值
        CGFloat currentViewScaleValue = 1 - ((1-_currentScaleValue) * delta);
        //menu视图scale数值
        CGFloat menuViewScaleValue = 1.5 - (0.5 * delta);
        //背景scale数值
        CGFloat backViewScaleValue = 1.6 - (0.6 * delta);
        
        _menuViewController.view.alpha = delta;
        _menuViewController.view.transform = CGAffineTransformMakeScale(menuViewScaleValue, menuViewScaleValue);
        
        
        if (_currentScaleisOn) {
            _currentViewController.view.transform = CGAffineTransformMakeScale(currentViewScaleValue, currentViewScaleValue);
            _currentViewController.view.transform = CGAffineTransformTranslate(_currentViewController.view.transform, point.x, 0);
        }
        if (_backgroundImageScaleisOn) {
            _backgroundImageView.transform = CGAffineTransformMakeScale(backViewScaleValue, backViewScaleValue);
        }
      
        
    }
    
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"%f",[recognizer velocityInView:self.view].x);
        if ([recognizer velocityInView:self.view].x > 0) {
            [self showMenu];
        } else {
            [self hideMenu];
        }
    }
}

@end
