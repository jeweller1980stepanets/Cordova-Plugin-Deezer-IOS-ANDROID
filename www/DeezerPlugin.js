
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
             //[player_position]
             [{"offset" : player_position,"index" : 0, "autoplay" : true , "addToQueue" : false, "changePosition" : player_position}, "changePosition"]
             )
    },
    
    Events : {
        on_position : function(args){
            //args[0] - position, args[1] - duration
        },
        on_buffering : function (args){
            //(args[0] * 100) + " %";
        },
        on_current_track : function(arg){
            alert('!!');
            //arg[1] - Title of track
        },
        on_player_play : function(){},
        on_track_ended : function(){},
        on_pause : function(){},
        on_change_volume : function(args){
            //args[0] - left value, args[1] - right value
        }
        
    }
    
};



