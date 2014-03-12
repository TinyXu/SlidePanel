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
//内容视图缩放控制开关
@property(nonatomic,assign,readwrite) BOOL currentScaleisOn;
//当前内容显示menu时缩放比例
@property(nonatomic,assign,readwrite) CGFloat currentScaleValue;
//当前视图覆盖按钮
@property(nonatomic,strong) UIButton *currentTopButton;

@property(nonatomic,strong,readwrite) UIViewController *currentViewController;
@property(nonatomic,strong,readwrite) UIViewController *menuViewController;
@property(nonatomic,strong,readwrite) UIImage *backgroundImage;


-(id)initWithCurrentViewController:(UIViewController *)currentViewController menu:(UIViewController *)menuViewController;
- (void)showMenu;
@end
