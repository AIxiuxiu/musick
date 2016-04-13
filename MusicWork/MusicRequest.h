//
//  MusicRequest.h
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicRequest : NSObject

@property (nonatomic,strong) NSMutableArray *playlist;

-(void)getPlayListCompletionHandler:(void(^)())handler;

@end
