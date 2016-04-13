//
//  MucickCollectionViewCell.h
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MucickCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UILabel *singer;


- (void)musickCellWithname:(NSString *)name
                      album:(NSString *)album
                     singer:(NSString *)singer;
@end
