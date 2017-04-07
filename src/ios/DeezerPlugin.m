/********* cordova-plugin-deezer-player.m Cordova Plugin Implementation *******/

#import "DeezerPlugin.h"
#import "DZRRequestManager.h"
#import "DZRModel.h"
#import "DZPlayer.h"

#define DEEZER_TOKEN_KEY @"DeezerTokenKey"
#define DEEZER_EXPIRATION_DATE_KEY @"DeezerExpirationDateKey"
#define DEEZER_USER_ID_KEY @"DeezerUserId"

@implementation DeezerPlugin
@synthesize connectionDelegate = _connectionDelegate;
@synthesize requestDelegate = _requestDelegate;
@synthesize deezerConnect = _deezerConnect;
@synthesize currentUser = _currentUser;

static DeezerPlugin* _sharedSessionManager = nil;
-(id)initWith:(NSString*)appId{
    if (self = [super init]) {
        _sharedSessionManager = self;
        _deezerConnect = [[DeezerConnect alloc] initWithAppId:appId andDelegate:self];
        [[DZRRequestManager defaultManager] setDzrConnect:_deezerConnect];
        [self retrieveTokenAndExpirationDate];
        NSLog(@"DeezerPlugin %@",[_deezerConnect userId]);
    }
    return self;
    
}
-(void)init:(CDVInvokedUrlCommand*)command{
    NSLog(@"DeezerPlugin %@",[command.arguments objectAtIndex:0]);
    if([self initWith:[command.arguments objectAtIndex:0]]){
        NSLog(@"DeezerPlugin init");
    }else{
        NSLog(@"DeezerPlugin init error");
    }
}
-(void)login:(CDVInvokedUrlCommand *)command{
    NSMutableArray *perm = [NSMutableArray array];
    [perm addObject:DeezerConnectPermissionBasicAccess];
    [perm addObject:DeezerConnectPermissionEmail];
    [perm addObject:DeezerConnectPermissionOfflineAccess];
    [perm addObject:DeezerConnectPermissionManageLibrary];
    [perm addObject:DeezerConnectPermissionDeleteLibrary];
    [perm addObject:DeezerConnectPermissionListeningHistory];
    
    [_deezerConnect authorize:perm];
    
    if( [[DZPlayer sharedPlayer] init]){
        NSLog(@"DeezerPlugin player init");
    }else{
        NSLog(@"DeezerPlugin player init error");
    }
}
-(void)logout:(CDVInvokedUrlCommand *)command{
    [self logOut];
}

-(void)getToken:(CDVInvokedUrlCommand*)command{
    NSLog(@"DeezerPlugin getToken %@",[_deezerConnect accessToken]);
    CDVPluginResult *pluginResult;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[_deezerConnect accessToken]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

-(void)doAction:(CDVInvokedUrlCommand*)command
{
    NSMutableDictionary *arr = [NSMutableDictionary dictionary];
    [arr setDictionary:[command.arguments objectAtIndex:0]];
    NSString *myCommand = [NSString stringWithFormat:@"%@",[arr valueForKey:@"command"]];
    if([myCommand isEqual:@"play"]){
        [self play:command];
    }else if ([myCommand isEqual:@"pause"]){
        [self pause:command];
    }else if ([myCommand isEqual:@"next"]){
        [self next:command];
    }else if ([myCommand isEqual:@"prev"]){
        [self prev:command];
    }
}
-(void)playerControl:(CDVInvokedUrlCommand*)command
{
    
    NSString *myCommand = [NSString stringWithFormat:@"%@",[command.arguments objectAtIndex:1]];
    if([myCommand isEqual:@"playAlbum"] ){
        [self playAlbum:command];
    }else if ([myCommand isEqual:@"playPlaylist"] ){
        [self playPlaylist:command];
    }else if ([myCommand isEqual:@"playTracks"] ){
        [self playTracks:command];
    }else if ([myCommand isEqual:@"changePosition"] ){
        [self seek:command];
    }
}
-(void)playTracks:(CDVInvokedUrlCommand *)command{
    NSMutableDictionary *arr = [NSMutableDictionary dictionary];
    [arr setDictionary:[command.arguments objectAtIndex:0]];
    [[DZPlayer sharedPlayer] playTrackWithIdentifier:[arr valueForKey:@"trackList"]];
}
-(void)playAlbum:(CDVInvokedUrlCommand *)command
{
    NSMutableDictionary *arr = [NSMutableDictionary dictionary];
    [arr setDictionary:[command.arguments objectAtIndex:0]];
    [[DZPlayer sharedPlayer] playAlbumWithIdentifier:[arr valueForKey:@"album_id"]];
}
-(void)playPlaylist:(CDVInvokedUrlCommand *)command
{
    NSMutableDictionary *arr = [NSMutableDictionary dictionary];
    [arr setDictionary:[command.arguments objectAtIndex:0]];
    [[DZPlayer sharedPlayer] playPlaylistWithIdentifier:[arr valueForKey:@"playlist_id"]];
    
}
-(void)next:(CDVInvokedUrlCommand *)command
{
    [[DZPlayer sharedPlayer] nextTrack];
}
-(void)prev:(CDVInvokedUrlCommand *)command
{
    [[DZPlayer sharedPlayer] previosTrack];
    
}
-(void)play:(CDVInvokedUrlCommand *)command
{
    [[DZPlayer sharedPlayer] play];
}
-(void)pause:(CDVInvokedUrlCommand *)command
{
    [[DZPlayer sharedPlayer] pause];
}
-(void)seek:(CDVInvokedUrlCommand*)command
{
    NSMutableDictionary *arr = [NSMutableDictionary dictionary];
    [arr setDictionary:[command.arguments objectAtIndex:0]];
    NSTimeInterval offset = ((NSNumber *)[arr valueForKey:@"offset"]).doubleValue;
    [[DZPlayer sharedPlayer].player setProgress:offset/100];
}
#pragma mark - Connection
/**************\
 |* Connection *|
 \**************/

// See http://www.deezer.com/fr/developers/simpleapi/permissions
// for a description of the permissions
- (void)connectToDeezerWithPermissions:(NSArray*)permissionsArray {
    [_deezerConnect authorize:permissionsArray];
}

- (void)disconnect
{
    [_deezerConnect logout];
}

- (void)logOut
{
    [self clearTokenAndExpirationDate];
    [self disconnect];
    [[DZPlayer sharedPlayer].player stop];
}

- (BOOL)isSessionValid {
    return [_deezerConnect isSessionValid];
}

#pragma mark - Token
// The token needs to be saved on the device
- (void)retrieveTokenAndExpirationDate {
    NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [_deezerConnect setAccessToken:[standardUserDefaults objectForKey:DEEZER_TOKEN_KEY]];
    [_deezerConnect setExpirationDate:[standardUserDefaults objectForKey:DEEZER_EXPIRATION_DATE_KEY]];
    [_deezerConnect setUserId:[standardUserDefaults objectForKey:DEEZER_USER_ID_KEY]];
}

- (void)saveToken:(NSString*)token andExpirationDate:(NSDate*)expirationDate forUserId:(NSString*)userId {
    NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:token forKey:DEEZER_TOKEN_KEY];
    [standardUserDefaults setObject:expirationDate forKey:DEEZER_EXPIRATION_DATE_KEY];
    [standardUserDefaults setObject:userId forKey:DEEZER_USER_ID_KEY];
    [standardUserDefaults synchronize];
}

- (void)clearTokenAndExpirationDate {
    NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults removeObjectForKey:DEEZER_TOKEN_KEY];
    [standardUserDefaults removeObjectForKey:DEEZER_EXPIRATION_DATE_KEY];
    [standardUserDefaults removeObjectForKey:DEEZER_USER_ID_KEY];
    [standardUserDefaults synchronize];
}

#pragma mark - DeezerSessionDelegate

- (void)deezerDidLogin {
    NSLog(@"Deezer did login access token %@ expirationDate %@ userId %@",[_deezerConnect accessToken],[_deezerConnect expirationDate],[_deezerConnect userId]);
    [self saveToken:[_deezerConnect accessToken] andExpirationDate:[_deezerConnect expirationDate] forUserId:[_deezerConnect userId]];
    if ([_connectionDelegate respondsToSelector:@selector(deezerSessionDidConnect)]) {
        [_connectionDelegate deezerSessionDidConnect];
    }
    [[self commandDelegate] evalJs:@"window.cordova.plugins.DeezerPlugin.events.onLogedIn(['hueta'])"];
}

- (void)deezerDidNotLogin:(BOOL)cancelled {
    NSLog(@"Deezer Did not login : %@", cancelled ? @"Cancelled" : @"Not Cancelled");
     [[self commandDelegate] evalJs:@"window.cordova.plugins.DeezerPlugin.events.onDidNotLogin(['Did not login'])"];
}

- (void)deezerDidLogout {
    NSLog(@"Deezer Did logout");
    if ([_connectionDelegate respondsToSelector:@selector(deezerSessionDidDisconnect)]) {
        [_connectionDelegate deezerSessionDidDisconnect];
    }
}



+ (DeezerPlugin*)sharedSession {
    /*  if (_sharedSessionManager == nil) {
     _sharedSessionManager = [[super alloc] init];
     }*/
    return _sharedSessionManager;
}
-(void)onEvents :(NSString *)array
{
    NSLog(@"%@",array);
    [self.commandDelegate evalJs:@"alert('111')"];
    /* NSMutableString *str = [NSMutableString stringWithFormat:@"DeezerPlugin.Events."];
     [self.commandDelegate evalJs:str];*/
}
+(void)bridge:(NSArray *)array{
    [[DeezerPlugin sharedSession]onEvents:@"!!!!!!!!!"];
    
}
- (void)player:(DZRPlayer *)player didPlay:(long long)playedBytes outOf:(long long)totalBytes {
    float progress = 0.0;
    if (totalBytes != 0) {
        progress = (double)playedBytes / (double)totalBytes;
    }
    NSLog(@"DeezerPlayer progress %f", progress);
}
@end

