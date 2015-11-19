//
//  YMShaiDanViewController.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/5.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMShaiDanViewController.h"
#import "GridView.h"
#import "YMAlerInfoView.h"
#import "YMTabBarController.h"
#import "AppDelegate.h"
#import "ELCImagePickerHeader.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "TapImageView.h"
#import "ImgScrollView.h"
#define maxLength 140
@interface YMShaiDanViewController ()<UITextViewDelegate,YMAlertViewDelegate,GridViewDelegate,ELCImagePickerControllerDelegate,UIScrollViewDelegate,ImgScrollViewDelegate>
{
    UIScrollView  *myScrollView;
    UIView          *scrollPanel;
    UIView          *markView;
    NSInteger       currentIndex;
    __block NSMutableArray  *m_arrayObjects; //里头存储的可能是图片也可能是url
}
@property(nonatomic,strong)UITextView *textDes;
@property(nonatomic,strong)GridView   *gridView;
@property(nonatomic,strong)NSArray    *imgArray;
@property(nonatomic,strong)UIScrollView *scrollview;
@end

@implementation YMShaiDanViewController
-(instancetype)initWithImageArray:(NSArray *)imgArray
{
   self =  [self init];
    _imgArray = imgArray;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"晒单";
    self.view.backgroundColor = kViewControllerBackgroundColor;
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - kNav)];
    [self.view addSubview:_scrollview];
    _textDes = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, kWIDTH - 10*2, 100)];
    _textDes.text = @"分享这一刻的想法....";
    _textDes.backgroundColor = [UIColor clearColor];
    _textDes.delegate = self;
    _textDes.font = [UIFont systemFontOfSize:16.0];
    _textDes.textColor = [UIColor heightBlacKColor];
    _gridView = [[GridView alloc] initWithFrame:CGRectMake(0, _textDes.tmri_bottom + 5, kWIDTH , 20) title:_imgArray];
    _gridView.delgate  = self;
    _gridView.max = 9;
    _gridView.backgroundColor = [UIColor clearColor];
    [self.scrollview addSubview:_textDes];
    [self.scrollview addSubview:_gridView];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancell:)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send:)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;
    self.scrollview.contentSize = CGSizeMake(kWIDTH, self.gridView.tmri_bottom + 20);
    [self initSubViews];
    // Do any additional setup after loading the view.
}
#pragma mark ----
-(void) initSubViews
{
    scrollPanel = [[UIView alloc] initWithFrame:self.view.bounds];
    scrollPanel.backgroundColor = [UIColor clearColor];
    scrollPanel.alpha = 0;  //完全透明
    [self.view addSubview:scrollPanel];
    
    markView = [[UIView alloc] initWithFrame:scrollPanel.bounds];
    markView.backgroundColor = [UIColor blackColor];
    markView.alpha = 0.0;
    [scrollPanel addSubview:markView];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollPanel addSubview:myScrollView];
    myScrollView.pagingEnabled  = YES;
    myScrollView.delegate       = self;
}

-(void) cancell:(id) sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
//发布晒单
-(void) send:(id) sender
{
    [_textDes resignFirstResponder];
    if (_gridView.curTotal <= 0) {
        [self.view makeToast:@"晒单前,请选择图片"];
        return;
    }
    if (_textDes.text.length > maxLength) {
        [self.view makeToast:@"您输入的内容长度应该在120个字之间"];
        return;
    }
    if ([_textDes.text isEqualToString:@"分享这一刻的想法...."]) {
        [self.view makeToast:@"请输入描述"];
        return;
    }
    NSString *description = _textDes.text;
    YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
    NSNumber *uid = [NSNumber numberWithInteger:[infoCenter getUserID]];
    NSMutableDictionary *dict  = [BaseParamDic baseParam];
    [dict setObject:uid forKey:@"uid"];
    [dict setObject:description forKey:@"description"];
    [dict setObject:self.gsid forKey:@"gsid"];
    [dict setObject:self.grid forKey:@"grid"];
    CGSize imagesize = CGSizeMake(200, 200);
    //图片数组
    NSMutableArray *imgArray = _gridView.imageArray;
    //二进制数组
    NSMutableArray *imgDataArray = [[NSMutableArray alloc]init];
    for (int i =0;i<imgArray.count  ;i++) {
        UIImageView *imgView  = imgArray[i];
        UIImage *imageNew = [self imageWithImage:imgView.image scaledToSize:imagesize];
        NSData *imageData = UIImageJPEGRepresentation(imageNew,0.5);
//        NSData *imageData = UIImageJPEGRepresentation(img,1);
        
        [imgDataArray addObject:imageData];
//        i++;
    }

    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/share/add"];
    WEAKSELF;
    [self.view makeToastActivity:kLoadingText];

    [YMBaseHttpTool POST:url params:dict name:@"_shareImage" data:imgDataArray success:^(id result) {
        [weakSelf.view hideToastActivity];

        NSLog(@"上传成功");
        [weakSelf.view hideToastActivity];
        YMAlerInfoView *alerInfo  =[[YMAlerInfoView alloc] initWithFrame:weakSelf.view.bounds title:@"您的晒单已经提交审核" buttonTitle:@"去夺宝圈看看"];
        alerInfo.deleagte = weakSelf;
        [[NSNotificationCenter  defaultCenter] postNotificationName:ReceiveList object:nil];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (!window) {
            window=[[UIApplication sharedApplication].windows objectAtIndex:0];
        }
        [[[window subviews] objectAtIndex:0] addSubview:alerInfo];

        
    } failure:^(NSError *error) {
        [weakSelf.view hideToastActivity];

        
    } uploadProgressBlock:^(float uploadPercent, long long totalBytesWritten, long long totalBytesExpectedToWrite)
     {
         CGPoint center = self.view.center;
         NSUInteger percenet = uploadPercent * 100;
         NSValue *point = [NSValue valueWithCGPoint:center];
         [weakSelf.view makeToastActivity:[NSString stringWithFormat:@"%ld%@",percenet,@"%"] position:point];
    }];
}
//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
#pragma mark ----textViewDelegate--
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSString *desc  = textView.text;
    if ([desc isEqualToString:@"分享这一刻的想法...."]) {
        _textDes.text  = nil;
    }
    return YES;
}
#pragma mark ---YMAlertinfoDelegate----
-(void)clickBtnAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *deleagte = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YMTabBarController *tabar = (YMTabBarController *)deleagte.window.rootViewController;
    [tabar setSelectedIndex:2];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)addBtnAction:(id)sender
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
    [_gridView addArray:images];
    self.scrollview.contentSize =CGSizeMake(kWIDTH, _gridView.tmri_bottom);
}

-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----GridViewDelegate--
-(void)didSelectGridViewAtIndex:(NSUInteger)index
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view bringSubviewToFront:scrollPanel];
    scrollPanel.alpha = 1.0;
    currentIndex    = index;
    UIImageView *tmpView = _gridView.imageArray[index];
    //转换后的rect
    //讲tmpView  的rect 由tmpView所在的父视图 转化到当前视图上
    CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
    
    CGPoint contentOffset       = myScrollView.contentOffset;
    contentOffset.x             = currentIndex * kWIDTH;
    myScrollView.contentOffset  = contentOffset;
    
    //添加
    [self addSubImgView];
    
    ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){contentOffset,myScrollView.bounds.size}];
    [tmpImgScrollView setContentWithFrame:convertRect];
    [tmpImgScrollView setImageOrUrl:tmpView];
    [myScrollView addSubview:tmpImgScrollView];
    tmpImgScrollView.i_delegate = self;
    //设置cententSize
    
    [myScrollView setContentSize:CGSizeMake(kWIDTH * _gridView.imageArray.count, kHEIGHT)];
    
    [self performSelector:@selector(setOriginFrame:) withObject:tmpImgScrollView afterDelay:0.1];
}

- (void)tapImageViewTappedWithObject:(id)sender
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    ImgScrollView *tmpImgView = sender;
    
    [UIView animateWithDuration:0.5 animations:^{
        markView.alpha = 0;
        [tmpImgView rechangeInitRdct];
    } completion:^(BOOL finished)
     {
         if(finished)
         {
             scrollPanel.alpha = 0;
             [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
         }
     }];
}

- (void)setOriginFrame:(ImgScrollView *) sender
{
    [UIView animateWithDuration:0.4 animations:^{
        [sender setAnimationRect];
        markView.alpha = 1.0;
    }];
}

//
- (void)addSubImgView
{
    for (UIView *tmpView in myScrollView.subviews)
    {
        [tmpView removeFromSuperview];
    }
    
    
    for (int i = 0; i < _gridView.imageArray.count; i ++)
    {
        if(i == currentIndex) continue;
        
        UIImageView *tmpView  = _gridView.imageArray[i];
        //转换后的rect
//        CGRect convertRect     = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
        CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
        ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){i*myScrollView.bounds.size.width,0,myScrollView.bounds.size}];
        [tmpImgScrollView setContentWithFrame:convertRect];
        [tmpImgScrollView setImageOrUrl:[_gridView.imageArray objectAtIndex:i]];
        [myScrollView addSubview:tmpImgScrollView];
        tmpImgScrollView.i_delegate = self;
        [tmpImgScrollView setAnimationRect];
    }
}
@end
