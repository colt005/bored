import 'package:bored/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:bored/services/json_service.dart';
import 'package:bored/services/service_locator.dart';

class BoredBloc with ChangeNotifier {
  JsonService _jsonService = locator<JsonService>();
  String _activityString;

  String get activityString => _activityString;


  Future getActivity(String type) async {
    _activityString = await _jsonService.getACtivity(type);
    notifyListeners();
  }

}
