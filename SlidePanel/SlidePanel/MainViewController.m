//
//  MainViewController.m
//  SlidePanel
//
//  Created by 虫爷 on 14-3-12.
//  Copyright (c) 2014年 xu. All rights reserved.
//

#import "MainViewController.h"
#import "UIViewController+SlidePanel.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)test:(id)sender {
    [self.slideMenu showMenu];
}
@end
