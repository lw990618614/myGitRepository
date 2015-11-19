//
//  MyCarViewCell.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "MyCarViewCell.h"
#import "TTCounterLabel.h"
@interface MyCarViewCell()<TTCounterLabelDelegate,UITextFieldDelegate>
@end
@implementation MyCarViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //选中按钮
        self.selectButton=[UIButton buttonWithFrame:CGRectZero target:self action:@selector(selectMe) title:@"" cornerRadius:0];
        [self.selectButton setFrame:CGRectMake(0, 40, 40, 40)];
        self.selectButton.centerY = self.centerY;
        [self.contentView addSubview:self.selectButton];
        
        //图片
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(self.selectButton.tmri_right , 15, 80, 80)];
        self.iconView.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
        self.iconView.layer.borderWidth = 1;
        self.iconView.contentMode =  UIViewContentModeScaleAspectFill;
        [self.iconView setClipsToBounds:YES];

        [self.contentView addSubview:self.iconView];
        
        
        self.productionLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, 15, kWIDTH - self.iconView.tmri_right - 20, 25) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
        self.productionLable.font = [UIFont systemFontOfSize:14];
        self.productionLable.text = @"iPhone 6s,手机中的柴油机";
        self.productionLable.numberOfLines = 2;
        [self.contentView addSubview:self.productionLable];
        
        //需求
        self.detailLable =[UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, self.productionLable.tmri_bottom+5, kWIDTH, 20) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.detailLable.text = @"总需求6798/剩余2321";
        [self.contentView addSubview:self.detailLable];
        
        self.leftLable =[UILabel labelWithFrame:CGRectMake(self.detailLable.tmri_right , self.productionLable.tmri_bottom+5, kWIDTH, 20) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#DD2727"]];
        self.leftLable.text = @"总需求6798/剩余2321";
        [self.contentView addSubview:self.leftLable];
        //商品详情


        //增减
        self.numbersView = [[PKYStepper alloc] init];
        self.numbersView.frame = CGRectMake(self.iconView.tmri_right+10, self.detailLable.tmri_bottom + 5, 125, 30);
        self.numbersView.countLabel.delegate = self;
        self.numbersView.countLabel.returnKeyType = UIReturnKeyDone;
        self.numbersView.countLabel.font = [UIFont systemFontOfSize:14];
        self.numbersView.countLabel.delegate = self;
        self.numbersView.countLabel.keyboardType = UIKeyboardTypeNumberPad;
        [self.numbersView.countLabel setBorderStyle:UITextBorderStyleNone];
        [self.contentView addSubview:self.numbersView];
        
        //包尾
        self.lastButton = [UIButton buttonWithFrame:CGRectMake(kWIDTH - 55, self.detailLable.tmri_bottom, 45, 30) target:self action:@selector(lastButtonClick:) title:@"包尾" cornerRadius:1];
        [self.lastButton setTitleColor:[UIColor colorWithHex:@"#d8d8d8"] forState:UIControlStateNormal];
        self.lastButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.lastButton.layer.borderWidth = 1;
        [self.contentView addSubview:self.lastButton];
        
        //详情的label
        self.messageLable =[UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, self.lastButton.tmri_bottom+10, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.messageLable.text = @"最新一期奖品正在抢购中";
        self.messageLable.textColor = [UIColor colorWithHex:@"#DD2727"];
        [self.contentView addSubview:self.messageLable];
        
        self.selectButton.centerY = self.iconView.centerY;
        
        self.numbersView.stepInterval = 1.0f;
        self.numbersView.minimum = 1.0f;
        self.numbersView.buttonWidth = 35;
        
        self.lastButton.centerY = self.numbersView.centerY;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(centerAddAll) name:ADDALL_MYCAR object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(centerDeleteAll) name:DELETE_MYCAR object:nil];

    }
    return self;
}
-(id)configWithMode:(YMCarInfo *)result
{
    __weak typeof(self)safeSelf = self;
    self.numbersView.lastButton = self.lastButton;
    self.model = result;
    if (result.is_end) {
        self.numbersView.value = [self.model.leftAmount integerValue];
    }else{
        self.numbersView.value = result.buyCount;
    }
    self.numbersView.carinfo = result;
//    self.numbersView.value = 10.0f;
    
//    self.numbersView.value = [result.leftAmount intValue]>10?10.0:[result.leftAmount intValue];
    self.numbersView.valueChangedCallback = ^(PKYStepper *stepper, float count) {
        safeSelf.numbersView.countLabel.text = [NSString stringWithFormat:@"%@", @(count)];
        result.buyCount =[safeSelf.numbersView.countLabel.text integerValue];
        result.allPrice = result.buyCount * [result.price intValue];
//        [safeSelf.lastButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        safeSelf.lastButton.backgroundColor = [UIColor whiteColor];
//        safeSelf.model.is_end  = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:TEXT_CHANGE object:nil];
    };
    
    [self.numbersView setup];
    if (result.is_selete) {
        [self.selectButton setImage:[UIImage imageNamed:CellSelectImage] forState:UIControlStateNormal];
    }else{
        [self.selectButton setImage:[UIImage imageNamed:CellUnSelectImage] forState:UIControlStateNormal];
    }
    if (result.lastis_selete) {
        [self.lastButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.lastButton.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
        self.lastButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.lastButton.layer.borderWidth = 1;
    }else{
        [self.lastButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.lastButton.backgroundColor = [UIColor whiteColor];
        self.lastButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.lastButton.layer.borderWidth = 1;
    }
    NSString *imageUrl = [NSString stringWithFormat:@"%@",result.goodsImage];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeHolder];
    
    self.productionLable.text = [NSString stringWithFormat:@"第%ld期  %@",(long)result.period,result.name];
    self.numbersView.maximum = [result.leftAmount intValue];
    NSString *detaiText =[NSString stringWithFormat:@"总需%@/剩余",result.expected];
    CGSize detailSize = [detaiText sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(kWIDTH - self.iconView.tmri_right-10, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    self.detailLable.tmri_width = detailSize.width;
    self.leftLable.x = self.detailLable.MinX +self.detailLable.tmri_width;
    self.detailLable.text = [NSString stringWithFormat:@"总需%@/剩余 ",result.expected];
    self.leftLable.text = result.leftAmount;
    self.selectButton.selected = result.is_selete;
    return self;
}
-(void)selectMe
{
    if (self.selectButton.selected) {
        [self.selectButton setImage:[UIImage imageNamed:CellUnSelectImage] forState:UIControlStateNormal];
        self.model.is_selete = NO;
        if ([self.delegate respondsToSelector:@selector(deselectedCell:)]) {
            [self.delegate deselectedCell:self];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(selectedCell:)]) {
            [self.delegate selectedCell:self];
        }
        [self.selectButton setImage:[UIImage imageNamed:CellSelectImage] forState:UIControlStateNormal];

        self.model.is_selete = YES;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:TEXT_CHANGE object:nil];

    self.selectButton.selected = !self.selectButton.selected;
}

-(void)lastButtonClick:(UIButton *)button
{
    self.lastButton.selected = !self.lastButton.selected;

    if (self.lastButton.selected) {
        button.layer.borderColor = [UIColor clearColor].CGColor;
        button.layer.borderWidth = 1;
        self.model.lastis_selete = YES;
        self.model.is_end  = 1;
        self.model.buyCount = [self.model.leftAmount integerValue];
        button.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        self.model.lastis_selete = NO;
        self.model.is_end = 0;
        button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.model.buyCount = [self.model.leftAmount integerValue];
//        self.model.buyCount =  [self.model.leftAmount intValue]>10?10.0:[self.model.leftAmount intValue];
        
        button.layer.borderWidth = 1;
    }
    self.numbersView.value = self.model.buyCount;

}
-(void)centerAddAll
{
    self.model.is_selete = YES;
    self.selectButton.selected = YES;
    [self.selectButton setImage:[UIImage imageNamed:CellSelectImage] forState:UIControlStateNormal];
}
-(void)centerDeleteAll
{
        [self.selectButton setImage:[UIImage imageNamed:CellUnSelectImage] forState:UIControlStateNormal];
        self.model.is_selete = NO;
        self.selectButton.selected = NO;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.model.is_selete = NO;
    self.selectButton.selected = NO;

    if (self.endEdtingBlock) {
        self.endEdtingBlock();
    }
    if ([self.model.leftAmount intValue]<[self.numbersView.countLabel.text intValue]) {
    self.numbersView.countLabel.text = [NSString stringWithFormat:@"%@",self.model.leftAmount];
    }
    self.model.buyCount = [textField.text integerValue];
    self.model.allPrice = self.model.buyCount*[self.model.price integerValue];
    if ([self.numbersView.countLabel.text intValue] < 1) {
        NSInteger textAmount = [self.model.leftAmount integerValue]>0?1:0;
        self.numbersView.countLabel.text = [NSString stringWithFormat:@"%ld",(long)textAmount];
        self.model.buyCount = [textField.text integerValue];
        self.model.allPrice = self.model.buyCount*[self.model.price integerValue];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:TEXT_CHANGE object:nil];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.lastButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.lastButton.backgroundColor = [UIColor whiteColor];
    self.model.lastis_selete = NO;
    self.model.is_end = 0;

    if (self.edtingBlock) {
        self.edtingBlock();
    }
    

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{

    if ([textField.text integerValue]<= [self.model.leftAmount integerValue]) {
        return YES;
    }
    return NO;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.numbersView.value = [textField.text integerValue];
    
    return YES;
}
@end
