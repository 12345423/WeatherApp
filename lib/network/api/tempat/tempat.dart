import 'package:dio/dio.dart';
import 'package:modul3/network/api/constant/endpoint.dart';
import 'package:modul3/network/dio_client.dart';

class TempatApi {
  final DioClient dioClient;

  TempatApi({required this.dioClient});

  Future<Response> getAllTempat(String token) async {
    try {
      final Response response = await dioClient.get(Endpoints.tempat,
          options: Options(headers: {"Authorization": "bearer " + token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addTempat(
      String tempat,
      String wind,
      String pressure,
      String area,
      String humidity,
      String temperature,
      String population,
      String token) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.tempat,
        data: {
          'tempat': tempat,
          'wind': wind,
          'pressure': pressure,
          'area': area,
          'humidity': humidity,
          'temperature': temperature,
          'population': population,
        },
        options: Options(
          headers: {"Authorization": "bearer " + token},
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateTempat(
      int id, String temperature, String token) async {
    try {
      final Response response = await dioClient.put(
        Endpoints.tempat + "/$id",
        data: {
          'temperature': temperature,
        },
        options: Options(
          headers: {
            "Authorization": "bearer " + token,
            "Accept": "application/json"
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTempat(int id, String token) async {
    try {
      await dioClient.delete(
        Endpoints.tempat + "/$id",
        options: Options(
          headers: {"Authorization": "bearer " + token},
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
