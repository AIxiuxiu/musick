//
//  MusicInfo.h
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicInfo : NSObject

@property (nonatomic, copy) NSString * mp3Url;       // 歌曲的Url
@property (nonatomic, copy) NSString * ID;           // 歌曲的id
@property (nonatomic, copy) NSString * name;         // 歌曲的名称
@property (nonatomic, copy) NSString * picUrl;       // 歌曲的图片Url
@property (nonatomic, copy) NSString * blurPicUrl;   // 歌曲的模糊图片Url
@property (nonatomic, copy) NSString * album;        // 歌曲的专辑
@property (nonatomic, copy) NSString * singer;       // 歌曲的歌手
@property (nonatomic, copy) NSString * duration;     // 歌曲的时长
@property (nonatomic, copy) NSString * artists_name; // 歌曲的作者
@property (nonatomic, strong) NSMutableArray * timeForLyric;  // 时间对应的歌词

@end
