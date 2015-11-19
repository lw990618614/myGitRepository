//
//  YMHelpViewController.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMHelpViewController.h"

@interface YMHelpViewController ()

@end

@implementation YMHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.isFinishTask) {
        [self taskCompete:self.taskID];
    }
    // Do any additional setup after loading the view.
}
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
            NSLog(@"任务完成");
//            [[NSNotificationCenter defaultCenter] postNotificationName:ymNotificationTaskCompete object:nil];
//            [weakSelf.view makeToast:@"任务上报成功"];
            //重新刷新数据
//            [weakSelf loadData];
        }
        else
        {
            [weakSelf.view makeToast:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
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
