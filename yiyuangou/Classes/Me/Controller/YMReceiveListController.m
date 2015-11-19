//
//  YMReceiveListController.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMReceiveListController.h"
#import "YMRecievedCell.h"
#import "YMAcceptViewController.h"
#import "YMCreatePlaceController.h"
#import "YMLoginViewController.h"
#import "YMRegisterViewController.h"
#import "ELCImagePickerHeader.h"
#import "YMShaiDanViewController.h"
#import "YMNoDataView.h"
#import <MobileCoreServices/UTCoreTypes.h>

typedef NS_ENUM(NSUInteger,RefreshType)
{
    AddMore,
    Refresh
};

@interface YMReceiveListController()<UITableViewDataSource,UITableViewDelegate,YMReciveCellDelegate,ELCImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    UIView *headView;
}
@property (nonatomic,strong)UITableView *tableView;
@property  (nonatomic,strong)YMNoDataView *notiView;
@property(nonatomic,strong) NSMutableArray *rewardList;
@property(nonatomic,strong) UILabel *headLable;
@property(nonatomic,strong) NSDictionary *shaiDanDic;
@property(nonatomic,assign) NSUInteger refreshIndex;
@property(nonatomic,assign) NSUInteger addMoreIndex;
@end

@implementation YMReceiveListController
-(YMNoDataView *)notiView
{
    if (_notiView == nil) {
        UIImage *img = [UIImage imageNamed:@"noData"];
        _notiView  = [[YMNoDataView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64 -30)  title:@"暂无记录" image:img];
        _notiView.hidden = YES;
    }
    return _notiView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _refreshIndex = 0;
    _addMoreIndex = 1;
    _rewardList = [[NSMutableArray alloc] init];
    self.title = @"中奖记录";
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.view.backgroundColor =[UIColor whiteColor];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
       [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    headView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 30)];
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _headLable = [UILabel labelWithFrame:CGRectMake(15, 0, kWIDTH, 30) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    _headLable.text  =@"恭喜您获得一个宝贝";
    _headLable.backgroundColor  = [UIColor clearColor];
    [headView addSubview:_headLable];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
//    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:ReceiveList object:nil];

    WEAKSELF;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData:Refresh];
        [weakSelf.tableView.header endRefreshing];
    }];
    self.tableView.footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [self loadData:AddMore];
        [self.tableView.footer endRefreshing];
    }];
    [self loadData:Refresh];
//    [self.view addSubview:self.notiView];
// Do any additional setup after loading the view.
}
-(void)refresh
{
    [self loadData:Refresh];
}
-(void) loadData:(RefreshType) type
{
//    rewardList
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/reward/list"];
    WEAKSELF;
    [self.view makeToastActivity:kLoadingText];
    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    //如果刷新
    if (type == Refresh) {
        [dict setValue:[NSNumber numberWithInteger:self.refreshIndex] forKey:@"rewardStart"];
        [dict setValue:[NSNumber numberWithInteger:1] forKey:@"flag"];
    }
    else if (type == AddMore)
    {
        [dict setValue:[NSNumber numberWithInteger:self.addMoreIndex] forKey:@"rewardStart"];
        [dict setValue:[NSNumber numberWithInteger:0] forKey:@"flag"];
    }
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        [weakSelf.view hideToastActivity];

        NSDictionary *dict = [result keyValues];
        if([dict[@"code"] integerValue] == 0)
        {
            if (type == Refresh) {
                [weakSelf.rewardList removeAllObjects];
                NSArray *tmpArray =  dict[@"data"][@"rewardList"];
                if (tmpArray.count == 0) {
                    weakSelf.notiView.hidden  = NO;
                    [weakSelf.view addSubview:weakSelf.notiView];

                }
                else
                {
                 [weakSelf.rewardList addObjectsFromArray:tmpArray];
                 if (weakSelf.notiView.superview != nil)
                 {
                        [weakSelf.notiView removeFromSuperview];
                    }
                    weakSelf.headLable.text = [NSString stringWithFormat:@"%@%ld%@",@"恭喜您获得",(unsigned long)weakSelf.rewardList.count,@"个宝贝"];
                    [weakSelf.tableView reloadData];
                }
            }
            else if(type == AddMore)
            {
                NSArray *tmpArray =  dict[@"data"][@"rewardList"];
                if (tmpArray.count == 0) {
                    weakSelf.tableView.footer = nil;
                }
                else
                {
                    [weakSelf.rewardList addObjectsFromArray:tmpArray];
                    self.refreshIndex = self.addMoreIndex;
                    self.addMoreIndex ++;
                    weakSelf.headLable.text = [NSString stringWithFormat:@"%@%ld%@",@"恭喜您获得",(unsigned long)weakSelf.rewardList.count,@"个宝贝"];
                    [weakSelf.tableView reloadData];
                }
            }
        }
        [weakSelf.view hideToastActivity];

    } failure:^(NSError *error) {
        [weakSelf.view hideToastActivity];

    }];
}
-(void) addMore
{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rewardList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return headView;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reciveCell = @"reciveCell";
    NSDictionary *dict = self.rewardList[indexPath.row];
    YMRecievedCell *cell = [tableView dequeueReusableCellWithIdentifier:reciveCell];
    if (cell == nil) {
        cell = [[YMRecievedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reciveCell];
    }
    cell.delegate = self;
    cell = [cell congfigWithModle:dict];
    cell.selectionStyle  = UITableViewCellAccessoryNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//领奖
-(void)reciviceButtonAction:(YMRecievedCell *)cell
{
    NSIndexPath *indexPath =  (NSIndexPath *)[self.tableView indexPathForCell:cell];
    NSUInteger index = indexPath.row;
    NSDictionary *dict = self.rewardList[index];
    //已经收集的登录且有地址
    YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
    YMUser       *mainUser = infoCenter.mainUser;
    //暂时设置account == mobile相等
    mainUser.YMUserMobile = mainUser.YMUserMobile;
    //如果是手机登录
    if ([mainUser.YMAccount isValid]) {
        //如果是手机登录无地址

            YMAcceptViewController *acceptAddress  = [[YMAcceptViewController alloc] init];
            acceptAddress.type = YMRewardList;
            acceptAddress.rewardDic = dict;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:acceptAddress animated:YES];
    }
    //第三方登录未绑定手机
    else
    {
        YMRegisterViewController *regist = [[YMRegisterViewController alloc] init];
        regist.titleName = @"绑定手机";
        regist.method = YMBindPhone;
        regist.rewardDic = dict;
        self.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:regist animated:YES];
    }
}
//晒单
-(void)displayButtonAction:(YMRecievedCell *)cell
{
    
    NSIndexPath *indexPath =  (NSIndexPath *)[self.tableView indexPathForCell:cell];
    NSUInteger index = indexPath.row;
    self.shaiDanDic = self.rewardList[index];
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照 ",@"从相册中选取", nil];
    choiceSheet.delegate = self;
    [self.view addSubview:choiceSheet];
    [choiceSheet showInView:self.view];
}
//选择图片
-(void) selectPicFromAlbum
{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 9; //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
    
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}
#pragma mark   -----------------UIActionSheetDelgate---
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //拍照
    if (buttonIndex == 0) {
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc]init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];

        }
    }
    //从相册中选择
    else if(buttonIndex == 1)
    {
        [self selectPicFromAlbum];
    }
}
#pragma mark   -----------------图片选择器Delegate-------
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];

    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];

                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
                [imageview setContentMode:UIViewContentModeScaleAspectFit];

             }
            else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                [images addObject:image];
                
                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
                [imageview setContentMode:UIViewContentModeScaleAspectFit];

                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    if (images.count == 0) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [images addObject:[UIImage imageNamed:@"add"]];
    YMShaiDanViewController *shanDanVC = [[YMShaiDanViewController alloc]initWithImageArray:images];
    shanDanVC.gsid = self.shaiDanDic[@"gsid"];
    shanDanVC.grid = self.shaiDanDic[@"grid"];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:shanDanVC];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma --------摄像头相关-----------------
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
#pragma mark   -----------------UIImagePickerViewDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSMutableArray *images = [[NSMutableArray alloc]init];
        [images addObject:portraitImg];
        [images addObject:[UIImage imageNamed:@"add"]];
        YMShaiDanViewController *shanDanVC = [[YMShaiDanViewController alloc]initWithImageArray:images];
        shanDanVC.gsid = self.shaiDanDic[@"gsid"];
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:shanDanVC];
        [self presentViewController:controller animated:YES completion:nil];

//        portraitImg = [self imageByScalingToMaxSize:portraitImg];
//        // 裁剪
//        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
//        imgEditorVC.delegate = self;
//        [self presentViewController:imgEditorVC animated:YES completion:^{
//            // TO DO
//        }];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

-(void)dealloc
{
    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark   -----------------晒单管理------------------

@end
