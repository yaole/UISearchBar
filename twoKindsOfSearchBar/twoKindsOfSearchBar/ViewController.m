//
//  ViewController.m
//  twoKindsOfSearchBar
//
//  Created by ozx on 15/5/29.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import "ViewController.h"
#import "sysSreachBarViewController.h"
#import "diySreachBarViewController.h"
#import "publicDefine.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    automaticallyAdjustsScrollViewInsets = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    self.navigationController.navigationBar.translucent = NO;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * sysSreachBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2-50, ScreenH/3, 100, 50)];
    sysSreachBtn.backgroundColor = [UIColor orangeColor];
    [sysSreachBtn setTitle:@"sysSreach" forState:UIControlStateNormal];
    sysSreachBtn.tag = 1;
    [sysSreachBtn addTarget:self action:@selector(zhuanye:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * DiySreachBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2-50, ScreenH/3*2, 100, 50)];
    [DiySreachBtn setTitle:@"diySreach" forState:UIControlStateNormal];
    DiySreachBtn.backgroundColor = [UIColor orangeColor];
    DiySreachBtn.tag = 2;
    [DiySreachBtn addTarget:self action:@selector(zhuanye:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sysSreachBtn];
    [self.view addSubview:DiySreachBtn];
}


-(void)zhuanye:(UIButton *)btn{
    if (btn.tag == 1) {
        sysSreachBarViewController * sysS = [[sysSreachBarViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:sysS animated:YES];
    }else if(btn.tag == 2){
        diySreachBarViewController * diyS = [[diySreachBarViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:diyS animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
