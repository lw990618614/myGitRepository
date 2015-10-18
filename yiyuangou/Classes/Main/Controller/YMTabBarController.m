//
//  YMTabBarController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMTabBarController.h"
#import "MyCarViewController.h"
#import "TreasureViewController.h"
#import "MySettingViewController.h"
#import "HomeViewController.h"
#import "RewardViewController.h"
#import "YMNavigationController.h"
#import "UIImage+tmri.h"
@interface YMTabBarController ()

@end

@implementation YMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 第1个
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addChildVC:home title:@"抢购" imgName:@"mainDefIcon" selectedName:@"mainSelIcon"];
    
    // 第2个
    RewardViewController *reward = [[RewardViewController alloc] init];
    [self addChildVC:reward title:@"最近开奖" imgName:@"discountDefIcon" selectedName:@"discountSelIcon"];
    
    // 第3个
    TreasureViewController *treasure = [[TreasureViewController alloc] init];
    [self addChildVC:treasure title:@"夺宝圈" imgName:@"searchDefIcon" selectedName:@"searchSelIcon"];
    
    // 第4个
    MyCarViewController *mycar = [[MyCarViewController alloc] init];
    [self addChildVC:mycar title:@"购物车" imgName:@"myDefIcon" selectedName:@"mySelIcon"];
    
    // 第5个
    MySettingViewController *mysetting = [[MySettingViewController alloc] init];
    [self addChildVC:mysetting title:@"我的" imgName:@"myDefIcon" selectedName:@"mySelIcon"];

}

-(void)addChildVC:(UIViewController *)vc title:(NSString *)title imgName:(NSString *)imgName selectedName:(NSString *)selectedImgName{
    
    YMNavigationController *nav = [[YMNavigationController alloc] initWithRootViewController:vc];
    // 设置UITabbarButton的图片和文字
    vc.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imgName];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置导航栏的颜色
    UINavigationBar *navigationBarAppearance=[UINavigationBar appearance];
    [navigationBarAppearance setTintColor:[UIColor whiteColor]];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏标题的颜色
    NSDictionary *navigationTextAttributes=@{
                                             NSForegroundColorAttributeName: [UIColor whiteColor],
                                             };
    [navigationBarAppearance setTitleTextAttributes:navigationTextAttributes];
   
    // 设置选中图片
    UIImage *selectedImg = [UIImage imageNamed:selectedImgName];
    // 设置图片一个渲染方式,返回一个没有渲染效果图片
    selectedImg = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = selectedImg;
    
    //配置TabBar
    UITabBar*tabBarAppearance=[UITabBar appearance];
    [tabBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];//设置背景
//    [tabBarAppearance setSelectionIndicatorImage:[UIImage imageNamed:@""]];
//    [tabBarAppearance setShadowImage:[UIImage imageNamed:@""]];//隐藏那条黑线

    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
