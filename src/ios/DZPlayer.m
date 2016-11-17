
#import "DZPlayer.h"





@implementation DZPlayer

#pragma mark - NSObject

- (id)init {
    if (self = [super init]) {
        _player = [[DZRPlayer alloc] initWithConnection:[DeezerPlugin sharedSession].deezerConnect];
        _player.delegate = self;
        _player.shouldUpdateNowPlayingInfo = YES;
        
        _manager = [[DZRRequestManager defaultManager] subManager];
        
        
        
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }
    return self;
}

#pragma mark - Player methods

- (void)playTrackWithIdentifier:(NSString*)identifier {
    
    [self.trackRequest cancel];                                           // 5
    // 5
    self.trackRequest = [DZRTrack objectWithIdentifier:identifier requestManager:_manager callback:^(DZRTrack *track, NSError *error) {
        if(error){
            NSLog(@"ERROR %@",error );
        }else{
            NSLog(@"player play %@",track );
            [_player play:track];
        }
    }];
    
}
- (void)playPlaylistWithIdentifier:(NSString*)identifier
{
    [self.trackRequest cancel];                                           // 5
    self.trackRequest = [DZRPlaylist objectWithIdentifier:identifier requestManager:_manager callback:^(DZRPlaylist *list, NSError *error) {
        if(error){
            NSLog(@"ERROR %@",error );
        }else{
            NSLog(@"player play %@",list );
            [_player play:list];
            
        }
    }];
}
- (void)playAlbumWithIdentifier:(NSString*)identifier
{
    [self.trackRequest cancel];                                           // 5
    self.trackRequest = [DZRAlbum objectWithIdentifier:identifier requestManager:_manager callback:^(DZRAlbum *album, NSError *error) {
        if(error){
            NSLog(@"ERROR %@",error );
        }else{
            NSLog(@"player play %@",album );
            [_player play:album];
            
            
        }
    }];
}

- (void)pause {
    NSLog(@"DeezerPlayer pause");
    [_player pause];
    [[DeezerPlugin sharedSession].commandDelegate evalJs:@"window.cordova.plugins.DeezerPlugin.Events.on_pause()"];
}

- (void)play {
    NSLog(@"DeezerPlayer play");
    [_player play];
    
}

- (void)nextTrack {
    NSLog(@"DeezerPlayer next track");
    [_player next];
    
    
    
    // [[DeezerPlugin sharedSession] onEvents:@"))))))))))"];
}

- (void)previosTrack {
    NSLog(@"DeezerPlayer prev track");
    [_player previous];
    
}

- (BOOL)isPlaying {
    NSLog(@"DeezerPlayer is plaing");
    return [_player isPlaying];
}

#pragma mark DZRPlayerDelegate

- (void)player:(DZRPlayer *)player didBuffer:(long long)bufferedBytes outOf:(long long)totalBytes {
    NSLog(@"DeezerPlayer didBuffer %lld",totalBytes);
    
    float progress = 0.0;
    if (totalBytes != 0) {
        progress = (double)bufferedBytes / (double)totalBytes;
    }
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"window.cordova.plugins.DeezerPlugin.Events.on_buffering([%f])",progress];
    
    [[DeezerPlugin sharedSession].commandDelegate evalJs:str];
}

- (void)player:(DZRPlayer *)player didPlay:(long long)playedBytes outOf:(long long)totalBytes {
    float progress = 0.0;
    if (totalBytes != 0) {
        progress = (double)playedBytes / (double)totalBytes;
    }
    size_t sz = [_player currentTrackDuration];
    NSLog(@"DeezerPlayer progress %f", progress*sz);
    NSMutableString *str = [NSMutableString stringWithFormat:@"window.cordova.plugins.DeezerPlugin.Events.on_position([%f,%zu])",sz*progress,sz];
    
    [[DeezerPlugin sharedSession].commandDelegate evalJs:str];
    if(progress>=0.999 || totalBytes==playedBytes){
        [[DeezerPlugin sharedSession].commandDelegate evalJs:@"window.cordova.plugins.DeezerPlugin.Events.on_track_ended()"];
    }else{
        [[DeezerPlugin sharedSession].commandDelegate evalJs:@"window.cordova.plugins.DeezerPlugin.Events.on_player_play()"];
    }
}

- (void)player:(DZRPlayer *)player didStartPlayingTrack:(DZRTrack *)track {
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"window.cordova.plugins.DeezerPlugin.Events.on_current_track([123,'%@'])",track];
    
    [[DeezerPlugin sharedSession].commandDelegate evalJs:str];
    NSLog(@"DeezerPlayer didStartPlayinTrack %@",track);
}

- (void)playerDidPause:(DZRPlayer *)player {
    
    NSLog(@"DeezerPlayer DidPause");
}

#pragma mark - Singleton methods

static DZPlayer* _sharedPlayer = nil;

+ (DZPlayer*)sharedPlayer {
    if (_sharedPlayer == nil) {
        _sharedPlayer = [[super alloc] init];
    }
    
    return _sharedPlayer;
}

@end
