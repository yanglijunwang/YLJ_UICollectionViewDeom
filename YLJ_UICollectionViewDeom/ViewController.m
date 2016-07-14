//
//  ViewController.m
//  YLJ_UICollectionViewDeom
//
//  Created by 杨礼军 on 16/7/14.
//  Copyright © 2016年 杨礼军. All rights reserved.
//

#import "ViewController.h"
#import "YLJ_WatrCollectionViewLayout.h"
#import "YLJ_WatrCollectionViewCell.h"
#import "YLJ_HeaderCollectionReusableView.h"
#import "YLJ_FootCollectionReusableView.h"
#import "UICollectionViewSimpleController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,YLJ_WatrCollectionViewLayoutDelegate>
@property (strong, nonatomic) UICollectionView *waterCollectionView;
@property (strong, nonatomic) YLJ_WatrCollectionViewLayout *waterLayout;
@property (strong, nonatomic) NSMutableArray *imageArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.waterLayout = [[YLJ_WatrCollectionViewLayout alloc] init];
    self.waterLayout.footViewHeight = 60;
    self.waterLayout.headerViewHeight = 100;
    self.waterLayout.delegate = self;
    
    
    self.waterCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.waterLayout];
    self.waterCollectionView.backgroundColor = [UIColor whiteColor];
    self.waterCollectionView.delegate = self;
    self.waterCollectionView.dataSource = self;
//    [self.view addSubview:self.waterCollectionView];
    
    
    [self.waterCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YLJ_WatrCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"waterCell"];
    [self.waterCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YLJ_HeaderCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:YLJ_UICollectionElementKindSectionHeader withReuseIdentifier:@"simpleHead"];
    
    [self.waterCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YLJ_FootCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:YLJ_UICollectionElementKindSectionFooter withReuseIdentifier:@"simpleFoot"];
    
    
    
    UILongPressGestureRecognizer *longGest = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGest:)];
    [self.waterCollectionView addGestureRecognizer:longGest];
    
    UIButton * buyt = [UIButton buttonWithType:UIButtonTypeCustom];
    buyt.backgroundColor = [UIColor cyanColor];
    buyt.frame = CGRectMake(100, 100, 100, 100);
    [buyt addTarget:self action:@selector(process) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyt];
    
}

-(void)process
{
    NSLog(@"fsdfsdfsdfsd");
    UICollectionViewSimpleController *ctr = [[UICollectionViewSimpleController alloc] init];
    ctr.view.backgroundColor = [UIColor whiteColor];
    ctr.title = @"fsfsdfsd";
    [self.navigationController pushViewController:ctr animated:YES];
}



- (void)longGest:(UILongPressGestureRecognizer *)gest
{
    switch (gest.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *touchIndexPath = [self.waterCollectionView indexPathForItemAtPoint:[gest locationInView:self.waterCollectionView]];
            if (touchIndexPath) {
                [self.waterCollectionView beginInteractiveMovementForItemAtIndexPath:touchIndexPath];
            }else{
                break;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.waterCollectionView updateInteractiveMovementTargetPosition:[gest locationInView:gest.view]];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.waterCollectionView endInteractiveMovement];
        }
            break;
        default:
            break;
    }
}

- (NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
        for(int i = 1; i <= 100; i++) {
            [_imageArr addObject:[NSString stringWithFormat:@"%d.jpg", i%20]];
        }
    }
    return _imageArr;
    
}


//设置head foot视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:YLJ_UICollectionElementKindSectionHeader]) {
        YLJ_HeaderCollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"simpleHead" forIndexPath:indexPath];
        return head;
    }else if([kind isEqualToString:YLJ_UICollectionElementKindSectionFooter]){
        YLJ_FootCollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"simpleFoot" forIndexPath:indexPath];
        return foot;
    }
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
{
    cell.contentView.alpha = 0;
    cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0, 0), 0);
    
    
    [UIView animateKeyframesWithDuration:.5 delay:0.0 options:0 animations:^{
        
        /**
         *  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
         */
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^{
            cell.contentView.alpha = .5;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.2, 1.2), 0);
            
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = 1;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), 0);
            
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YLJ_WatrCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"waterCell" forIndexPath:indexPath];
    
    cell.show_MyImage.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    cell.image_Name.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    
    return cell;
}

- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
    return [UIImage imageNamed:[self.imageArr objectAtIndex:indexPath.row]];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(YLJ_WatrCollectionViewLayout *)layout heightOfItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    return [self imageAtIndexPath:indexPath].size.height/[self imageAtIndexPath:indexPath].size.width * itemWidth;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    //长按支持的事件  cut: paste: copy:
    if ([NSStringFromSelector(action) isEqualToString:@"cut:"]) {
        return YES;
    }else if ([NSStringFromSelector(action) isEqualToString:@"paste:"]){
        return YES;
    }else if ([NSStringFromSelector(action) isEqualToString:@"copy:"]){
        return YES;
    }
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    NSLog(@"点击了%@事件", NSStringFromSelector(action));
    
    if ([NSStringFromSelector(action) isEqualToString:@"cut:"]) {
        NSArray* itemPaths = @[indexPath];
        [self.imageArr removeObjectAtIndex:indexPath.row];
        [self.waterCollectionView deleteItemsAtIndexPaths:itemPaths];
    }else if ([NSStringFromSelector(action) isEqualToString:@"paste:"]){
        
    }else if ([NSStringFromSelector(action) isEqualToString:@"copy:"]){
        NSArray* itemPaths = @[indexPath];
        [self.imageArr insertObject:self.imageArr[indexPath.row] atIndex:indexPath.row];
        [self.waterCollectionView insertItemsAtIndexPaths:itemPaths];
    }
    
    
}


- (void)moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    if(sourceIndexPath.row != destinationIndexPath.row){
        NSString *value = self.imageArr[sourceIndexPath.row];
        [self.imageArr removeObjectAtIndex:sourceIndexPath.row];
        [self.imageArr insertObject:value atIndex:destinationIndexPath.row];
        NSLog(@"from:%ld      to:%ld", sourceIndexPath.row, destinationIndexPath.row);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
