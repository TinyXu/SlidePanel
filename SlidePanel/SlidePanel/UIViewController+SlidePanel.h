//
//  UIViewController+SlidePanel.h
//  SlidePanel
//
//  Created by 虫爷 on 14-3-12.
//  Copyright (c) 2014年 xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenu.h"
@interface UIViewController (SlidePanel)
@property(nonatomic,strong,getter = slideMenu) SlideMenu *slideMenu;

@end
