//
//  ViewController.m
//  自定义layout
//
//  Created by zhoulei on 16/5/9.
//  Copyright © 2016年 周磊. All rights reserved.
//

#import "ViewController.h"
#import "ZLCollectionViewLayout.h"
#import "GoodsCollectionViewCell.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *zongArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * ceshiArray1 = [[NSArray alloc] initWithObjects: @"1",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",nil];
    NSArray * ceshiArray2 = [[NSArray alloc] initWithObjects: @"1",@"12",@"13",@"14",@"15",nil];
    NSArray * ceshiArray3 = [[NSArray alloc] initWithObjects: @"1",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",nil];
    NSArray *hehe = [[NSArray alloc] initWithObjects: @"1",@"12",@"26",nil];
    self.zongArray = [[NSArray alloc] initWithObjects:ceshiArray1,ceshiArray2,ceshiArray3,hehe,nil];

    
    ZLCollectionViewLayout *flowLayout=[[ZLCollectionViewLayout alloc] init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(57 ,78);
    flowLayout.sectionInset =  UIEdgeInsetsMake(0, 15, 29, 15);
    flowLayout.minimumLineSpacing = 22;
    flowLayout.minimumInteritemSpacing = 27;
    flowLayout.headerReferenceSize = CGSizeMake(0, 61);
    flowLayout.footerReferenceSize = CGSizeMake(10, 150);

    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth, 268) collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor = [UIColor grayColor];
    
    [self.collectionView registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:@"UICollectionReusableViewFooter"];

    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"UICollectionReusableViewHeader"];

    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.scrollsToTop = YES;
    
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor= [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.zongArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.zongArray[section] count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
   
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeader" forIndexPath:indexPath];
        
        footerView.backgroundColor = [UIColor orangeColor];
        reusableView = footerView;
        
    }
    else if(kind == UICollectionElementKindSectionFooter){
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewFooter" forIndexPath:indexPath];
        
        footerView.backgroundColor = [UIColor redColor];
        
        reusableView = footerView;
        
    }

    
    
       return reusableView;
    
}

@end
