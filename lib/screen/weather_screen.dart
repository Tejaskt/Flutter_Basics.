import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: .bold
          ),
        ),
        centerTitle: true,
        actions: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: IconButton(
               onPressed: (){},
               icon: const Icon(Icons.refresh)
           ),
         )
        ],
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: .infinity,
                  child: Card(
                    child: Column(
                      children: [
                        Text(
                          "340°",
                          style: TextStyle(
                            fontWeight: .bold,
                            fontSize: 32
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
