
[![N|Solid](http://procoders.tech/art/powered.png)](http://procoders.tech/)

# Cordova Deezer Plugin
This plugin included all main functions of audio player for Deezer service

## Installation
**At first you must registering you application with** [deezer] [PlDb]
A screen looking like the one just above will be presented to you. If you already created your application, click on its name in the left sidebar (it will appear under MY APPS) and configure it as described later in this section. Otherwise, click the button Create a new Application to create one.

![Image alt](https://github.com/jeweller1980stepanets/image/blob/master/dz1.png)

The process is not finished yet though. You now need to configure the iOS section of your Deezer application to be able to let users log in with their Deezer account. In order to proceed, click the "Edit Application" button in the top right corner of the screen.

![Image alt](https://github.com/jeweller1980stepanets/image/blob/master/dz2.png)

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

**Demo applications**
> - https://github.com/jeweller1980stepanets/DeezerTestAppIOS for iOS
> - https://github.com/jeweller1980stepanets/DeezerTestAppAndroid for android

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
```
> *appId* - your application id in Deezer

```javascript
deezerCordova.login(onSuccess, onError);
deezerCordova.playTrack(onSuccess, onError,trackId);
deezerCordova.playAlbum(onSuccess, onError,albumId);
deezerCordova.playPlaylist(onSuccess, onError,playlistId);
deezerCordova.playRadio(onSuccess, onError,radioId);
```
***Exemple***

> deezerCordova.playTrack(saccess,error,"129938604");

```javascript
deezerCordova.play();
deezerCordova.pause();
deezerCordova.next();
deezerCordova.prev();
deezerCordova.seek(position);
```
> *position* - value between 0 - 100%

```javascript
deezerCordova.logout();
deezerCordova.setVolume(val1,val2);
```
> *val1,val2* - the volume for the left and right channel (between 0-100%)


## Events
```javascript
deezerCordova.events.onPosition = function(args){};
```
> *args[0]* - position, args[1] - duration

```javascript
deezerCordova.events.onBuffering = function (args){},
```
> *args[0]* - persent of buferring

```javascript
deezerCordova.events.onCurrentTrack = function(arg){},
```
>*arg[1]* - Title of track

```javascript
deezerCordova.events.onPlayerPlay = function(){},
deezerCordova.events.onTrackEnded = function(){},
deezerCordova.events.onPause = function(){},
deezerCordova.events.onChangeVolume = function(args){}
```
> *args[0]* - the volume for the left channel (between 0 and 100%), args[1] -  the volume for the right channel (between 0 and 100%)


**Exemle for subscribe:**
```javascript
deezerCordova.events.onPosition = function(args){..`code`..}
```

###Authors
- Aleksey Stepanets

[PlDb]:<http://developers.deezer.com/sdk/ios>


[![N|Solid](http://procoders.tech/art/powered.png)](http://procoders.tech/)

