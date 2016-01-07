//
//  YMSetPassWordController.m
//  yiyuangou
//
//  Created by roen on 15/10/22.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMSetPassWordController.h"
#import "YMLoginViewController.h"
#import "YMLoginCell.h"
#import "LoginManager.h"
#import "YMVerfyResult.h"
#import "YMLoginViewController.h"
#import "MySettingViewController.h"
#import "MyMD5.h"
#import "YMTextFieldInputHandle.h"
#import <BaiduMapAPI_Base/BMKUserLocation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
@interface YMSetPassWordController()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,BMKLocationServiceDelegate,BMKGeneralDelegate,BMKGeoCodeSearchDelegate>
{
    UITextField *telephoneFiled;
    UITextField *passwordFiled;
    UITableView *mainTableView;
    BMKGeoCodeSearch* _geocodesearch;
    NSString    *usrLoginAddress;//用户登录地址
}
@property(nonatomic,strong) BMKLocationService  *locServicse;

@end

@implementation YMSetPassWordController
-(void)viewDidLoad
{
    [super viewDidLoad];
//    [self initBMK];
    self.title =@"设置密码";
    self.view.backgroundColor  = [UIColor redColor];
    telephoneFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kWIDTH - 110, 40)];
    telephoneFiled.keyboardType = UIKeyboardTypeASCIICapable;
    telephoneFiled.placeholder = @"请输入新密码";
    telephoneFiled.clearButtonMode = YES;
    telephoneFiled.delegate = self;
    telephoneFiled.secureTextEntry = YES;
    
    [telephoneFiled setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [telephoneFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    passwordFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kWIDTH - 110, 40)];
    passwordFiled.keyboardType = UIKeyboardTypeASCIICapable;
    passwordFiled.placeholder = @"请再次输入";
    passwordFiled.clearButtonMode = YES;
    passwordFiled.delegate = self;
    passwordFiled.secureTextEntry  = YES;
    [passwordFiled setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                 style:UITableViewStyleGrouped];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    
    [mainTableView setTableFooterView: [[UIView alloc]initWithFrame:CGRectZero]];
    
    [self.view addSubview:mainTableView];
    if ([mainTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mainTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([mainTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mainTableView setLayoutMargins:UIEdgeInsetsZero];
    }
//    self.view.backgroundColor = [UIColor clearColor];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row !=2) {
        
        static NSString *loglinCell = @"loglinCell";
        YMLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:loglinCell];
        if (cell == nil) {
            cell = [[YMLoginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loglinCell];
        }
        if (indexPath.row == 0) {
            cell.iconView.image = [UIImage imageNamed:@"code"];
            [cell.loginView addSubview:telephoneFiled];
        }else if (indexPath.row == 1){
            cell.iconView.image = [UIImage imageNamed:@"code"];
            [cell.loginView addSubview:passwordFiled];
        }
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }else{
        static NSString *tableviewCell = @"tableviewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableviewCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableviewCell];
        }
        UIButton *loginButton = [UIButton buttonWithFrame:CGRectMake(10, 20, kWIDTH -20, 40) target:self action:@selector(loginButtonClick) title:@"确认" cornerRadius:1];
        loginButton.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
        [cell.contentView addSubview:loginButton];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];

        return cell;
    }
}
-(void)loginButtonClick
{

    [passwordFiled resignFirstResponder];
    [telephoneFiled resignFirstResponder];
    if(![[passwordFiled.text trim] isValidPassword])
    {
        [self.view makeToast:[NSString stringWithFormat:@"账户密码应在6-12位之间"]];
        return;
    }
    if ([passwordFiled.text isEqualToString:telephoneFiled.text]) {
        if (self.ways == YMRegistUser) {
            YMLoginModel *model = [[YMLoginModel alloc] init];
            model.mobile = self.model.mobile;
            model.password = [passwordFiled.text trim];
            model.address  = usrLoginAddress;
            model.flag = @"0";
            WEAKSELF;
            [[LoginManager sharedManager] LoginStatusWithModle:model completion:^(id result, NSInteger statusCode, NSString *msg) {
                if (statusCode == 0) {
                    YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
                    NSDictionary *dict =  [result keyValues];
                    YMUser *mainUser = infoCenter.mainUser;
                    mainUser.YMAccount = weakSelf.model.mobile;
                    [infoCenter saveUserAccount];
                    mainUser.YMUserID = [dict[@"uid"] integerValue];
                    mainUser.isNewUsr = [dict[@"flag"] boolValue];
                    [infoCenter saveUserID];
                    mainUser.YMUserPassword = [passwordFiled.text trim];

                    NSLog(@"%@",weakSelf.navigationController);
                    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_SELF object:nil userInfo:@{@"type":NSStringFromClass([self class])}];


                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
                }else if(statusCode == 6){
                    
                }
            }];

        }
        else if (self.ways == YMRestPhone)
        {
            NSString *str = @"/user/updateInfo";
            NSMutableDictionary *dict  = [BaseParamDic baseParam];
            
            NSString *passwd = [telephoneFiled.text trim];
            NSString *mobile =  self.model.mobile;
            [dict setValue:mobile  forKey:@"mobile"];
            [dict setValue:passwd forKey:@"password"];
            //判断电话是否正确
            NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,str];
            WEAKSELF;
            [YMBaseHttpTool POST:url params:dict name:@"_face" data:nil success:^(id result) {
                YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
                YMUser *mainUser = infoCenter.mainUser;
                mainUser.YMAccount = weakSelf.model.mobile;
                mainUser.YMUserPassword = [passwordFiled.text trim];
                [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_SELF object:nil];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                
                
            } uploadProgressBlock:^(float uploadPercent, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                
            }];
        }


    }
    else
    {
        [self.view makeToast:@"两次密码输入不一致"];
    }

}
#pragma mark ---textFiled--
/**
 textField 中的文本是否是可以替换的
 range     当前选中的范围(删除长度范围为1 插入长度的访问0)
 string    将被插入的文本
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == telephoneFiled) {
        return [YMTextFieldInputHandle isInputText:textField range:range replaceStr:string maxLegnth:13];
    }
    else if (textField == passwordFiled)
    {
        return [YMTextFieldInputHandle isInputText:textField range:range replaceStr:string maxLegnth:13];
    }
    return YES;
    
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

@end

