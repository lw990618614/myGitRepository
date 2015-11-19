//
//  YMProductionCell.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMProductionCell.h"
#define photoW 70 //图片的宽度
#define photoH  photoW //图片的高度


@implementation YMProductionCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(ShareProduction *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 35, 35)];
        self.iconView.image = [UIImage imageNamed: @"img_02"];
        
        self.nameLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, 10, 130, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.nameLable.text = @"格式各样来一份";
        
        self.seperateView = [[UIView alloc] initWithFrame:CGRectMake(self.iconView.tmri_right + 10, 40, kWIDTH -self.iconView.tmri_right - 10, 1)];
        self.seperateView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.seperateView];
        
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.nameLable.tmri_right, 10, kWIDTH-self.nameLable.tmri_right, 15) textAlignment:NSTextAlignmentRight textColor:[UIColor blackColor]];
        self.timeLable.text = @"2019-15-08";
        
        CGSize detaiSize = [[NSString stringWithFormat:@"%@",model.descrip] sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(GTFixWidthFlaot(250), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        self.messgeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, self.seperateView.tmri_bottom + 15, 250, detaiSize.height) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.messgeLable.font = [UIFont systemFontOfSize:16];
        self.messgeLable.numberOfLines = 0;
        self.messgeLable.text = @"总于中奖了";

        self.stateLable = [UILabel labelWithFrame:CGRectMake(self.messgeLable.tmri_right , self.nameLable.tmri_bottom + 5,80, 15) textAlignment:NSTextAlignmentRight textColor:[UIColor blackColor]];
        self.stateLable.text = @"已发布";
        if (model.imageList.count > 0) {

            NSInteger columns =  maxColumns(model.imageList.count);
            NSInteger rows = model.imageList.count / columns ;

            NSLog(@"%ld,%ld",columns,rows);

            CGFloat photosW = (photoW + photoMagin) * columns -  photoMagin;
            CGFloat photosH = (photoH + photoMagin) * (rows) -  photoMagin;
           
            self.backView = [[UIView alloc] initWithFrame:CGRectMake(self.iconView.tmri_right +10, self.messgeLable.tmri_bottom +15, photosW, photosH)];
            
            for (int i = 0; i < model.imageList.count; i ++) {
                UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(i%columns *(photoW +photoMagin), i/columns *(photoW +photoMagin), photoW, photoH)];
                picView.backgroundColor = [UIColor whiteColor];
                NSLog(@"%ld,%ld,%ld",i%columns, i/columns,photosH);
                SharePicture *picture =  model.imageList[i];
                
                [picView sd_setImageWithURL:[NSURL URLWithString:picture.imageUrl] placeholderImage:nil];
                [self.backView addSubview:picView];
            }
 
        }
        
        
        self.describeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.backView.tmri_bottom +15, kWIDTH , 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.describeLable.font = [UIFont systemFontOfSize:16];
        self.describeLable.text = @"(第765期) IPhone 玫瑰金64GB";
        if (model.imageList.count == 0) {
            self.describeLable.tmri_top = self.messgeLable.tmri_bottom +15;
        }
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLable];
        [self.contentView addSubview:self.backView];
        
        [self.contentView addSubview:self.timeLable];
        [self.contentView addSubview:self.messgeLable];
        [self.contentView addSubview:self.stateLable];
        [self.contentView addSubview:self.pictureView];
        [self.contentView addSubview:self.describeLable];
    }
    return self;
}
-(id)configWithMode:(ShareProduction *)model
{
    
//    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:model.pictures] placeholderImage:nil];

//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:nil];
    self.nameLable.text = model.sname;
    
    self.timeLable.text = model.createTime;
    
    self.describeLable.text = [NSString stringWithFormat:@"(第%@期) %@",model.period,model.name];
    self.messgeLable.text = model.descrip;

    return self;
}
@end
