//
//  YMPayController.m
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMPayController.h"
#import "MyCarManager.h"
#import "UIButton+Block.h"
#import "YMCashResult.h"
#import "YMOAuthViewController.h"
#import "YMTextFild.h"
#import "YMPayResultController.h"
@interface YMPayController()<UITextFieldDelegate>
{
    YMTextFild *inputField;
    YMPayResult *carresult;
    BOOL isFinshChongZhi;//是否完成充值
    BOOL isFinshBug    ;//是否完成抢购
}
@property (nonatomic,strong)NSArray *titleArry;

@property (nonatomic,strong)UIView *footerView1;
@property(nonatomic,assign) NSUInteger lastTap;//上次选择
@property (nonatomic,strong)UIButton *payButton;
@property (nonatomic,assign)NSInteger lastCell;
@property (nonatomic,strong)UIButton *backBtn;

@end

@implementation YMPayController
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
 
    self.payButton.userInteractionEnabled = YES;
}
-(UIView *)footerView1
{
    if (_footerView1 == nil) {
        _footerView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 65)];
    }
    return _footerView1;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    _lastTap =  1;
    self.title = @"支付订单";
    if (self.pay_operation == 1) {
        self.title = @"充值";
    }
    inputField = [[YMTextFild alloc] initWithFrame:CGRectMake(55, 0, kWIDTH - 100 , 50)];
    inputField.keyboardType = UIKeyboardTypeNumberPad;
    inputField.placeholder = @"请输入您要充值的金额";
    inputField.textAlignment = NSTextAlignmentLeft;
    inputField.returnKeyType = UIReturnKeyDefault;
    inputField.font  = [UIFont systemFontOfSize:15];
    inputField.tintColor = [UIColor colorWithHex:@"#c1c1c1"];
    inputField.delegate = self;
    if (self.pay_operation == 0) {
        UIImage *btnImage = [UIImage imageNamed:@"nav_back"];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0,0, btnImage.size.width, btnImage.size.height);
        [backBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(goBackTobefore) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem=barBtn;
        self.backBtn = backBtn;
    }
    self.payButton = [UIButton buttonWithFrame:CGRectMake(10, 15, kWIDTH- 20, 50) target:self action:@selector(btnClick) title:@"确认支付" cornerRadius:2];
    UILabel *messageLable = [UILabel labelWithFrame:CGRectMake(10, self.payButton.tmri_bottom, kWIDTH - 20, 50) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
    messageLable.text = @"由于抢购火热！请在30秒内完成支付。若支付超时，按实际购买份数为准，支付有余的金额退回至抢币余额";
    if (self.pay_operation == 1) {
        messageLable.hidden = YES;
    }
    messageLable.textColor = [UIColor colorWithHex:@"#DD2727"];
    messageLable.numberOfLines =2;
    [self.footerView1 addSubview:messageLable];
    [self.footerView1 addSubview:self.payButton];
    self.payButton.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    if (self.pay_operation == 0) {
        [self loadData];
    }else{
    
    }
    [self.tableView setSeparatorColor:[UIColor colorWithHex:@"#EAEAEA"]];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.pay_operation == 0) {
        if (!carresult) {
            return 0;
        }
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.pay_operation == 1) {
            return 3;
        }else{
            return 1;
        }
    }else{
        if (carresult.coin < carresult.toatlPrice) {
            self.lastCell = 4;
            return 4;
            
        }else{
            self.lastCell = 3;
            return 3;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        if (indexPath.row == 2) {
            return  50;
        }else{
            return 65;
        }
    }else{
        if (indexPath.row == 0) {
            return 50;
        }else{
            return 65;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return HEIGHT_SERO;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *payViewCell = @"payViewCell";
    _lastTap = _lastCell-2;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payViewCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payViewCell];
        UIImageView*accessoryImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        cell.accessoryView=accessoryImageView;
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];  //
        }
    }
    NSDictionary *attGray = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:15],
                              NSForegroundColorAttributeName:[UIColor colorWithHex: @"#999999"],
                              };
    NSDictionary *attRed = @{
                             NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                             NSForegroundColorAttributeName:[UIColor  colorWithHex:@"#DD2727"],
                             };
    UIImageView*accessoryView=(UIImageView*)cell.accessoryView;

    if (self.pay_operation == 0) {
        if (indexPath.section == 0) {
            cell.textLabel.text = @"奖品合计";
            cell.textLabel.textColor  =[UIColor colorWithHex:@"#444444"];
            cell.textLabel.font  =[UIFont systemFontOfSize:15];
            UILabel *coinLable = [UILabel labelWithFrame:CGRectMake(kWIDTH - 110, 0, 100, 65) textAlignment:NSTextAlignmentRight textColor:nil];
            NSString *text = [NSString stringWithFormat:@"%ld 抢币", (long)carresult.toatlPrice];
            coinLable.attributedText = [self genAttibuteStr:text newhandleStr:@"抢币" commonAttDic:attRed handleDic:attGray];
            [cell.contentView addSubview:coinLable];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            if (indexPath.row == self.lastCell-1) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.contentView addSubview:self.footerView1];
                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
                return cell;
            }
            if (indexPath.row == 0) {
                cell.textLabel.text = @"使用以下支付方式";
                cell.textLabel.textColor  =[UIColor colorWithHex:@"#444444"];
                cell.textLabel.font  =[UIFont systemFontOfSize:16];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                return cell;
            }else if (indexPath.row == 1){
                cell.imageView.image = [UIImage imageNamed:@"coin"];
                cell.textLabel.textColor  =[UIColor colorWithHex:@"#444444"];
                cell.textLabel.font  =[UIFont systemFontOfSize:15];
                
                UILabel *coinLable = [UILabel labelWithFrame:CGRectMake(70, 0, 200, 65) textAlignment:NSTextAlignmentLeft textColor:nil];
                NSString *text;

                if (carresult.coin >= carresult.toatlPrice) {
                   accessoryView.image=[UIImage imageNamed:CellSelectImage];
                    text = [NSString stringWithFormat:@"抢币支付 (%ld个)", (long)carresult.coin];

                }else{
                    text = [NSString stringWithFormat:@"抢币余额  (%ld个)", (long)carresult.coin];
                }

                NSString *text1 = [NSString stringWithFormat:@"(%ld个)", (long)carresult.coin];
                NSDictionary *att = @{
                                          NSFontAttributeName:[UIFont systemFontOfSize:15],
                                          NSForegroundColorAttributeName:[UIColor colorWithHex: @"#444444"],
                                          };
                NSDictionary *att1 = @{
                                          NSFontAttributeName:[UIFont systemFontOfSize:10],
                                          NSForegroundColorAttributeName:[UIColor colorWithHex: @"#444444"],
                                          };

                coinLable.attributedText = [self genAttibuteStr:text newhandleStr:text1 commonAttDic:att handleDic:att1];
                [cell.contentView addSubview:coinLable];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                cell.imageView.image = [UIImage imageNamed:@"爱贝"];
                cell.textLabel.text = @"爱贝支付";
                cell.textLabel.textColor  =[UIColor colorWithHex:@"#444444"];
                cell.textLabel.font  =[UIFont systemFontOfSize:15];
                accessoryView.image=[UIImage imageNamed:CellSelectImage];
                return cell;
            }
        }
    }else{
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"抢币余额:";
                cell.textLabel.textColor  =[UIColor colorWithHex:@"#444444"];
                cell.textLabel.font  =[UIFont systemFontOfSize:15];
                cell.imageView.image  = [UIImage imageNamed:@"coin"];
                UILabel *coinLable =  [UILabel labelWithFrame:CGRectMake(150, 0, 100, 65) textAlignment:NSTextAlignmentLeft textColor:[UIColor  colorWithHex:@"#DD2727"]];
                coinLable.font = [UIFont systemFontOfSize:15];
                coinLable.text = [NSString stringWithFormat:@" %ld个",(long)self.coin];
                [cell.contentView addSubview:coinLable];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                return cell;
            }else if(indexPath.row ==1){
                UILabel *labe =  [UILabel labelWithFrame:CGRectMake(10, 0, kWIDTH-20, 65) textAlignment:NSTextAlignmentCenter textColor:[UIColor colorWithHex:@"#DD2727"]];
                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
                labe.text = @"您支付1元购买99网盘空间,系统会自动赠送给您一个夺宝币,即1元=1抢币,可用于夺宝,充值的款项将无法退回.";
                labe.textColor = [UIColor colorWithHex:@"#DD2727"];
                labe.numberOfLines = 0;
                [cell.contentView addSubview:labe];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                cell.textLabel.text = @"金额";
                cell.textLabel.font  = [UIFont systemFontOfSize:16];
                [cell.contentView addSubview:inputField];
                return cell;
            }
            
        }else{
            if (indexPath.row == 2) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.contentView addSubview:self.footerView1];
                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
                return cell;
            }

            if (indexPath.row == 0) {
                cell.textLabel.text = @"使用第三方平台支付";
                cell.textLabel.textColor  =[UIColor colorWithHex:@"#444444"];
                cell.textLabel.font  =[UIFont systemFontOfSize:16];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                cell.textLabel.text = @"爱贝支付";
                accessoryView.image=[UIImage imageNamed:CellSelectImage];
                cell.imageView.image = [UIImage imageNamed: @"爱贝"];
                cell.textLabel.textColor  =[UIColor colorWithHex:@"#444444"];
                cell.textLabel.font  =[UIFont systemFontOfSize:15];
                return cell;
            }
        }
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)getback
{
    SAFE;
     [[MyCarManager sharedManager] dismissTheordercompletion:^(id result, NSInteger statusCode, NSString *msg) {
         if (statusCode == 0) {
             
         }else{
             [weakSelf.view makeToast:msg];
         }
     }];
    [self dissmissMe];
}
-(void)dissmissMe
{
    SAFE;
    [[MyCarManager sharedManager] dismissTheordercompletion:^(id result, NSInteger statusCode, NSString *msg) {
        if (statusCode == 0) {
            
        }else{
            [weakSelf.view makeToast:msg];
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)hidtheView
{
    [self.view hideToastActivity];
}
-(void)btnClick
{
    if (_lastTap == 1) {
        if (self.pay_operation == 0) {
            if (carresult.coin < carresult.toatlPrice) {
                [self.view makeToast:@"    余额不足   "];
                [self performSelector:@selector(hidtheView) withObject:nil afterDelay:1.0];
                return;
            }
            SAFE;
            self.backBtn .enabled = NO;
            [self.view makeToastActivity:kLoadingText];
            [[MyCarManager sharedManager] MycarFinishiPayStatusWith:carresult withPay_way:_lastTap completion:^(id result, NSInteger statusCode, NSString *msg) {
                self.backBtn.enabled = YES;
                [weakSelf.view hideToastActivity];
                if (statusCode == 0) {
                    [weakSelf.view makeToast:@"  购买成功  "];
                    [[NSNotificationCenter defaultCenter]postNotificationName:CAR_ISCHANGE object:nil];
                    YMPayResultController *controller = [[YMPayResultController alloc] init];
                    controller.oid = carresult.oid;
                    [self setHidesBottomBarWhenPushed:YES];
                    controller.isHidenRight = YES;
                    
                    [self.navigationController pushViewController:controller animated:YES];

                }else{
                    [self.view makeToastActivity:msg];
                }
            }];

        }else{
            if ([inputField.text intValue]  == 0) {
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入购买金额" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alterView show];
                return;
            }
            if ([inputField.text intValue] >100000) {
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"一次最多充值 100000元 0.0" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alterView show];
                return;
            }
            YMOAuthViewController *controller = [[YMOAuthViewController alloc] init];
            controller.coin =[inputField.text intValue];
            controller.title = self.title;
            controller.pay_way = 1;
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
    }
    }else{
        if (carresult.coin >= carresult.toatlPrice) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"购买失败" message:@"抢币充足,请用余额支付^-^" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alterView.tag = 1;
            [alterView show];
            return;
        }
        YMOAuthViewController *controller = [[YMOAuthViewController alloc] init];
        controller.oid =carresult.oid;
        controller.car =carresult;
        [self setHidesBottomBarWhenPushed:YES];
        controller.title = self.title;

        [[NSNotificationCenter defaultCenter]postNotificationName:CAR_ISCHANGE object:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
-(void)loadData
{
    SAFE;
    [self.view makeToastActivity:kLoadingText];
    
    [[MyCarManager sharedManager] myCarBuyStatusWithTotalMoney:0 andGoods:self.selectedArray completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];
        if (statusCode == 0) {
            carresult = result;
            
            [weakSelf.tableView reloadData];
            if (carresult.toatlPrice == 0) {
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"哎呀,你的商品已被抢光" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"选其他", nil];
                alterView.tag = 1;
                [[NSNotificationCenter defaultCenter]postNotificationName:CAR_ISCHANGE object:nil];
                [alterView show];
            }

        }else{
            [weakSelf.view makeToast:msg];
        }
    }];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_SELF object:nil];

}

-(NSMutableAttributedString *) genAttibuteStr:(NSString *)str newhandleStr:(NSString *) subStr commonAttDic:(NSDictionary *)commonDic handleDic:(NSDictionary *)handleDic
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    
    NSRange range = [str rangeOfString:subStr];
    NSString *str1 = [str substringToIndex:range.location];
    NSString *str2 = subStr;
    NSString *str3 = [str substringFromIndex:range.location + range.length];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:str1 attributes: commonDic]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str2] attributes: handleDic]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:str3 attributes: commonDic]];
    return attStr;
}

#pragma mark ---- 任务上报---
//任务上报
-(void) taskCompete:(NSNumber *)taskId
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/task/complete"];
    NSMutableDictionary *muDic = [BaseParamDic baseParam];
    [muDic setValue:taskId forKey:@"tiid"];
    WEAKSELF;
    [YMBaseHttpTool POST:url params:muDic success:^(id result) {
        NSDictionary  *dict = [result keyValues];
        if ([dict[@"code"] integerValue] == 0) {
            [weakSelf.view makeToast:@"任务上报成功"];
            //重新刷新数据
            [weakSelf loadData];
        }
        else
        {
            [weakSelf.view makeToast:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger  count = [textField.text integerValue];
    textField.text = [NSString stringWithFormat:@"%ld",(long)count];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        [self dissmissMe];

    }
    if (alertView.tag == 5) {
        if (buttonIndex == 0) {
            [self dissmissMe];
        }

    }
}
-(void)goBackTobefore
{
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"机会不等人,确定放弃支付" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", @"考虑一下",nil];
    alterView.tag = 5;
    [alterView show];

}
@end
