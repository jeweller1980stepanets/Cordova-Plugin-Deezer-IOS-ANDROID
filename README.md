
[![N|Solid](http://procoders.tech/art/powered.png)](http://procoders.tech/)

# Cordova Deezer Plugin
This plugin included all main functions of audio player for Deezer servise

## Installation
**At first you must registering you application with** [deezer] [PlDb]

You may install latest version from master
```sh
cordova plugin add https://github.com/jeweller1980stepanets/Cordova-Plugin-Deezer-IOS-ANDROID
```
### Removing the Plugin from project
```sh
cordova plugin rm com.procoders.deezer
```
## Supported Platforms
> - Android
> - iOS


### Platform specific
:warning: for iOS platform not implemented method `setVolume()` and `event on_chenge_volume()`
It will be fixed when this methods will be in Deezer SDK
**Example applications**
> - https://github.com/jeweller1980stepanets/DeezerTestAppIOS for iOS
> - https://github.com/jeweller1980stepanets/DeezerTestAppAndroid.git for android
## Using the plugin
> **You must have premium account from Deezer servise for playing music**

After device is ready you must defined the main variable:
```javascript
var deezerCordova = window.cordova.plugins.DeezerPlugin;
```
:thumbsup: *After this you may use all method in your code.*

## Methods
All methods returning promises, but you can also use standard callback functions.

```javascript
deezerCordova.init(onSuccess, onError,appId);
deezerCordova.login(onSuccess, onError);
deezerCordova.playTrack(onSuccess, onError,trackId);
deezerCordova.playAlbum(onSuccess, onError,albumId);
deezerCordova.playPlaylist(onSuccess, onError,playlistId);
deezerCordova.playRadio(onSuccess, onError,radioId);
deezerCordova.play();
deezerCordova.pause();
deezerCordova.next();
deezerCordova.prev();
deezerCordova.seek(position);//value between 0 - 100%
deezerCordova.logout();
deezerCordova.setVolume(val1,val2);//val1,val2 - the volume for the left and right channel (between 0-100%)
```

## Events
```javascript
on_position : function(args){},//args[0] - position, args[1] - duration
on_buffering : function (args){},//(args[0] * 100) + " %";
on_current_track : function(arg){},//arg[1] - Title of track
on_player_play : function(){},
on_track_ended : function(){},
on_pause : function(){},
on_change_volume : function(args){}//args[0] - the volume for the left channel (between 0 and 100%), args[1] -  the volume for the right channel (between 0 and 100%)
```

**Exemle for subscribe:**
```javascript
deezerCordova.Events.on_position = function(args){..`code`..}
```


[PlDb]:<http://developers.deezer.com/sdk/ios>


[![N|Solid](http://procoders.tech/art/powered.png)](http://procoders.tech/)

