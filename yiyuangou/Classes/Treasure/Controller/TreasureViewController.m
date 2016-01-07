//
//  TreasureViewController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "TreasureViewController.h"
#import "YMProductionCell.h"
#import "TreasureManager.h"
#import "TreasureResult.h"
#import "YMInfoCenter.h"
#import "YMTreasureFrame.h"
#import "AppDelegate.h"
#import "YMTabBarController.h"
#import "YMNoDataView.h"
#import "ImgScrollView.h"
#import "GridView.h"
#import "TapImageView.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "ImgScrollView.h"
#import "ELCImagePickerHeader.h"

@interface TreasureViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ImgScrollViewDelegate,TapImageViewDelegate>
{
    UIScrollView  *myScrollView;
    UIView          *scrollPanel;
    UIView          *markView;
    NSInteger       currentIndex;
   
    NSMutableArray *shareListArray;
    NSMutableArray *TreasureFrameArray;
    YMProductionCell *tapCell;
}
@property(nonatomic,strong)GridView   *gridView;
@property(nonatomic,strong)NSArray    *imgArray;
@property (nonatomic,assign)NSInteger shareStart;
@property (nonatomic,assign)BOOL isFirst;
@property (nonatomic,strong)UITableView *tableView;
@property  (nonatomic,strong)YMNoDataView *notiView;
@property(nonatomic,strong)UIScrollView *scrollview;
@property (nonatomic,assign)BOOL isfirstLoad;
@end

@implementation TreasureViewController
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [self tapImageViewTappedWithObject:self.sender];
//    [scrollPanel removeFromSuperview];
//    [markView removeFromSuperview];
//    [myScrollView removeFromSuperview];
//    scrollPanel = nil;
//    markView = nil;
//    myScrollView = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
-(YMNoDataView *)notiView
{
    if (_notiView == nil) {
        UIImage *img = [UIImage imageNamed:@"noData"];
        _notiView  = [[YMNoDataView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) title:@"暂无记录" image:img btnTitle:@"马上夺宝" action:@selector(duobao:) tagert:self];
    }
    return _notiView;
}
-(void)goshopping
{
    AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
    [tabbar setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

    self.title = self.titleName?self.titleName:@"夺宝圈";
    UIButton *rightBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 60, 44) target:self action:@selector(rightTopClick) title:@"我的晒单" cornerRadius:0];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    TreasureFrameArray = [[NSMutableArray alloc] init];
    shareListArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=self.isHiden?nil:rightItem;
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    //下拉刷新
    self.tableView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataWithflag:1];
        [self.tableView.header endRefreshing];
    }];
    //上来加载更多
    self.tableView.footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        [self addMoreHotstatus];
        [self.tableView.footer endRefreshing];
    }];
    [self.tableView setSeparatorColor:[UIColor colorWithHex:@"#EAEAEA"]];
    [self initSubViews];
    [self loadDataWithflag:0];


}
-(void) initSubViews
{
    scrollPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
    scrollPanel.backgroundColor = [UIColor clearColor];
    scrollPanel.alpha = 0;  //完全透明
    [self.view addSubview:scrollPanel];
    
    markView = [[UIView alloc] initWithFrame:scrollPanel.bounds];
    markView.backgroundColor = [UIColor blackColor];
    markView.alpha = 0.0;
    [scrollPanel addSubview:markView];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:scrollPanel.bounds];
    [scrollPanel addSubview:myScrollView];
    myScrollView.pagingEnabled  = YES;
    myScrollView.delegate       = self;
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return shareListArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShareProduction *production  = shareListArray[indexPath.section];
    return production.height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT_SERO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *productionCell = @"productionCell";
    YMProductionCell *cell = [tableView dequeueReusableCellWithIdentifier:productionCell];
    ShareProduction *pro = shareListArray[indexPath.section];
    
    if (cell == nil) {
        cell = [[YMProductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productionCell with:pro];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CGSize detaiSize = [[NSString stringWithFormat:@"%@",pro.descrip] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kWIDTH-75, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    cell.messgeLable.frame = CGRectMake(cell.iconView.tmri_right +10, cell.seperateView.tmri_bottom + 15, detaiSize.width, detaiSize.height);
    
    NSInteger count = pro.imageList.count>9?9:pro.imageList.count;
    [cell.imageArray removeAllObjects];

    int totalloc=3;
    for (int i = 0; i < count; i ++)
    {
        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        CGFloat appvieww=75;
        CGFloat appviewh=75;
        CGFloat margin=10;
        
        CGFloat appviewx=(margin+appvieww)*loc;
        CGFloat appviewy=(margin+appviewh)*row;
        
        TapImageView *tmpView = [[TapImageView alloc] initWithFrame:CGRectMake(appviewx, appviewy, appvieww, appviewh)];
        tmpView.t_delegate = self;
        SharePicture *picture =  pro.imageList[i];
        [tmpView sd_setImageWithURL:[NSURL URLWithString:picture.imageUrl] placeholderImage:carPlaceHolder];
        tmpView.tag = 10 + i;
        [cell.imageArray addObject:tmpView];
    }
    cell.backView.MinX = cell.iconView.tmri_right + 10;
    cell.backView.tmri_width =(75 + 10) *3 -10;
    cell.backView.tmri_height =pro.imageHeight;
    if (pro.descrip.length) {
        cell.backView.tmri_top = cell.messgeLable.tmri_bottom +15;
    }else{
        cell.backView.tmri_top = cell.seperateView.tmri_bottom +15;
    }
    cell = [cell configWithMode:pro];
    
    cell.stateLable.hidden = YES;
    return cell;
}
-(void)rightTopClick
{
    if (![YMInfoCenter userID]) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"请登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消", nil];
        [alterView show];
        return;
    }
    TreasureViewController *controller = [[TreasureViewController alloc] init];
    controller.titleName = @"我的晒单";
    controller.ishidenTabar = YES;
    controller.isHiden = !self.isHiden;
    controller.uid = [YMInfoCenter userID];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
-(void)loadDataWithflag:(NSInteger)index
{
    [self initSubViews];

    NSInteger shareStart;
    if (index == 0) {//
        if (!self.isFirst) {
            shareStart = self.shareStart;
            self.isFirst = YES;
        }else{
            shareStart = ++self.shareStart;
            self.isfirstLoad = NO;

        }
    }else{
      shareStart = self.shareStart; 
    }
    if (!self.isfirstLoad) {
        [self.view makeToastActivity:kLoadingText];
        self.isfirstLoad = YES;
    }
    SAFE;
    [[TreasureManager  sharedManager] treasureStatusWithUid:self.uid andGid:self.gid andPage:shareStart andflag:index  completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];
        if (statusCode == 0) {
            TreasureResult *trea = result;
            if (index == 0) {//加载
                for (ShareProduction *production in trea.shareList) {
                    NSInteger  height =  [self calculateTheHeightWith:production];
                    production.height = height + 108;
                }
                [shareListArray addObjectsFromArray:trea.shareList];

                if (trea.shareList.count == 0) {
                    weakSelf.tableView.footer = nil;
//                    [weakSelf.view makeToast:@"加载完毕"];

                }
                if (trea.shareList.count == 0&&shareListArray.count == 0) {
                    [weakSelf.view addSubview:weakSelf.notiView];
                }
            }else{//
                
                [shareListArray removeAllObjects];
                [TreasureFrameArray removeAllObjects];
                for (ShareProduction *production in trea.shareList) {

                    [shareListArray addObject:production];
                    NSInteger  height =  [self calculateTheHeightWith:production];
                    production.height = height + 113;

                    }

            }
                [self.tableView reloadData];
        }else
        {
        [weakSelf.view makeToast:msg];
        }
    }];
}
-(void)addMoreHotstatus
{
    [self loadDataWithflag:0];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
        [tabbar setSelectedIndex:4];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(NSInteger)calculateTheHeightWith:(ShareProduction *)production
{
    CGSize detailSize = CGSizeMake(0, 0);
    
    if (production.descrip.length != 0) {
        detailSize = [[NSString stringWithFormat:@"%@",production.descrip] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kWIDTH-75, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    
    NSInteger imageNumber = production.imageList.count;
    
    NSInteger detailHeight = detailSize.height;
    int totalloc=3;
    int row;
    for (int i = 0; i <imageNumber; i ++)
    {
        row=i/totalloc;//行号
    }
    NSInteger rows;
    if (imageNumber == 0) {
        rows =0;
    }else{
        if (imageNumber <= 3) {
            rows =1;
        }else if (imageNumber<=6){
            rows = 2;
        }else{
            rows = 3;
        }
    }
    NSInteger imageheight;
    if (imageNumber == 0) {
        imageheight = 0;
    }else{
        imageheight  = rows *(photoMagin + photoWidth) - photoMagin;
    }
    production.imageHeight = imageheight;
    NSInteger totalHeight =  detailHeight  +imageheight;
    
    if (production.descrip.length == 0) {
        totalHeight = totalHeight - 15;
    }
    
    if (production.imageList.count == 0) {
        totalHeight = totalHeight - 15;
    }
    return totalHeight;
}

#pragma mark - custom delegate
- (void) tappedWithObject:(id)sender
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    if (!self.ishidenTabar) {
        AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
        [tabbar.tabBar setHidden:YES];
    }
//    [UIApplication sharedApplication] setta
    [self.view bringSubviewToFront:scrollPanel];

    scrollPanel.alpha = 1.0;
    TapImageView *tmpView = sender;
    currentIndex = tmpView.tag - 10;
    
    tapCell = (YMProductionCell *)[[[tmpView superview] superview] superview];
    
    //转换后的rect
    CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
    
    CGPoint contentOffset = myScrollView.contentOffset;
    contentOffset.x = currentIndex*kWIDTH;
    myScrollView.contentOffset = contentOffset;
    
    //添加
    [self addSubImgView];
    
    ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){contentOffset,myScrollView.bounds.size}];
    [tmpImgScrollView setContentWithFrame:convertRect];
    [tmpImgScrollView setImage:tmpView.image];
    [myScrollView addSubview:tmpImgScrollView];
    tmpImgScrollView.i_delegate = self;
    
    [myScrollView setContentSize:CGSizeMake(kWIDTH * tapCell.imageArray.count, kHEIGHT)];

    [self performSelector:@selector(setOriginFrame:) withObject:tmpImgScrollView afterDelay:0.1];
}
#pragma mark - custom method
- (void) addSubImgView
{
    for (UIView *tmpView in myScrollView.subviews)
    {
        [tmpView removeFromSuperview];
    }
    
    for (int i = 0; i < tapCell.imageArray.count; i ++)
    {
        if (i == currentIndex)
        {
            continue;
        }
        
//        TapImageView *tmpView = (TapImageView *)[tapCell viewWithTag:10 + i];
        TapImageView *tmpView=  (TapImageView *) tapCell.imageArray[i];
        
        //转换后的rect
        CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
        
        ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){i*myScrollView.bounds.size.width,0,myScrollView.bounds.size}];
        
        
        ImgScrollView *tmpImgScrollViww = [[ImgScrollView alloc] initWithFrame:(CGRect){i*myScrollView.bounds.size.width,0,myScrollView.bounds.size}];

        [tmpImgScrollView setContentWithFrame:convertRect];
        [tmpImgScrollView setImage:tmpView.image];
        [myScrollView addSubview:tmpImgScrollView];
        tmpImgScrollView.i_delegate = self;
        
        [tmpImgScrollView setAnimationRect];
    }
}
- (void) setOriginFrame:(ImgScrollView *) sender
{
    [UIView animateWithDuration:0.4 animations:^{
        [sender setAnimationRect];
        markView.alpha = 1.0;
    }];
}
- (void) tapImageViewTappedWithObject:(id)sender
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];

    if (!self.ishidenTabar) {
        AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
        [tabbar.tabBar setHidden:NO];
    }
    ImgScrollView *tmpImgView = sender;
    
    [UIView animateWithDuration:0.5 animations:^{
        markView.alpha = 0;
        [tmpImgView rechangeInitRdct];
    } completion:^(BOOL finished) {
        scrollPanel.alpha = 0;
    }];
    
}
#pragma mark ---夺宝---
-(void)duobao:(id) sener
{
//    AppDelegate
    AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
    [tabbar setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
