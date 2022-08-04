import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'DetailsPage.dart';
import 'dart:convert';

const String ApiKey = "a1a553f952ef1361761c02047c3c2f39";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List songs = [];
  bool progress = false;
  StreamController<bool>? Mystream = StreamController();

  @override
  initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((event) {
      final connection = event == InternetConnectionStatus.connected;
      Mystream?.sink.add(connection);
    });
    Get_data();
  }

  void Get_data() async {
    var uri = Uri.parse(
        "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$ApiKey");
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      var Vinayaki = jsonDecode(data)['message']['body']['track_list'];
      setState(() {
        songs = Vinayaki;
        progress = true;
      });

      //print(Vinayaki);
    } else {
      songs = [];
      print(response.statusCode);
    }

    //print(response.statusCode);
    //print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<bool>(
        stream: Mystream?.stream,
        builder: (context, snapshot) {
          return (snapshot.data == true)
              ? Scaffold(
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
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          height: size.height,
                          width: size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'Assets/istockphoto-1369862786-170667a.jpg'),
                                fit: BoxFit.cover),
                          ),
                          child: ListView.builder(
                              itemCount: songs.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Details(
                                          songs[index]['track']['track_id']);
                                    }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Container(
                                      width: size.width * 0.75,
                                      height: size.height * 0.1,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 3,
                                            color: Color(0x64E0E3E7)
                                                .withOpacity(0.1),
                                            offset: Offset(0, 2),
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              songs[index]['track']
                                                  ['track_name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                songs[index]['track']
                                                    ['artist_name'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    fontFamily: 'Poppins'))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })),
                )
              : Scaffold(
                  backgroundColor: Color(0xFF1F1F20),
                  body: Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'Assets/istockphoto-1369862786-170667a.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 200,
                        width: 350,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 20,
                          title: Text(
                            'ERROR',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          content: Text(
                            'Internet Connection Lost',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ));
        });
  }
}
