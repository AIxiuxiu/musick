//
//  MusicViewController.m
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicTimeFormatter.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Extern.h"
#import "UIImage+Extern.m"

@interface MusicViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;
@property (weak, nonatomic) IBOutlet UIView *radiuView;
@property (weak, nonatomic) IBOutlet UIImageView *radiuImageView;
@property (weak, nonatomic) IBOutlet UISlider *playSlider;
@property (weak, nonatomic) IBOutlet UIButton *upSongButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *downSongButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    self.radiuView.layer.cornerRadius = 100;
    self.radiuView.layer.masksToBounds = YES;
    
    
    self.radiuImageView.layer.cornerRadius = 75;
    self.radiuImageView.layer.masksToBounds = YES;
    
    [MusicManager musicManager].delegate = self;
    self.currentIndex = self.index;
    MusicInfo *info = self.musicLists[self.index];
     //self.playSlider.minimumTrackTintColor = [UIColor blueColor];
    //[self.playSlider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    [self updateMusicView:info];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[MusicManager musicManager] pause];
}

- (void)updateMusicView:(MusicInfo *)info{
    NSInteger seconds = [info.duration intValue] / 1000;
    self.playSlider.maximumValue = seconds;
    self.timeLabel.text = [MusicTimeFormatter getStringFormatBySeconds:seconds];
    [self.blurImageView sd_setImageWithURL:[NSURL URLWithString:info.blurPicUrl]];
    [self.radiuImageView sd_setImageWithURL:[NSURL URLWithString:info.picUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIColor *color = [UIImage mostColor:image];
        self.radiuView.backgroundColor = [color colorWithAlphaComponent:0.4];
    }];
}

- (void)didPlayChangeStatus:(NSString *)time{
    self.playSlider.value = [MusicTimeFormatter getSecondsFormatByString:time];
    self.radiuView.transform = CGAffineTransformRotate(self.radiuView.transform, M_PI/36);
}

- (IBAction)sigderValueChange:(id)sender {
    UISlider *slider = sender;
    [[MusicManager musicManager] musicSeekToTime:slider.value];
}


- (IBAction)upSongButtonClicked:(id)sender {
    self.currentIndex = self.currentIndex + 1 < self.musicLists.count ? self.currentIndex + 1 : 0;
    MusicInfo *info = self.musicLists[self.currentIndex];
    [self updateMusicView:info];
    [[MusicManager musicManager] prepareMusic:info.mp3Url];
}

- (IBAction)playButtonClicked:(id)sender {
    UIButton *playbutton = sender;
    if ([playbutton.titleLabel.text isEqualToString:@"播放"]) {
        [[MusicManager musicManager] musicPlay];
        [playbutton setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        [[MusicManager musicManager] pause];
        [playbutton setTitle:@"播放" forState:UIControlStateNormal];
    }
}

- (IBAction)downSongButtonClicked:(id)sender {
    self.currentIndex = self.currentIndex - 1 < 0 ? self.musicLists.count - 1 : self.currentIndex - 1;
    MusicInfo *info = self.musicLists[self.currentIndex];
    [self updateMusicView:info];
    [[MusicManager musicManager] prepareMusic:info.mp3Url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
