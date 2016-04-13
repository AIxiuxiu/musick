//
//  MusicRequest.m
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//
#define kPlaylistURL @"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"

#import "MusicRequest.h"
#import "MusicInfo.h"
@implementation MusicRequest

-(NSMutableArray *)playlist
{
    if (!_playlist) {
        _playlist = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _playlist;
}

-(void)getPlayListCompletionHandler:(void(^)())handler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //每次调用该获取接口内容的方法，先清除播放列表中已有的数据
        [self.playlist removeAllObjects];
        NSArray *tempArr = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:kPlaylistURL]];
        
        for (NSDictionary *dict in tempArr) {
            //创建Model对象
            MusicInfo *musicInfo = [MusicInfo new];
            //对应的向Model中的属性赋值
            [musicInfo setValuesForKeysWithDictionary:dict];
            [self.playlist addObject:musicInfo];
        }
        // NSLog(@"%@", tempArr);
        dispatch_async(dispatch_get_main_queue(), ^{
            //调用block
            handler();
        });
    });
}

@end
