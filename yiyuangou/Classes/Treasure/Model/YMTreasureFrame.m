//
//  YMTreasureFrame.m
//  yiyuangou
//
//  Created by roen on 15/10/29.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMTreasureFrame.h"

@implementation YMTreasureFrame
-(void)setTreasure:(ShareProduction *)treasure
{
    _treasure = treasure;
    CGSize detailSize = [[NSString stringWithFormat:@"%@",treasure.descrip] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kWIDTH-75, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    NSInteger imageNumber = treasure.imageList.count;
    
    NSInteger colomns = maxColumns(imageNumber);//列
    
    NSInteger rows = imageNumber / colomns;//行
    if (imageNumber == 5) {
        rows =2;
    }else if(imageNumber >=7){
        rows = 3;
    }else if (imageNumber<=2&&imageNumber>0)
    {
        rows =1;
    }else if(imageNumber == 0){
        rows = 0;
    }
    
    self.unPredictHeight = detailSize.height + (rows) *(photoMagin + photoWidth) - photoMagin;
    if (imageNumber == 0) {
        self.unPredictHeight = detailSize.height;
    }
    NSLog(@"%ld,%ld,%ld",self.unPredictHeight,(rows) *(photoMagin + photoWidth) - photoMagin,imageNumber);

}
-(CGFloat)cellHeight
{
    return self.unPredictHeight;
}

@end
