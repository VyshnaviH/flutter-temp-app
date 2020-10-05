import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import '../util/utils.dart' as util;

import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _WeatherState();
  }
}

class _WeatherState extends State<Weather> {
  void showStuff() async {
    Map data = await getWeather(util.apiId, util.defaultCity);
    debugPrint('hii');
    debugPrint(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weather App"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu), onPressed: () => showStuff())
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
              child: new Image.asset(
            'assets/back1.jpg',
            width: 490,
            height: 1200,
            fit: BoxFit.fill,
          )),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10, 15, 0),
            child: new Text(
              "Delhi",
              style: new TextStyle(fontSize: 40),
            ),
          ),
          new Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(20.0, 10, 15, 20),
            child: updateTempWidget("delhi"),
          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String apiId, String city) async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city,in&appid=${util.apiId}&units=matric';

    http.Response response = await http.get(apiUrl);

    return jsonDecode(response.body);
  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
        future: getWeather(util.apiId, city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return new Container(
                child: new Text(
                    (content["main"]['temp'] / 10).toString()+" *C",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      backgroundColor: Colors.white,
                    ),
                  ),
                );
          } else
            return new Container();
        });
  }
}
