import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/features/location/bloc/location_bloc.dart';

import '../../../core/location/location_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),

      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {

          //  Loading
          if (state is LocationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // GPS
          if (state is LocationServiceDisabled) {
            return InfoView(
              text: 'Please enable location services',
              buttonText: 'Open Location Settings',
              onPressed: () {
                LocationService.openAppSettings();
              },
            );
          }

          //  Permission denied
          if (state is LocationPermissionDenied) {
            return InfoView(
              text: 'Location permission is required',
              buttonText: 'Retry',
              onPressed: () {
                context
                    .read<LocationBloc>()
                    .add(StartLocationTracking());
              },
            );
          }

          // Permission denied forever
          if (state is LocationPermissionDeniedForever) {
            return InfoView(
              text:
              'Location permission permanently denied. Open app settings.',
              buttonText: 'Open Settings',
              onPressed: () {
                LocationService.openAppSettings();
              },
            );
          }

          //  Location
          if (state is LocationReady) {
            return Center(
              child: Text(
                'Lat: ${state.lat}\nLng: ${state.lng}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            );
          }

          // fallback
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


class InfoView extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onPressed;
  final IconData? icon;

  const InfoView({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
            ],

            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}

