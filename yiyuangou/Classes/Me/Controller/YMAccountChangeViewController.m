//
//  YMAccountChangeViewController.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMAccountChangeViewController.h"
//#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#define kAccountTag 201
#define kNickTag 202
#define kSaveBtn 203
#define kUId     204
#define ORIGINAL_MAX_WIDTH 640.0f
#define KMAXLength 12
@interface YMAccountChangeViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) UITableView *mainTableview;
@property(nonatomic,strong) UILabel *account;
@property(nonatomic,strong) UITextField *nickName;
@property(nonatomic,strong) UIImageView *iconeImage;
@property(nonatomic,strong) UIView      *footView;
@property(nonatomic,strong) NSArray     *items;
@property(nonatomic,strong) UIButton    *saveBtn;
@property(nonatomic,strong) UILabel     *uid;
@end

@implementation YMAccountChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewControllerBackgroundColor;
    self.title =  @"个人信息";
    self.items = @[@"账户",@"昵称",@"用户ID"];
    [self initView];
    self.mainTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH,kHEIGHT - kNav) style:UITableViewStylePlain];
    self.mainTableview.backgroundColor = [UIColor clearColor];
//    self.mainTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.mainTableview.delegate = self;
    self.mainTableview.dataSource = self;
    [self.view addSubview:self.mainTableview];
    //去除多余分割线
    [self.mainTableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self rightItem];
    // Do any additional setup after loading the view.
}
-(void) rightItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItem =  rightItem;
}
-(void) initView
{
    self.iconeImage = [[UIImageView alloc] init];
    
    self.iconeImage.frame =  CGRectMake(kWIDTH - 70, 5, 50, 50);
    self.iconeImage.layer.cornerRadius  = self.iconeImage.height/2.0;
    [self.iconeImage.layer setMasksToBounds:YES];
    [_iconeImage.layer setMasksToBounds:YES];
    [_iconeImage setContentMode:UIViewContentModeScaleAspectFill];
    [_iconeImage setClipsToBounds:YES];
    
    YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
    YMUser *mainUser = infoCenter.mainUser;
    NSString *headUrl = mainUser.YMUserAvatarURL;
    NSData *imgData =  mainUser.YMUserHeaderImg;
    if (imgData == nil) {
        [self.iconeImage sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:carPlaceHolder];
    }
    else
        self.iconeImage.image = [UIImage imageWithData:imgData];

     self.iconeImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(editPortait:)];
//    [self.iconeImage addGestureRecognizer:tap];
    
    self.nickName = [[UITextField alloc]init];
    self.nickName.frame = CGRectMake(kWIDTH - 240, 5, 220, 30);
    self.nickName.textAlignment = NSTextAlignmentRight;
    self.nickName.text = mainUser.YMNickName;
    self.nickName.tag =  kNickTag;
    self.nickName.font = [UIFont systemFontOfSize:16.0];
    self.nickName.textColor = [UIColor heightBlacKColor];
    //昵称
    UIView *nickNameView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    
    UIButton *okbuttongNickName=[[UIButton alloc]initWithFrame:CGRectMake(kWIDTH - 50-20, 0, 50, 30)];
    [okbuttongNickName setTitle:@"确定" forState:UIControlStateNormal];
    [okbuttongNickName addTarget:self action:@selector(okbuttongTouched:) forControlEvents:UIControlEventTouchUpInside];
    [nickNameView addSubview:okbuttongNickName];
    nickNameView.backgroundColor=[UIColor lightGrayColor];
    //账户信息
    self.account = [[UILabel alloc]init];
    self.account.text = mainUser.YMAccount;
    self.account.tag = kAccountTag;
    self.account.frame = CGRectMake(kWIDTH - 200, 5, 180, 30);
    self.account.textAlignment = NSTextAlignmentRight;
    self.account.font  = [UIFont systemFontOfSize:16.0];
    self.account.textColor = [UIColor heightBlacKColor];
    //用户ID
    self.uid = [[UILabel alloc]init];
    self.uid.text = [NSString stringWithFormat:@"%ld",[YMInfoCenter userID]];
    self.uid.tag = kUId;
    self.uid.frame = CGRectMake(kWIDTH - 200, 5, 180, 30);
    self.uid.textAlignment = NSTextAlignmentRight;
    self.uid.font  = [UIFont systemFontOfSize:16.0];
    self.uid.textColor = [UIColor heightBlacKColor];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 110)];
    self.saveBtn = [[UIButton alloc] init];
    self.saveBtn.frame =  CGRectMake(10, 10, kWIDTH - 20, 30);
    self.saveBtn.tag = kSaveBtn;
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.saveBtn.backgroundColor  = [UIColor  colorWithHex:@"#DD2727"];
    [self.saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark ---dataSource--------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 ) {
        return 1;
    }
    else
        return self.items.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    else
        return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 70;
    }
    else if(indexPath.section == 1)
    {

        return 43;
    }
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        static NSString *identifier1 = @"cell1";
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 50)];
        desc.text = @"头像";
        [cell.contentView addSubview:desc];
        [cell.contentView addSubview:self.iconeImage];
    }
    else
    {
        static NSString *identider2 = @"cell2";
        cell = [tableView dequeueReusableCellWithIdentifier:identider2];
        if (cell == nil) {
            cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identider2];
        }
        cell.textLabel.text = self.items[indexPath.row];
        if (![cell.contentView viewWithTag:kAccountTag] && indexPath.row == 0) {
            [cell.contentView addSubview:self.account];
        }
        if (![cell.contentView viewWithTag:kNickTag] && indexPath.row == 1) {
            [cell.contentView addSubview:self.nickName];
        }
        if (![cell.contentView viewWithTag:kNickTag] && indexPath.row == 2) {
            [cell.contentView addSubview:self.uid];
        }
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.textColor = [UIColor heightBlacKColor];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return [[UIView alloc] initWithFrame:CGRectZero];
//    }
//    else
//    return self.footView;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 0.001;
//    }
//    else
//    return 110;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        //选择头像
        [_nickName resignFirstResponder];
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"拍照", @"从相册中选取", nil];
        [choiceSheet showInView:self.view];

    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        [_nickName becomeFirstResponder];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---回收键盘--
-(void)okbuttongTouched:(id)sender
{
    [_nickName resignFirstResponder];
}
#pragma mark ---保存----
-(void)saveAction:(id) sender
{

    NSString *str = @"/user/updateInfo";
    NSString *nickName = [self.nickName.text trim];
    if (![nickName isValidNickName]) {
        [self.view makeToast:@"用户昵称需在1-12位之间"];
        return;
    }
//    nickName  = @"\xF0\x9F\x94\x94";

    NSMutableDictionary *dict  = [BaseParamDic baseParam];
    //判断电话是否正确
    [dict setValue:nickName forKey:@"sname"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,str];
//    NSArray *dataArray = @[UIImageJPEGRepresentation(self.iconeImage.image, 0.5)];
    NSArray *dataArray = @[UIImageJPEGRepresentation([self.iconeImage.image fixOrientation], 0.5)];

    WEAKSELF;
    [self.view makeToastActivity:kLoadingText];
    [YMBaseHttpTool POST:url params:dict name:@"_face" data:dataArray success:^(id result) {
        NSDictionary *dict = [result keyValues];
        [weakSelf.view hideToastActivity];
        YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
        YMUser *mainUser = infoCenter.mainUser;
        mainUser.YMNickName = nickName;
        mainUser.YMUserHeaderImg = UIImageJPEGRepresentation(self.iconeImage.image, 0.5);
        mainUser.YMUserAvatarURL = dict[@"data"][@"face"];
        [[NSNotificationCenter defaultCenter] postNotificationName:ymNotificationRefreshUserInfo object:nil userInfo:@{@"type":@"changeAccount"}];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [weakSelf.view makeToast:@"个人信息更新失败"];
        
    } uploadProgressBlock:^(float uploadPercent, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    }];

}
#pragma mark ---actionSheetDeleagte
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
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
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
//        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
//        imgEditorVC.delegate = self;
//        [self presentViewController:imgEditorVC animated:YES completion:^{
//            // TO DO
//        }];
        self.iconeImage.image = portraitImg;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}
#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}
- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}
#pragma mark camera utility
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
