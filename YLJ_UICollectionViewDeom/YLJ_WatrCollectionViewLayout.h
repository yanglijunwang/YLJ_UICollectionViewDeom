//
//  YLJ_WatrCollectionViewLayout.h
//  YLJ_UICollectionViewDeom
//
//  Created by 杨礼军 on 16/7/14.
//  Copyright © 2016年 杨礼军. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const YLJ_UICollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const YLJ_UICollectionElementKindSectionFooter;
@class YLJ_WatrCollectionViewLayout;
@protocol  YLJ_WatrCollectionViewLayoutDelegate <NSObject>
//代理去的CELL的高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YLJ_WatrCollectionViewLayout *)layout heightOfItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;
//处理移动相关的数据源
- (void)moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath;

@end

@interface YLJ_WatrCollectionViewLayout : UICollectionViewLayout
@property (assign, nonatomic) NSInteger numberOfColumns;//瀑布流有列
@property (assign, nonatomic) CGFloat cellDistance;//cell之间的间距
@property (assign, nonatomic) CGFloat topAndBottomDustance;//cell 到顶部 底部的间距
@property (assign, nonatomic) CGFloat headerViewHeight;//头视图的高度
@property (assign, nonatomic) CGFloat footViewHeight;//尾视图的高度

@property(nonatomic, weak) id<YLJ_WatrCollectionViewLayoutDelegate> delegate;
@end
