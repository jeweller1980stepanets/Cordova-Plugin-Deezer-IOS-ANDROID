
var exec = require('cordova/exec');

module.exports = {
    init : function(a,b,appId){
        exec(
             function(){},
             function(){},
             "DeezerPlugin",
             "init",
             [appId]
             
             )
    },
    login : function(a,b) {
        
        exec(
             function() {},
             function() {},
             "DeezerPlugin",
             "login",
             []
             )
    },
playTrack:function(a,b,trackId){
    exec(
         function() {},
         function() {},
         "DeezerPlugin",
         "playerControl",
         [{"offset" : 0, "index" : 0, "autoplay" : true , "addToQueue" : false, "trackList" : trackId}, "playTracks"]
         )
},
play:function(){
    exec(
         function() {},
         function() {},
         "DeezerPlugin",
         "doAction",
         [{"command" : "play"}]
         )
},
playAlbum:function(a,b,albumId){
    exec(
         function() {},
         function() {},
         "DeezerPlugin",
         "playerControl",
         [{"offset" : 0, "index" : 0, "autoplay" : true , "addToQueue" : false, "album_id" : albumId}, "playAlbum"]
         )
},
playPlaylist:function(a,b,playListId){
    exec(
         function() {},
         function() {},
         "DeezerPlugin",
         "playerControl",
         [{"offset" : 0, "index" : 0, "autoplay" : true, "addToQueue" : false, "playlist_id" : playListId}, "playPlaylist"]
         )
},
    
    pause : function(){
        exec(
             function(){},
             function(){},
             "DeezerPlugin",
             "doAction",
             [{"command" : "pause"}]
             )
    },
    next : function(){
        exec(
             function(){},
             function(){},
             "DeezerPlugin",
             "doAction",
             [{"command" : "next"}]
             )
    },
    prev : function(){
        exec(
             function(){},
             function(){},
             "DeezerPlugin",
             "doAction",
             [{"command" : "prev"}]
             )
    },
    logout : function(){
        exec(
             function(){},
             function(){},
             "DeezerPlugin",
             "logout",
             []
             )
    },
    seek : function(player_position){
        exec(
             function(){},
             function(){},
             "DeezerPlugin",
             "playerControl",
             [{"offset" : player_position,"index" : 0, "autoplay" : true , "addToQueue" : false, "changePosition" : player_position}, "changePosition"]
             )
    },
    seekTo : function(player_position){
        exec(
            function(){},
            function(){},
            "DeezerPlugin",
            "playerControl",
                    //[player_position]
            [{"offset" : player_position,"index" : 0, "autoplay" : true , "addToQueue" : false, "changePositionTo" : player_position}, "changePositionTo"]
            )
    },
    getToken : function(succes,error){
                    exec(
                        succes,//function(res){alert(res);},//res - TOKEN//
                        error,//function(){console.log("error");},
                        "DeezerPlugin",
                        "getToken",
                        []
                    )
    },
    setVolume: function(val1,val2){
        exec(
            null,
            null,
            "DeezerPlugin",
            "playerControl",
            [{"setVolume1" : val1, "setVolume2" : val2},"setVolume"]
        )
    },
    events : {
        onPosition : function(args){
            //args[0] - position, args[1] - duration
        },
        onBuffering : function (args){
            //(args[0] * 100) + " %";
        },
        onCurrentTrack : function(arg){
            //arg[1] - Title of track
        },
        onPlayerPlay : function(){},
        onTrackEnded : function(){},
        onPause : function(){},
        onChangeVolume : function(args){
            //args[0] - left value, args[1] - right value
        },
        onLogedIn :function(arg){
                    alert(arg);
        },
        onDidNotLogin:function(arg){
               alert(arg);
        },
        onError:function(arg){
            alert(arg[0]);
        }
    }
    
};



