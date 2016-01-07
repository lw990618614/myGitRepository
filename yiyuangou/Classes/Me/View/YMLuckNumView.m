//
//  YMLuckNumView.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/19.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMLuckNumView.h"
#import "YMLuckNumCollectionCell.h"
static NSString *identifier = @"cell";
static NSString *headIdentifier = @"head";
@interface YMLuckNumView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) NSArray *luckNumArray;
@property(nonatomic,strong) UICollectionView *luckCollectionView;
@property(nonatomic,strong) UIView *headView;
@end
@implementation YMLuckNumView
-(instancetype)initWithLuckArray:(NSArray *)luckArray frame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        _luckNumArray = luckArray;
        [self initWithSubViews];
    }
    return self;
}
-(void) initWithSubViews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(didClose:)];
    [self addGestureRecognizer:tap];
    self.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.5];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH - 10*2, 223)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
    bgView.layer.cornerRadius = 5;
    [bgView setClipsToBounds:YES];
    bgView.center =  self.center;
    [self addSubview:bgView];
    //流式布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.luckCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 43, kWIDTH - 20, 181) collectionViewLayout:layout];
    self.luckCollectionView.collectionViewLayout =  layout;
    self.luckCollectionView.dataSource = self;
    self.luckCollectionView.delegate = self;
//    self.luckCollectionView.center = self.center;
    self.luckCollectionView.backgroundColor = [UIColor whiteColor];
    self.luckCollectionView.showsVerticalScrollIndicator = NO;


    [self.luckCollectionView registerClass:[YMLuckNumCollectionCell class] forCellWithReuseIdentifier:identifier];
    [bgView addSubview:self.luckCollectionView];

    self.headView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH - 20, 42)];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.headView.width - 20, 20)];
    titleLbl.center = self.headView.center;
    titleLbl.font = [UIFont systemFontOfSize:15.0];
    titleLbl.textColor = [UIColor heightBlacKColor];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.text = @"您的幸运码";
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.headView.width -40, 10, 25, 25)];
    [btn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = btn.width/2.0;
    [btn addTarget:self action:@selector(didClose:) forControlEvents:UIControlEventTouchUpInside];
    btn.clipsToBounds = YES;
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0,self.headView.height -1, self.headView.width, 0.7)];
    line.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
    [self.headView addSubview:line];
    [self.headView addSubview:btn];
    [self.headView addSubview:titleLbl];
    [bgView addSubview:self.headView];
}
#pragma mark -----UICollectionDataSource UIColllectionDelegate-----
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YMLuckNumCollectionCell *cell;
//    cell.backgroundColor = [UIColor yellowColor];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell cellConfig:self.luckNumArray[indexPath.row]];
    return cell;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.luckNumArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.width / 4, 40);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置分区头
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={collectionView.width - 10*2,0.01};
    return size;
  
}
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableview = nil;
//    if (kind == UICollectionElementKindSectionHeader) {
//        UICollectionReusableView *headerView = [collectionView
//                                                dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//                                                withReuseIdentifier:headIdentifier
//                                                forIndexPath:indexPath];
//        [headerView addSubview:self.headView];
//        reusableview = headerView;
//    }
//    return reusableview;
//}
-(void)didClose:(id) sender
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
