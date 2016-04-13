//
//  MusicManager.h
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol MusicManagerDelegate <NSObject>

- (void)didPlayChangeStatus:(NSString *)time;

@end

@interface MusicManager : NSObject

@property (nonatomic, weak) id<MusicManagerDelegate>delegate;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSTimer *timer;

+(instancetype)musicManager;

- (void)prepareMusic:(NSString *)url;
- (void)musicPlay;
- (void)pause;
- (void)musicSeekToTime:(float)time;
- (void)musicVolumn:(float)value;


@end
