//
//  MenuViewController.m
//  SlidePanel
//
//  Created by 虫爷 on 14-3-12.
//  Copyright (c) 2014年 xu. All rights reserved.
//

#import "MenuViewController.h"
#import "SettingViewController.h"
#import "MainViewController.h"
#import "UIViewController+SlidePanel.h"
@interface MenuViewController ()

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *texts;
@property(nonatomic,strong)NSArray *images;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStylePlain];
    _tableview.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.opaque = NO;
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.bounces = NO;
    [self.view addSubview:_tableview];
    _texts = @[@"注册",@"设置"];
    _images = @[@"one",@"two"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellReuseId = @"cell";
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseId];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseId];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.2];
        cell.selectedBackgroundView = view;
    }
    [cell.textLabel setText:_texts[indexPath.row]];
    [cell.imageView setImage:[UIImage imageNamed:@"one"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {
        case 0:
            self.slideMenu.currentViewController = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
            [self.slideMenu hideMenu];
            break;
        case 1:
            self.slideMenu.currentViewController = [[SettingViewController alloc]init];
            [self.slideMenu hideMenu];
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
