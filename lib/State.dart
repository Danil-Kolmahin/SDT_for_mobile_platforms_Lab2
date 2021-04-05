import 'package:flutter/material.dart';

class StateModel extends ChangeNotifier {
  double brightness;

  // get getBrightness {
  //   print('get $brightness');
  //   return this.brightness;
  // }

  void changeBrightness(double newBrightness) {
    print('set from $brightness to $newBrightness');
    this.brightness = newBrightness;
    notifyListeners();
  }
}