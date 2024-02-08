import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/Music.dart';

class ArtistPage extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 255, 224),
        appBar: AppBar(
          title: Text("Music"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 250, 145),
          
        )
    );
    }
}