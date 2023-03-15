import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yper/features/locations/view_models/location_view_model.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocationViewModel>(
      create: (_) => LocationViewModel()..fetchLocations(),
      child: Consumer<LocationViewModel>(
        builder: (context, value, child) {
          // Loading widget
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Displaying data
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: value.locations.length,
            itemBuilder: (context, index) => Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and type properties
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            value.locations[index].name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Text(
                          value.locations[index].type,
                        ),
                      ],
                    ),

                    // Dimension property
                    Text(
                      value.locations[index].dimension,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
