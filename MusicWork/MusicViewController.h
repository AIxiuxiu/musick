//
//  MusicViewController.h
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicInfo.h"
#import "MusicManager.h"

@interface MusicViewController : UIViewController<MusicManagerDelegate>

@property (nonatomic, strong) NSArray *musicLists;
@property (nonatomic, assign) NSUInteger index;

@end
