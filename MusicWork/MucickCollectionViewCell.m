//
//  MucickCollectionViewCell.m
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "MucickCollectionViewCell.h"

@implementation MucickCollectionViewCell



- (void)musickCellWithname:(NSString *)name
                     album:(NSString *)album
                     singer:(NSString *)singer{
    self.nameLabel.text = name;
    self.albumLabel.text = album;
    self.singer.text = singer;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}

@end
