import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app_01/additional_info_item.dart';
import 'package:weather_app_01/hourly_forecast_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '300°F',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Icon(Icons.cloud, size: 64),

                          SizedBox(height: 8),

                          Text('Rain', style: TextStyle(fontSize: 20)),
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
                  HourlyForecastItem(),

                  HourlyForecastItem(),

                  HourlyForecastItem(),

                  HourlyForecastItem(),

                  HourlyForecastItem(),
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
                  AdditionalInfoItem(),
                  AdditionalInfoItem(),
                  AdditionalInfoItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
