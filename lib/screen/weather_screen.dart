import 'dart:convert';
import 'dart:ui';
import 'package:demo_flutter/string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;
  String cityName = "Rajkot";

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final result = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=${ConstantValue.openWeatherApiKey}',
        ),
      );

      final data = jsonDecode(result.body);
      if (result.statusCode != 200) {
        throw 'Something went wrong!';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  /// convert kelvin into celsius
  String kelvinToCelsius(dynamic kelvin) {
    return (kelvin - 273.15).toStringAsFixed(2);
  }


  void refresh() {
    setState(() {
      weather = getCurrentWeather();
    });
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ConstantValue.appTitle,
          style: TextStyle(fontWeight: .bold),
        ),

        centerTitle: true,

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: refresh,
              icon: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),

      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final weatherData = data['list'][0];

          final temp = kelvinToCelsius(weatherData['main']['temp']);

          final currentSky = weatherData['weather'][0]['main'];
          final pressure = weatherData['main']['pressure'];
          final windSpeed = weatherData['wind']['speed'];
          final humidity = weatherData['main']['humidity'];

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(
                    width: .infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  "$temp °C",
                                  style: const TextStyle(
                                    fontWeight: .bold,
                                    fontSize: 32,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                Icon(
                                    currentSky == "Clouds" || currentSky == "Rain" ? Icons.cloud : Icons.sunny,
                                    size: 48
                                ),

                                const SizedBox(height: 16),

                                Text(
                                  currentSky,
                                  style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  headingText(ConstantValue.weatherForecast),
                  const SizedBox(height: 8),

                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){

                        final hourlyForecast = data['list'][index + 1];
                        final hourlyTime = hourlyForecast['dt_txt'].toString();
                        final hourlySky = hourlyForecast['weather'][0]['main'];
                        final hourlyTemp = kelvinToCelsius(
                          hourlyForecast['main']['temp']
                        );
                        final time = DateTime.parse(hourlyTime);

                        return weatherForecastCard(
                          time: DateFormat.j().format(time),
                          icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          value: hourlyTemp
                        );
                      }
                    ),
                  ),

                  const SizedBox(height: 20),
                  headingText(ConstantValue.additionalInfo),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: .spaceAround,
                    children: [
                      additionalInfo(Icons.water_drop, "Humidity", humidity.toString()),
                      additionalInfo(Icons.air, "Wind Speed", windSpeed.toString()),
                      additionalInfo(Icons.beach_access, "Pressure", pressure.toString()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// headings texts component
Widget headingText(String title) {
  return Text(title, style: TextStyle(fontSize: 24, fontWeight: .bold));
}

/// weather forecast component
Widget weatherForecastCard({required String time,required IconData icon,required String value}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),

      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 8,
            children: [
              Text(time, style: TextStyle(fontWeight: .bold, fontSize: 18)),

              Icon(icon, size: 45),

              Text(value,style: TextStyle(fontSize: 16),),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Additional Information component
Widget additionalInfo(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      spacing: 8,
      children: [
        Icon(icon, size: 32),

        Text(label),

        Text(value, style: TextStyle(fontWeight: .bold, fontSize: 16)),
      ],
    ),
  );
}
