import 'package:flutter/material.dart';

class SeatSelectionPage extends StatelessWidget {
  final String showtimesId;
  const SeatSelectionPage({super.key, required this.showtimesId});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Seat Selection for $showtimesId"),),
      body: Center(child: Text('Seat Selection Page')),
    );
  }
}