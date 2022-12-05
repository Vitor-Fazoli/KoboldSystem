import 'dart:async';

import 'package:dio/dio.dart';


class DataModel {

  static double currentValue;
  String date;
  double value;
  String time;
  String weekday;

  DataModel({
    this.date,
    this.value,
    this.time,
    this.weekday,
  });

  factory DataModel.fromMap(Map<String, dynamic> json) {
    return DataModel(
      date: json['date'],
      value: double.parse(json['value']),
      time: json['time'],
      weekday: json['weekday'],
    );
  }

}

List<DataModel> decodeData(dynamic responseBody) {

  final parsed = responseBody;
  return parsed
      .map<DataModel>((json) => DataModel.fromMap(json))
      .toList();
}

Future<dynamic> fetchChartData() async {
  final response = await Dio().get(
      'https://script.google.com/macros/s/AKfycbw5tFe-GqY4YxFcElNyPIWNHHI1Momrg-VtoD0L9ubpX7tLN0ufVoiDsx3bs13NfOfj/exec');

  return response;
}

Future<List<DataModel>> fetchData() async {
  final response = await Dio().get(
      'https://script.google.com/macros/s/AKfycbw5tFe-GqY4YxFcElNyPIWNHHI1Momrg-VtoD0L9ubpX7tLN0ufVoiDsx3bs13NfOfj/exec');

  final respCurrentValue = await Dio().get(
      'https://script.google.com/macros/s/AKfycbzcNZrtVLTY59wBide2puvh50O4EwZAAQ6veXh9iV1-0mhbf-5j9JdcGWPa7HKwMuvZVg/exec');

  DataModel.currentValue = respCurrentValue.data;

  if (response.statusCode == 200) {
    print("Processo completo - API lida com sucesso");
    return decodeData(response.data);
  } else {
    throw Exception('Não foi possivel entrar em contato com a API');
  }
}
