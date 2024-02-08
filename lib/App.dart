import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/Music.dart';

class App extends StatelessWidget {
   App({super.key});

  TextEditingController _controller = TextEditingController();
  String recherche ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Music>>(
        future: getArtiste(recherche),
        builder: (context, snapshot){
        if(snapshot.hasData)
        {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder:(BuildContext context, int position)
            {
                return GestureDetector
                (
                  onTap: () async{
                    final player = AudioPlayer();
                    await player.play(UrlSource(snapshot.data![position].preview!));
                  },
                  child: ListTile(
                              leading: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(snapshot.data![position].artist_picture!),
                              ),
                              title: Text(snapshot.data![position].title!),
                              subtitle: Text(snapshot.data![position].artist_name!),
                              trailing: Icon(Icons.play_arrow),
                            ),
                );
            }
            );
          
          /*ListTile(
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(snapshot.data![0].artist_picture!),
            ),
            title: Text(snapshot.data![0].title!),
            subtitle: Text(snapshot.data![0].artist_name!),
            trailing: Icon(Icons.play_arrow),
          );*/
        }
        else if(snapshot.hasError)
        {
          return Center(child: Text(snapshot.error.toString()),);
        }
        else 
        {
          return CircularProgressIndicator();

        }
      },),
      appBar: AppBar(
        title: Text("Music"),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
          showDialog(context: context, 
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Please insert the artist name"),
              content: TextField(
                controller: _controller,
              ),
              actions: [
              ElevatedButton(
                
                onPressed: (){
                  recherche =   _controller.text;
                  
                  Navigator.pop(context);
                  

              }, child: Text("Valider")),

               ElevatedButton(
                
                onPressed: (){
                  Navigator.pop(context);

              }, child: Text("Annuler"))
              
              ],
             
            );

          });
      },
      child: Icon(Icons.search),
      ),

    );
  }

  Future< List<Music>> getArtiste(String user_Artiste)  async 
  {
    List<Music> listMusic = [];
    var response =  await http.get(Uri.parse("http://api.deezer.com/search?q=eminem"));

    var responseJson =  jsonDecode(response.body);


    for(var mus in responseJson["data"])
    {
      listMusic.add(Music.fromjson(mus));
    }

    return listMusic;


  }
}