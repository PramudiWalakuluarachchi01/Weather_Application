import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app_01/additional_info_item.dart';
import 'package:weather_app_01/hourly_forecast_item.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app_01/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late double temp;
  @override
  void initState() {
    super.initState();
    print('initState');
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    // Implement  API call here to fetch current weather data
    print('fn called');

    try {
      String cityName = "London";
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey',
        ),
      );
      print('api ended');

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occured'; // Handle error case here if needed
      }

      temp = data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
        print('build fn called');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh weather data
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
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
                            '$temp K',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Icon(Icons.cloud, size: 64),

                          const SizedBox(height: 8),

                          const Text('Rain', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Weather Forecast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecastItem(
                    time: '03.03',
                    icon: Icons.cloud,
                    temperature: '320.12',
                  ),

                  HourlyForecastItem(
                    time: '04.03',
                    icon: Icons.wb_sunny,
                    temperature: '322.15',
                  ),

                  HourlyForecastItem(
                    time: '05.03',
                    icon: Icons.grain,
                    temperature: '319.11',
                  ),

                  HourlyForecastItem(
                    time: '06.03',
                    icon: Icons.ac_unit,
                    temperature: '315.09',
                  ),

                  HourlyForecastItem(
                    time: '07.03',
                    icon: Icons.wb_cloudy,
                    temperature: '318.13',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            //aditional info
            const Text(
              'Additional Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItem(
                    icon: Icons.water_drop,
                    label: 'Humidity',
                    value: '60%',
                  ),
                  AdditionalInfoItem(
                    icon: Icons.air,
                    label: 'Wind Speed',
                    value: '15 km/h',
                  ),
                  AdditionalInfoItem(
                    icon: Icons.thermostat,
                    label: 'Pressure',
                    value: '1013 hPa',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
