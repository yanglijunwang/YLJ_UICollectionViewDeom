//
//  YLJ_HeaderCollectionReusableView.m
//  YLJ_UICollectionViewDeom
//
//  Created by 杨礼军 on 16/7/14.
//  Copyright © 2016年 杨礼军. All rights reserved.
//

#import "YLJ_HeaderCollectionReusableView.h"

@implementation YLJ_HeaderCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 50)];
        [self addSubview:label];
    }
    return self;
}
@end
