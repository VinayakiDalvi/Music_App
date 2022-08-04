import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String ApiKey = "a1a553f952ef1361761c02047c3c2f39";

class Details extends StatefulWidget {
  int track_id;
  Details(this.track_id);
  @override
  State<Details> createState() => _DetailsState(this.track_id);
}

class _DetailsState extends State<Details> {
  bool progress = false;
  int track_id;
  String song_name = '';
  String artist_name = '';
  String album_name = '';
  String lyrics = '';
  String CopyRight = '';
  String last_updated = '';
  int rating = 97;
  int explicit = 0;
  _DetailsState(this.track_id);
  @override
  initState() {
    Get_data();
  }

  void Get_data() async {
    var uriB = Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=$track_id&apikey=$ApiKey');
    var uriC = Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$track_id&apikey=$ApiKey');
    http.Response responseB = await http.get(uriB);
    http.Response responseC = await http.get(uriC);
    if (responseB.statusCode == 200) {
      var dataB = responseB.body;
      setState(() {
        song_name = jsonDecode(dataB)['message']['body']['track']['track_name'];
        artist_name =
            jsonDecode(dataB)['message']['body']['track']['artist_name'];
        album_name =
            jsonDecode(dataB)['message']['body']['track']['album_name'];
        rating = jsonDecode(dataB)['message']['body']['track']['track_rating'];
        explicit = jsonDecode(dataB)['message']['body']['track']['explicit'];
      });
      if (responseC.statusCode == 200) {
        var dataC = responseC.body;
        setState(() {
          lyrics =
              jsonDecode(dataC)['message']['body']['lyrics']['lyrics_body'];
          CopyRight = jsonDecode(dataC)['message']['body']['lyrics']
              ['lyrics_copyright'];
          last_updated =
              jsonDecode(dataC)['message']['body']['lyrics']['updated_time'];
          progress = true;
        });
        // print(song);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF1F1F20),
      appBar: AppBar(
          elevation: 2,
          backgroundColor: Color(0xFF1F1F20),
          title: Text('Lyrics',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              )),
          centerTitle: true),
      body: (progress == false)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('Assets/istockphoto-1369862786-170667a.jpg'),
                    fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color(0x64E0E3E7).withOpacity(0.1),
                                  offset: Offset(0, 2),
                                  spreadRadius: 1,
                                )
                              ],
                              border: Border(
                                  top: BorderSide(
                                      width: 3.0, color: Colors.black12),
                                  left: BorderSide(
                                      width: 3.0, color: Colors.black12),
                                  right: BorderSide(
                                      width: 3.0, color: Colors.black12),
                                  bottom: BorderSide(
                                      width: 3.0, color: Colors.black12)),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Center(
                              child: Text(
                                song_name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    color: Colors.white.withOpacity(0.7),
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 18, 10, 7),
                                child: Text(
                                  'Album Name:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 0, 10, 10),
                                child: Text(album_name,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white.withOpacity(0.8),
                                        fontFamily: 'Poppins')),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 18, 10, 7),
                                child: Text(
                                  'Artist Name:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 0, 10, 10),
                                child: Text(artist_name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white.withOpacity(0.8),
                                        fontFamily: 'Poppins')),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 18, 10, 7),
                                child: Text(
                                  'Rating:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 0, 10, 10),
                                child: Text(rating.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white.withOpacity(0.8),
                                        fontFamily: 'Poppins')),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 18, 10, 7),
                                child: Text(
                                  'Explicit:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 0, 10, 10),
                                child: Text((explicit == 1) ? 'true' : 'false',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white.withOpacity(0.8),
                                        fontFamily: 'Poppins')),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 18, 10, 10),
                                child: Text(
                                  'Lyrics:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white.withOpacity(0.9),
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 10, 10, 10),
                                child: Text(lyrics,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white.withOpacity(0.7),
                                        fontFamily: 'Poppins')),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 18, 10, 7),
                                child: Text(
                                  'Copyrights:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 0, 10, 10),
                                child: Text(CopyRight,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: 'Poppins')),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 18, 10, 7),
                                child: Text(
                                  'Last Updated:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18, 0, 10, 10),
                                child: Text(last_updated,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: 'Poppins')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
