import 'package:dio/dio.dart';
import 'package:modul3/network/api/tempat/tempat.dart';

import 'package:modul3/network/dio_exception.dart';
import 'package:modul3/tempat.dart';

class TempatRepository {
  final TempatApi tempatApi;
  TempatRepository({required this.tempatApi});

  Future<List<Tempat>> getAllTempatReq(String token) async {
    try {
      final response = await tempatApi.getAllTempat(token);
      final niat = (response.data['data'] as List)
          .map((e) => Tempat.fromJson(e))
          .toList();
      return niat;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Tempat> createTempatReq(
      String tempat,
      String wind,
      String pressure,
      String area,
      String humidity,
      String temperature,
      String population,
      String token) async {
    try {
      final response = await tempatApi.addTempat(tempat, wind, pressure, area,
          humidity, temperature, population, token);
      return Tempat.fromJson(response.data["data"]);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Tempat> updateTempatReq(
      int id, String temperature, String token) async {
    try {
      final response = await tempatApi.updateTempat(id, temperature, token);
      return Tempat.fromJson(response.data["data"]);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> deleteTempatReq(int id, String token) async {
    try {
      final response = await tempatApi.deleteTempat(id, token);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
