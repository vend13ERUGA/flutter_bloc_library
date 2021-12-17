import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_bloc_library/models/clock_data.dart';
import 'package:flutter/material.dart';

Future<String> _loadJSON() async {
  return await rootBundle.loadString('source/clock.json');
}

Future<List<ClockData>> loadJSON([Iterable<int>? listID]) async {
  String jsonString = await _loadJSON();
  List<dynamic> decoded = jsonDecode(jsonString);
  List<ClockData> clock = [];

  for (var key in decoded) {
    clock.add(ClockData(key['id'], key['name'], key['url'], key['description'],
        key['price'], false));
  }

  return clock;
  // для проверки
  // return Future.delayed(Duration(seconds: 20), () => clock);
}
