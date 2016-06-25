//
//  CustomSearchView.h
//  MySelectCityDemo
//
//  Created by 李阳 on 15/9/2.
//  Copyright (c) 2015年 WXDL. All rights reserved.
//

#import <UIKit/UIKit.h>
//第一步制定协议 协议的方法不需要实现
@protocol CustomSearchViewDelegate <NSObject>

-(void)searchBeginEditing;
-(void)didSelectCancelBtn;
-(void)searchString:(NSString *)string;
@end


@interface CustomSearchView : UIView<UISearchBarDelegate>
@property (nonatomic,retain)UISearchBar *searchBar;
@property (nonatomic,retain)UIButton *cancelBtn;
//第二步、设置代理属性
@property (nonatomic,assign) id <CustomSearchViewDelegate>delegate;
@end


