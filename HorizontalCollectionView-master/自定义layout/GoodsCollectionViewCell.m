//
//  GoodsCollectionViewCell.m
//  自定义layout
//
//  Created by zhoulei on 16/5/9.
//  Copyright © 2016年 周磊. All rights reserved.
//

#import "GoodsCollectionViewCell.h"


@interface GoodsCollectionViewCell ()

@property (nonatomic,strong) UIImageView *goodsImage;
@property (nonatomic,strong) UILabel *goodsName;

@end


@implementation GoodsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 57, 57)];
        _goodsImage.image = [UIImage imageNamed:@"icon2"];
        [self addSubview:_goodsImage];
        
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(0, 67, 57, 15)];
        _goodsName.textAlignment = NSTextAlignmentCenter;
        _goodsName.text = @"皮炎";
        _goodsName.textColor = [UIColor blackColor];
        _goodsName.font = [UIFont systemFontOfSize:11];
        [self addSubview:_goodsName];
      
    }
    return self;
}


@end
