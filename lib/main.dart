import 'package:demo_flutter/screen/weather_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const WeatherScreen(),  // to change the screen call it here.
    );
  }
}
/*



      body: FutureBuilder(
          future: weather,
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Center(child: CircularProgressIndicator.adaptive(),);
              }
            if(snapshot.hasError)
              {
                return Center(child:Text(
                    snapshot.error.toString(),
                    style: const TextStyle(
                    ),),);
              }


             final data = snapshot.data!;

            final currentWeatherData = data['list'][0];
            final currentWeather = currentWeatherData ["main"]["temp"];
            final currentSky = currentWeatherData ['weather'] [0]["main"];
            final currentHumidity = currentWeatherData["main"]["humidity"];
            final currentWindSpeed = currentWeatherData["wind"]["speed"];
            final currentPressure = currentWeatherData["main"]["pressure"];


            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 20,
                children: [

                  TextField(
                    controller: cityController,
                    onSubmitted: (value) {
                      setState(() {
                        weather = getCurrentWeather(
                            cityName: cityController.text
                        );
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Enter city name..",
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          weather = getCurrentWeather(
                            cityName: cityController.text
                          );
                        });
                      }, icon: Icon(Icons.send)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3,
                          style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),

                  //main card
                  mainCard(
                      kelvinToCelsius(currentWeather),
                      currentSky == "Clouds" || currentSky == "Rainy" ?
                      Icons.cloud :
                      Icons.sunny,
                      currentSky),

                  //weather forecast text and cards
                  titleText(constStrings.weatherForecast),

                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                           final hourlyComponentData = data["list"][index+1];
                           final hourlyTime = hourlyComponentData ["dt_txt"].toString();
                           final time = DateTime.parse(hourlyTime);

                           final hourlySky = hourlyComponentData["weather"][0]["main"];

                           final hourlyTemperature = hourlyComponentData['main']['temp'];
                           return weatherForecastComponent(
                            DateFormat.j().format(time),
                            hourlySky == "Clouds" || hourlySky == "Rainy" ? Icons.cloud : Icons.sunny,
                            kelvinToCelsius(hourlyTemperature)
                          );
                        },),
                  ),

                  //additional information
                  titleText(constStrings.additionalInfo),
                  Row(
                    mainAxisAlignment: .spaceAround,
                    children: [
                      additionalComponent(
                          icon: Icons.water_drop, type: constStrings.humidity, value: currentHumidity.toString()),
                      additionalComponent(
                          icon: Icons.air, type: constStrings.wind_speed, value: currentWindSpeed.toString()),
                      additionalComponent(
                          icon: Icons.beach_access, type: constStrings.pressure, value: currentPressure.toString()),

                    ],
                  )

                ],
              ),
            );
          },
      )



    );
  }


}

//main card
Widget mainCard(String temperature, IconData icon, String weatherType) {
  return SizedBox(
    width: double.infinity,
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              spacing: 16,
              children: [
                Text(
                  "$temperature° C",
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Icon(
                  icon,
                  size: 64,
                ),
                Text(
                  weatherType,
                  style: const TextStyle(
                      fontSize: 20
                  ),)
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

//title text
Widget titleText(String text) {
  return Text(
    text,

    style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
    ),);
}

//weather forecast component
Widget weatherForecastComponent(String time, IconData icon,
    String temperature) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 6,
      child: Container(
        width: 115,
        padding: EdgeInsets.all(8),
        child: Column(
          spacing: 10,
          children: [
            Text(
              time,
              maxLines: 1,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            Icon(
              icon,
              size: 40,
            ),
            Text(
              "${temperature}° C",
              style: const TextStyle(
                  fontSize: 17
              ),)
          ],
        ),
      ),
    ),
  );
}

//additional information component
Widget additionalComponent(
    {required IconData icon, required String type, required String value}) {
  return Column(
    spacing: 8,
    children: [
      Icon(
        icon,
        size: 32,
      ),
      Text(
        type,
        style: const TextStyle(

        ),
      ),
      Text(
        value,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),)
    ],
  );
}

* */