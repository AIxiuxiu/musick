//
//  ViewController.m
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "ViewController.h"
#import "MucickCollectionViewCell.h"
#import "MusicRequest.h"
#import "UIImageView+WebCache.h"
#import "MusicInfo.h"
#import "UIImageView+Extern.h"
#import "MusicViewController.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *chatDemoCollectionView;
@property (nonatomic, strong) NSArray *musicLists;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"音乐";
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSLog(@"%@",NSHomeDirectory());
    self.chatDemoCollectionView.allowsMultipleSelection = NO; //禁止多选
    [self.view addSubview:self.chatDemoCollectionView];
    
    MusicRequest *musicRequest = [[MusicRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [musicRequest getPlayListCompletionHandler:^{
        [weakSelf.chatDemoCollectionView reloadData];
        weakSelf.musicLists = musicRequest.playlist;
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //删除选中
    [self.chatDemoCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    [self prepareVisibleCellsForAnimation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self animateVisibleCells];
}

#pragma mark - Private

- (void)prepareVisibleCellsForAnimation {
    NSArray *visibleItemsIndexPahts = [self.chatDemoCollectionView indexPathsForVisibleItems];
    NSArray * indexPaths = [self bubbleSort:visibleItemsIndexPahts];
    for (int i = 0; i < [indexPaths count]; i++) {
        NSIndexPath *indexPath = indexPaths[i];
        UICollectionViewCell * cell = [self.chatDemoCollectionView cellForItemAtIndexPath:indexPath];
        cell.frame = CGRectMake(-CGRectGetWidth(cell.bounds), cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
        cell.alpha = 0.f;
    }
}

- (void)animateVisibleCells {
    NSArray *visibleItemsIndexPahts = [self.chatDemoCollectionView indexPathsForVisibleItems];
    NSArray * indexPaths = [self bubbleSort:visibleItemsIndexPahts];
    for (int i = 0; i < [indexPaths count]; i++) {
        NSIndexPath *indexPath = indexPaths[i];
        UICollectionViewCell * cell = [self.chatDemoCollectionView cellForItemAtIndexPath:indexPath];
        
        cell.alpha = 1.f;
        [UIView animateWithDuration:0.25f
                              delay:i * 0.1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             cell.frame = CGRectMake(0.f, cell.frame.origin.y, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds));
                         }
                         completion:nil];
    }
}

- (NSArray *)bubbleSort:(NSArray *)array{
    NSMutableArray *indexPaths = [NSMutableArray arrayWithArray:array];
    BOOL exchanged = NO;
    NSIndexPath *indexPathTemp = nil;
    for (int i = 0; i < indexPaths.count; i++) {
        exchanged = NO;
        for (int j = 0; j < (indexPaths.count - 1 - i); j++) {
            NSInteger rowj = [(NSIndexPath *)indexPaths[j] row];
            NSInteger rowj1 = [(NSIndexPath *)indexPaths[j + 1] row];
            if (rowj > rowj1) {
                exchanged = YES;
                indexPathTemp = indexPaths[j + 1];
                [indexPaths removeObjectAtIndex:j + 1];
                [indexPaths insertObject:indexPathTemp atIndex:j];
            }
        }
    }
    return [NSArray arrayWithArray:indexPaths];
}


//屏幕旋转  需要进行约束
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //更新CollectionView
        [self.chatDemoCollectionView performBatchUpdates:nil completion:nil];
    }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.musicLists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MucickCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MucickCollectionViewCell class]) forIndexPath:indexPath];

    MusicInfo *info = self.musicLists[indexPath.row];
    

    [cell.ImageView loadImageUrlStr:info.picUrl placeHolderImageName:nil radius:40];
    [cell musickCellWithname:info.name album:info.album singer:info.singer];
    //cell.ImageView.layer.cornerRadius = 40;
    //cell.ImageView.layer.masksToBounds = YES;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return CGSizeMake(CGRectGetWidth(self.view.bounds), layout.itemSize.height);
}
//cell间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MusicViewController *musicVC = (MusicViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = [self.chatDemoCollectionView indexPathForCell:sender];
    musicVC.musicLists = self.musicLists;
    musicVC.index = indexPath.row;
}

@end
