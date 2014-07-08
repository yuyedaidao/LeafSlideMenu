//
//  TwoViewController.m
//  LeafSlideMenu
//
//  Created by Wang on 14-7-3.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

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
    self.title = @"普通";
    LOGCMD;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    LOGCMD;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LOGCMD;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    LOGCMD;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    LOGCMD;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
