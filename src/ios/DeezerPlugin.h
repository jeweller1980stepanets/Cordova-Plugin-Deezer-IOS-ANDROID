#import <Cordova/CDV.h>
#import "DeezerConnect.h"
#import "DeezerRequestDelegate.h"
#import "DZRPlayer.h"
//#import "DeezerSession.h"
@class DeezerUser;
@protocol DeezerSessionConnectionDelegate;
@protocol DeezerSessionRequestDelegate;

@interface DeezerPlugin : CDVPlugin<DeezerSessionDelegate>
// Member variables go here.

@property (nonatomic, weak)   id<DeezerSessionConnectionDelegate> connectionDelegate;
@property (nonatomic, weak)   id<DeezerSessionRequestDelegate>    requestDelegate;
@property (nonatomic, readonly) DeezerConnect* deezerConnect;
@property (nonatomic, strong)   DeezerUser* currentUser;


+ (DeezerPlugin*)sharedSession;
-(void)init:(CDVInvokedUrlCommand*)command;
-(void)login:(CDVInvokedUrlCommand *)command;
-(void)logout:(CDVInvokedUrlCommand *)command;
-(void)playTracks:(CDVInvokedUrlCommand *)command;
-(void)playAlbum:(CDVInvokedUrlCommand *)command;
-(void)playPlaylist:(CDVInvokedUrlCommand *)command;
-(void)next:(CDVInvokedUrlCommand *)command;
-(void)prev:(CDVInvokedUrlCommand *)command;
-(void)play:(CDVInvokedUrlCommand *)command;
-(void)pause:(CDVInvokedUrlCommand *)command;
-(void) onEvents:(NSString *)array;
+(void)bridge:(NSArray *)array;
-(void)seek:(CDVInvokedUrlCommand*)command;
-(void)getToken:(CDVInvokedUrlCommand*)command;

-(void)doAction:(CDVInvokedUrlCommand*)command;
-(void)playerControl:(CDVInvokedUrlCommand*)command;
#pragma mark - Connection
- (void)connectToDeezerWithPermissions:(NSArray*)permissionsArray;
- (void)disconnect;
- (void)logOut;
- (BOOL)isSessionValid;
- (void)retrieveTokenAndExpirationDate;
@end


@protocol DeezerSessionConnectionDelegate <NSObject>
@optional
- (void)deezerSessionDidConnect;
- (void)deezerSessionConnectionDidFailWithError:(NSError*)error;
- (void)deezerSessionDidDisconnect;
@end


@protocol DeezerSessionRequestDelegate <NSObject>

@optional
- (void)deezerSessionRequestDidReceiveResponse:(NSData*)data;
- (void)deezerSessionRequestDidFailWithError:(NSError*)error;


@end
