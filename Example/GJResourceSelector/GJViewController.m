//
//  GJViewController.m
//  GJResourceSelector
//
//  Created by gaogee on 11/13/2023.
//  Copyright (c) 2023 gaogee. All rights reserved.
//

#import "GJViewController.h"
#import <GJResourceSelector/GJResourceSelectorView.h>
#import <GJResourceSelector/GJResourceSelectorConfig.h>
@interface GJViewController ()

@end

@implementation GJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn setTitle:@"选择图片" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 400, 100, 30)];
    [btn1 setTitle:@"选择视频" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(selectClick1) forControlEvents:UIControlEventTouchUpInside];
    
    GJResourceSelectorConfig.config.goBackImage = [UIImage imageNamed:@"pk_photo_selected_goback"];
    GJResourceSelectorConfig.config.filterImage = [UIImage imageNamed:@"pk_photo_selected_open"];
    GJResourceSelectorConfig.config.filterImage = [UIImage imageNamed:@"pk_photo_selected_open"];
    GJResourceSelectorConfig.config.selectedImage = [UIImage imageNamed:@"pk_photo_selected"];
    GJResourceSelectorConfig.config.unSelectedImage = [UIImage imageNamed:@"pk_photo_un_selected"];
    GJResourceSelectorConfig.config.videoDurationImage = [UIImage imageNamed:@"pk_browser_video"];
   
}
-(void)selectClick{
   
    [GJResourceSelectorView loadWithLimitNumber:1 mediaType:GJResourceAssetMediaTypeImage completedBlock:^(GJResourceSelectorView * _Nonnull alertView, NSMutableArray<UIImage *> * _Nullable photos, NSString * _Nullable videoPath) {
        
    } cancelBlock:^(GJResourceSelectorView * _Nonnull alertView) {
        
    }];
}
-(void)selectClick1{
   
    [GJResourceSelectorView loadWithLimitNumber:1 mediaType:GJResourceAssetMediaTypeVideo completedBlock:^(GJResourceSelectorView * _Nonnull alertView, NSMutableArray<UIImage *> * _Nullable photos, NSString * _Nullable videoPath) {
        
    } cancelBlock:^(GJResourceSelectorView * _Nonnull alertView) {
        
    }];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
