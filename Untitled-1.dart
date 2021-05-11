import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


void main()
{
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
      
    }
}

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {

  bool playing=false;
  IconData playBtn=Icons.play_arrow_outlined;
//music app 
// object
  AudioPlayer _player;

  
  AudioCache cache;
  Duration position = new Duration();
  Duration musiclen = new Duration();

  // custom slider
  Widget slider()
  {
    return Slider.adaptive(
      activeColor: Colors.redAccent[400], inactiveColor: Colors.purple[800],
      value: position.inSeconds.toDouble(), max: musiclen.inSeconds.toDouble(), 
      onChanged: (value){
        seekToSec(value.toInt());
      }
      
      );
  }
  // seek function(position change in a track)
  void seekToSec(int sec){
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
_player =AudioPlayer();
cache =AudioCache(fixedPlayer: _player);


  }
  //now lets initialise our player
@override
void initState() { 
  
  super.initState();
  _player = AudioPlayer();
  cache = AudioCache(fixedPlayer: _player);

  //audioplayer time
  _player.durationHandler=(d){
    setState((){
      musiclen = d;
    });
  };
  // for moving cursor during play
  _player.positionHandler =(p){
    setState((){
      position = p;

    });
  };
  cache.load("Closer by chainsmokers,Halsey.mp3");// load the song

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepOrange[400],
              Colors.yellow[600]
            ]

          ),
        
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 44),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text("Rhythm",style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w600,

                  ),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text("Listen to your Beats",style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),),
                ),
                SizedBox(
                  height: 24,

                  ),
                //Music cover
                Center(
                  child: Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(image: AssetImage("assets/A1.jpg")),
                    ),
                  ),
                ),
                SizedBox(height: 17,),
                Center(
                  child: Text("Closer",style: TextStyle(
                    color: Colors.blueAccent[300],
                    fontSize: 23,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    background: Paint(
                      
                    )
                    ..style= PaintingStyle.stroke
                    ..strokeWidth=2
                    ..color= Colors.white12
                  ),),
                ),
                SizedBox(height: 27,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.only(
                       topLeft: Radius.elliptical(20,15),
                       topRight: Radius.elliptical(20,15),
                       bottomLeft: Radius.elliptical(20,15),
                       bottomRight: Radius.elliptical(20,15),
                      )
                    ),
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //controller
                        slider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          IconButton( iconSize: 40, color:Colors.brown, onPressed: (){},
                          icon: Icon(Icons.skip_previous_outlined),),
                          IconButton( iconSize: 44, color:Colors.brown, onPressed: (){
                            //play funtionality
                            if(!playing){
                              //to play
                              cache.play("Closer by chainsmokers,Halsey.mp3");
                              setState(() {
                                    playBtn=Icons.pause;
                                    playing=true;
                                                            });
                            }else{
                              _player.pause();
                              
                              setState(() {
                                    playBtn=Icons.play_arrow_outlined;
                                    playing= false;                        
                                                            });
                            }
                          },
                          icon: Icon(playBtn),
                          ),
                          IconButton( iconSize: 40, color:Colors.brown, onPressed: (){},
                          icon: Icon(Icons.skip_next_outlined),)
                        ],),
                      ],
                    ),
                  ),
                )

              ],

            ),
          ),
        
        
        ),
        
      ),
    );
      
    
  }
}