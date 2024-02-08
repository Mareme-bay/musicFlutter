class Music
{
  String? title;
  String? preview;
  String? artist_name;
  String? artist_picture;

  //Music({this.title,this.preview,this.artist_name,this.artist_picture});

  Music.fromjson(Map<String,dynamic> jsondata )
  {
    title = jsondata['title'];
    preview = jsondata['preview'];
    artist_name =     jsondata['artist']['name'];
    artist_picture = jsondata['artist']['picture_medium'];

  }





}