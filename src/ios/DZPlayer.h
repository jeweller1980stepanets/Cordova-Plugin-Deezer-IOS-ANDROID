#import "DZRRequestManager.h"
#import "DZRPlayer.h"
#import "DeezerPlugin.h"
#import "DeezerConnect.h"

@interface DZPlayer : NSObject <DZRPlayerDelegate,DeezerSessionDelegate>

@property (nonatomic, readonly) DZRPlayer *player;
@property (nonatomic, strong) DZRRequestManager *manager;
@property (nonatomic, strong) id<DZRCancelable> trackRequest;
@property (nonatomic, readonly) DeezerPlugin *mView;
+ (DZPlayer*)sharedPlayer;

#pragma mark - Player methods
- (void)playTrackWithIdentifier:(NSString*)identifier;
- (void)playPlaylistWithIdentifier:(NSString*)identifier;
- (void)playAlbumWithIdentifier:(NSString*)identifier;
- (void)pause;
- (void)play;
- (void)nextTrack;
- (void)previosTrack;
- (BOOL)isPlaying;

@end
