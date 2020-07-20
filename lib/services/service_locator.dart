import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:bored/services/json_service.dart';
import 'package:bored/services/json_service_impl.dart';

/// Singleton locator which can be accessed from anywhere in the app.
GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<JsonService>(() => JsonServiceImpl());
}
