//
//  YMLoginViewController.m
//  yiyuangou
//
//  Created by roen on 15/10/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMLoginViewController.h"
#import "MySettingViewController.h"
#import "YMLoginCell.h"
#import "YMInfoCenter.h"
#import "YMRegisterViewController.h"
#import "LoginManager.h"
#import "YMLoginModel.h"
#import "YMLoginResult.h"
#import "MyMD5.h"
#import  <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import "WXApiRequestHandler.h"
#import "WXApi.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialAccountManager.h"
#import "YMTextFild.h"
#import "YMSetPassWordController.h"
#import <BaiduMapAPI_Base/BMKUserLocation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import "YMIPHelper.h"
#import "YMTextFieldInputHandle.h"
@interface YMLoginViewController()<UITextFieldDelegate,TencentSessionDelegate,BMKLocationServiceDelegate,BMKGeneralDelegate,BMKGeoCodeSearchDelegate>
{
    YMTextFild *telephoneFiled;
    YMTextFild *passwordFiled;
    UIView *footerView;
    YMLoginResult *loginresult;
    BMKGeoCodeSearch* _geocodesearch;
    NSString    *usrLoginAddress;//用户登录地址
    NSString    *IP;

}
@property(nonatomic,strong) BMKLocationService  *locServicse;
@end
@implementation YMLoginViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
//    [self initBMK];
    IP = [YMIPHelper deviceIPAdress];
    YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
    YMUser       *mainUser = infoCenter.mainUser;
    self.view.backgroundColor = kViewControllerBackgroundColor;
    //账户
    UIImageView *phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    phoneImg.image = [UIImage imageNamed:@"phone"];
    telephoneFiled = [[YMTextFild alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 40)];
    telephoneFiled.keyboardType = UIKeyboardTypeNumberPad;
    telephoneFiled.placeholder = @"请输入手机号码";
    telephoneFiled.clearButtonMode = YES;
    telephoneFiled.returnKeyType = UIReturnKeyDone;
    telephoneFiled.delegate = self;
    telephoneFiled.leftView  = phoneImg;
    telephoneFiled.leftViewMode = UITextFieldViewModeAlways;
    telephoneFiled.leftView = phoneImg;
    telephoneFiled.leftViewMode = UITextFieldViewModeAlways;
    [telephoneFiled setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [telephoneFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    telephoneFiled.text = mainUser.YMUserMobile;
    //密码
    passwordFiled = [[YMTextFild alloc] initWithFrame:CGRectMake(0, 0, kWIDTH , 40)];
    passwordFiled.keyboardType = UIKeyboardTypeASCIICapable;
    passwordFiled.placeholder = @"请输入密码";
    passwordFiled.clearButtonMode = YES;
    passwordFiled.delegate = self;
    passwordFiled.secureTextEntry=YES;
    passwordFiled.text = mainUser.YMUserPassword;
    
    UIImageView *CodeImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    CodeImg.image = [UIImage imageNamed:@"code"];
    passwordFiled.leftView = CodeImg;
    passwordFiled.leftViewMode = UITextFieldViewModeAlways;
    [passwordFiled setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self leftItem];
    [self creatFooterView];
    [self.view addTap];
    
}
//leftBarButton
-(void) leftItem
{
    UIBarButtonItem *leftItem  =[[ UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancellAction:)];
    self.navigationItem.leftBarButtonItem =  leftItem;
}
-(void)cancellAction:(id) sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 61;
    }
    return 41;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return footerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row !=2) {
        static NSString *loglinCell = @"loglinCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loglinCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loglinCell];
        }
        if (indexPath.row == 0) {
            [cell.contentView addSubview:telephoneFiled];
        }else if (indexPath.row == 1){
            [cell.contentView addSubview:passwordFiled];
        }
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;;

        return cell;

    }else{
        static NSString *tableviewCell = @"tableviewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableviewCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableviewCell];
        }
        UIButton *loginButton = [UIButton buttonWithFrame:CGRectMake(10, 10, kWIDTH -20, 40) target:self action:@selector(loginButtonClick) title:@"登录" cornerRadius:1];
        loginButton.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:loginButton];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;;
        return cell;
    }
    return nil;
}
-(void)loginButtonClick
{

    YMLoginModel *model = [[YMLoginModel alloc] init];
    model.mobile = telephoneFiled.text;
    model.password =[MyMD5 md5:passwordFiled.text];
    model.flag = @"1";
    model.address = usrLoginAddress;
    model.IP =  IP;
    
    YMInfoCenter *info =  [YMInfoCenter sharedManager];
    YMUser      *mainUsr =  info.mainUser;
    mainUsr.YMAccount = model.mobile;
    [info saveUserAccount];
    
    if (![[telephoneFiled.text trim] isValidPhoneNumber]) {
        [self.view makeToast:@"请输入正确的手机号码"];
        return;
    }
    if(![[passwordFiled.text trim] isValidPassword])
    {
        [self.view makeToast:[NSString stringWithFormat:@"账户密码应在6-12位之间"]];
        return;
    }
    [self.view makeToastActivity:kLoadingText];
    WEAKSELF;
    [[LoginManager sharedManager] LoginStatusWithModle:model completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];
        if (statusCode == 0) {
            loginresult = result;
            [MobClick profileSignInWithPUID:[NSString stringWithFormat:@"%ld",loginresult.uid]];
            [self login];
        }else {
            [weakSelf.view makeToast:@"登录失败"];
  
        }
    }];
//
    NSLog(@"登录");
}
-(void)creatFooterView
{
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 41*3- 10 - kNav )];
    UILabel *registerLable = [UILabel labelWithFrame:CGRectMake(10, 20, 60, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    registerLable.text =@"快速注册";
    registerLable.font = [UIFont systemFontOfSize:14.0];
    registerLable.textColor = [UIColor  colorWithHex:@"#DD2727"];
    registerLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerClick)];
    [registerLable addGestureRecognizer:gesture];
    [footerView addSubview:registerLable];
    
    UILabel *passworldLable = [UILabel labelWithFrame:CGRectMake(kWIDTH - 70, 20, 60, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    passworldLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(passworldClick)];
    [passworldLable addGestureRecognizer:gesture1];
    passworldLable.text =@"忘记密码";
    passworldLable.font = [UIFont systemFontOfSize:14.0];
    passworldLable.textColor = [UIColor  colorWithHex:@"#DD2727"];
    [footerView addSubview:passworldLable];
//    footerView.backgroundColor = [UIColor redColor];
    UIView *subView = [self thirdPartyLogin];
    [footerView addSubview:subView];
    self.tableView.tableFooterView =  footerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)registerClick{
    
    YMRegisterViewController *controller = [[YMRegisterViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    controller.titleName =@"注册";
    controller.isFromLogin = YES;
    controller.method = YMRegistUser;
    [self.navigationController pushViewController:controller animated:YES];

}
-(void)passworldClick
{
    YMRegisterViewController *controller = [[YMRegisterViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    controller.titleName =@"忘记密码";
    controller.method = YMRestPhone;
    [self.navigationController pushViewController:controller animated:YES];


}
-(void)login
{
    //弹框判断未做;
    YMInfoCenter *info = [YMInfoCenter sharedManager] ;
    info.mainUser.YMUserMobile =telephoneFiled.text;
    info.mainUser.YMUserPassword = telephoneFiled.text;
    info.mainUser.YMUserID= loginresult.uid;
    info.mainUser.YMAddressArray = loginresult.addressList;
    [info saveUserID];
    [MobClick event:ymLogin];
    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_SELF object:nil userInfo:@{@"type":NSStringFromClass([self class])}];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    [self setHidesBottomBarWhenPushed:NO];
//    MySettingViewController *controller = [[MySettingViewController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
}

//第三方登录
-(UIView *) thirdPartyLogin
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, footerView.height - 100, kWIDTH, 100)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor colorWithHex:@"E1E1E1"];
    [view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(22);
        make.size.mas_equalTo(CGSizeMake(kWIDTH - 20*2, 1));
        make.centerX.equalTo(view);
    }];
    UILabel *title =[[UILabel alloc]init];
    title.text = @"第三方登录";
    title.font = [UIFont systemFontOfSize:14];
    title.textColor = [UIColor lightColor];
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.mas_equalTo(15);
    }];

    UIView *btnView = [[UIView alloc]init];
    [view addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(265, 70));
        make.top.equalTo(title.mas_bottom).offset(20);
    }];
    UIButton *wxBtn = [[UIButton alloc]init];
    [wxBtn setBackgroundImage:[UIImage imageNamed:@"wx"] forState:UIControlStateNormal];
    wxBtn.frame = CGRectMake(0, 5, 50, 50);
    wxBtn.layer.cornerRadius =  wxBtn.width/2.0;
    wxBtn.clipsToBounds = YES;
    [wxBtn addTarget:self action:@selector(wxAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *qqBtn = [[UIButton alloc]init];
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    qqBtn.frame = CGRectMake(100, 5, 50, 50);
    qqBtn.layer.cornerRadius =  qqBtn.width/2.0;
    qqBtn.clipsToBounds = YES;
    [qqBtn addTarget:self action:@selector(qqBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *sinaBtn = [[UIButton alloc]init];
    [sinaBtn setBackgroundImage:[UIImage imageNamed:@"wb"] forState:UIControlStateNormal];
    sinaBtn.frame = CGRectMake(200, 5, 50, 50);
    sinaBtn.layer.cornerRadius =  sinaBtn.width/2.0;
    sinaBtn.clipsToBounds = YES;
    [sinaBtn addTarget:self action:@selector(sinaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:wxBtn];
    [btnView addSubview:qqBtn];
    [btnView addSubview:sinaBtn];
    return view;
}
#pragma mark ---QQ登录-----
-(void)qqBtnAction:(id) sender
{

    @try {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            //          获取微博用户名、uid、token等
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
                NSDictionary *loginDic  = @{
                                            @"flag":@"4",
                                            @"sname":snsAccount.userName,
                                            @"loginName":snsAccount.usid
                                            };
                [self thirdPartyLogin:loginDic];
                NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                
            }});
    }
    @catch (NSException *exception) {
     }
    @finally {
    }
    

}
#pragma mark ---微博登录-----
-(void)sinaBtnAction:(id) sender
{
    @try {
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        //登录
        WEAKSELF;
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            //          获取微博用户名、uid、token等
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                NSDictionary *loginDic  = @{
                                            @"flag":@"5",
                                            @"sname":snsAccount.userName,
                                            @"loginName":snsAccount.usid
                                            };
                [weakSelf thirdPartyLogin:loginDic];
                NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                
            }});
    }
    @catch (NSException *exception) {

    }
    @finally {

    }

}
#pragma mark --微信登录-----
-(void)wxAction:(id) sender
{

    WEAKSELF;
    @try {
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
                NSDictionary *loginDic  = @{
                                            @"flag":@"2",
                                            @"sname":snsAccount.userName,
                                            @"loginName":snsAccount.usid
                                            };
                [weakSelf thirdPartyLogin:loginDic];
                NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                
            }
            
        });
    }
    @catch (NSException *exception) {
     }
    @finally {
    }
    


}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self hideTabBar];
//}
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}
#pragma mark ---第三方登录---
-(void) thirdPartyLogin:(NSDictionary *) loginDic
{
    

        YMLoginModel *model = [[YMLoginModel alloc] init];
        model.sname =  loginDic[@"sname"];
        model.flag =  loginDic[@"flag"];
        model.loginName = loginDic[@"loginName"];
        model.address = usrLoginAddress == nil?@"中国":usrLoginAddress;
        model.IP =  IP;
    
        [[LoginManager sharedManager] LoginStatusWithModle:model completion:^(id result, NSInteger statusCode, NSString *msg) {
            if (statusCode == 0) {
                loginresult = result;
                YMInfoCenter *info =  [YMInfoCenter sharedManager];
                YMUser *mainUsr =  info.mainUser;
                mainUsr.isNewUsr = loginresult.flag;
                NSString *uid = [NSString stringWithFormat:@"%ld",loginresult.uid];
                [MobClick profileSignInWithPUID:uid provider:loginDic[@"loginName"]];
                [self login];
            }
            else
            {
                [self.view makeToast:msg];
            }
            
        }];
    

    //
}
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    NSLog(@"sfsaf");
//    [textField resignFirstResponder];
//}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if(true){
        
        return NO;
        
    }else {
        
        return YES;
        
    }
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
    YMUser       *mainUser = infoCenter.mainUser;
    telephoneFiled.text =  mainUser.YMAccount;
    passwordFiled.text = mainUser.YMUserPassword;
}
#pragma mark -------百度地图定位--------
//初始化百度地图定位
-(void) initBMK
{
    _locServicse = [[BMKLocationService alloc]init];
    _locServicse.delegate = self;
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    //启动LocationService
    [_locServicse startUserLocationService];
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    double locaLatitude = userLocation.location.coordinate.latitude;//纬度
    double locaLongitude = userLocation.location.coordinate.longitude;//精度
    BMKCoordinateRegion region;
    //将定位的点居中显示
    region.center.latitude=locaLatitude;
    region.center.longitude=locaLongitude;
    
    //反地理编码出地理位置
    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
    
    pt=(CLLocationCoordinate2D){locaLatitude,locaLongitude};
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag =  [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if (flag) {
        NSLog(@"反检索成功");
    }
    else
    {
        NSLog(@"反检索失败");
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{

    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.addressDetail.city;
        NSString* titleStr;
        titleStr = @"反向地理编码";
        usrLoginAddress = [NSString stringWithFormat:@"%@",item.title];
    }
}
#pragma mark ----TextFieldDelegate----
#pragma mark ---textFiled--
/**
 textField 中的文本是否是可以替换的
 range     当前选中的范围(删除长度范围为1 插入长度的访问0)
 string    将被插入的文本
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == telephoneFiled) {
        return [YMTextFieldInputHandle isInputText:textField range:range replaceStr:string maxLegnth:12];
    }
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == telephoneFiled) {
        if (![[telephoneFiled.text trim] isValidPhoneNumber]) {
            CGPoint center = CGPointMake(kWIDTH /2.0, 240);
            NSValue *pointValue = [NSValue valueWithCGPoint:center];
            [self.view makeToast:@"电话号码格式不正确" duration:1.5 position:pointValue];
        }
    }
}
@end
