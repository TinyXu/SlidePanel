//
//  UIViewController+SlidePanel.m
//  SlidePanel
//
//  Created by 虫爷 on 14-3-12.
//  Copyright (c) 2014年 xu. All rights reserved.
//

#import "UIViewController+SlidePanel.h"


@implementation UIViewController (SlidePanel)

-(SlideMenu *)slideMenu
{
    UIViewController *parent = self.parentViewController;

    while(parent) {
        if ([parent isKindOfClass:[SlideMenu class]]) {
            return (SlideMenu *)parent;
        } else if (parent.parentViewController && parent.parentViewController != parent) {
            parent = parent.parentViewController;
        } else {
            parent = nil;
        }
         
    }
    
    return nil;
}
@end
