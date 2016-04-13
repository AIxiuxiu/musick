//
//  MusicManager.m
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "MusicManager.h"
#import "MusicTimeFormatter.h"

@implementation MusicManager

static  MusicManager *musicManager = nil;
+(instancetype)musicManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicManager = [[MusicManager alloc] init];
    });
    return musicManager;
}

-(AVPlayer *)player{
    
    if (!_player) {
        _player = [[AVPlayer alloc]init];
    }
    return _player;
}

- (void)prepareMusic:(NSString *)url{
     AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    if (self.player.currentItem) {
       
        [self.player replaceCurrentItemWithPlayerItem:playerItem];
    }else{
        
        self.player = [AVPlayer playerWithPlayerItem:playerItem];
    }
}

- (void)musicPlay{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self.player play];
}

- (void)timerAction{
    if ([self.delegate respondsToSelector:@selector(didPlayChangeStatus:)]) {
        CGFloat currentTime = CMTimeGetSeconds(self.player.currentTime);
        [self.delegate didPlayChangeStatus:[MusicTimeFormatter getStringFormatBySeconds:currentTime]];
        NSLog(@"%f",currentTime);
    }
}

- (void)pause{
    [self.timer invalidate];
    self.timer = nil;
    [self.player pause];
}

- (void)musicSeekToTime:(float)time{
    [self.player seekToTime: CMTimeMake(time, 1)];
}

- (void)musicVolumn:(float)value{
    self.player.volume = value;
}



@end
