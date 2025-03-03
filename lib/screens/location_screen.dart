import 'package:flutter/material.dart';
import 'package:clima_flutter2/utilities/constants.dart';
import 'package:clima_flutter2/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();
  int? temperature;
  String? weatherIcon;
  String? cityName;
 String? weatherMessage;

  @override
  void initState(){
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI (dynamic weatherData){
    print(weatherData);
    setState(() {
      if (weatherData == null){
        temperature = 0;
        weatherIcon = 'error';
        weatherMessage ='Unabale to get weather Data';
        cityName = '';
      }
     double temp = weatherData ['main']['temp'];
     temperature = temp.toInt();
    weatherMessage = weather.getMessage(temperature!);
     var condition = weatherData ['weather'] [0] ['id'];
     weatherIcon = weather.getWeatherIcon(condition);
     cityName = weatherData ['name'];
    });
    // error area
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      var weatherData =  await weather.getWeatherLocation();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// double temperature = decodedData ['main' ]['temp'];
// int condition = decodedData ['weather'] [0] ['id'];
// String cityName = decodedData (' name');