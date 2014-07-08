//
//  LeafMenuViewController.h
//  LeafSlideMenu
//
//  Created by Wang on 14-7-3.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>
@interface LeafMenuViewController : UIViewController<UIGestureRecognizerDelegate>
@property(nonatomic,strong) UIViewController *leftVC;
@property(nonatomic,strong) NSArray *viewControllers;
/**
 *  打开和关闭菜单是否有spring效果
 */
@property(nonatomic,assign,getter = isSpringAnimation) BOOL springAnimation;
/**
 *  内容视图添加阴影(加影音后对滑动会稍微有影响)
 */
@property(nonatomic,assign,getter = isShadowed) BOOL shadow;
+(instancetype)shareInstance;
/**
 *  初始化
 *
 *  @param leftVC    左边菜单视图,一般为uitableview
 *  @param centerVCs 中间内容视图集合
 *
 *  @return id
 */
-(instancetype)initWithLeftVC:(UIViewController *)leftVC centerVCs:(NSArray *)centerVCs;
/**
 *  打开第几个视图
 *
 *  @param index
 */
-(void)openAtIndex:(NSInteger)index animated:(BOOL)animated;
/**
 *  关闭内容视图,显示菜单
 *
 *  @param animated
 */
-(void)closeWithAnimation:(BOOL)animated;

@end
