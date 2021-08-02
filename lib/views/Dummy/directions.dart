import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_3/views/Dummy/env.dart';
import 'package:flutter_application_3/views/Dummy/path.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Direction{
  static const baseurl ='https://maps.googleapis.com/maps/api/directions/json?';
  final Dio _dio;

  Direction({Dio dio}):_dio=dio ?? Dio();

  Future<PathDir> getpath({
    @required LatLng origin,
    @required LatLng destination,
  }) async{
    final response = await _dio.get(baseurl,queryParameters: {'origin':'${origin.latitude},${origin.longitude}','destination':'${destination.latitude},${destination.longitude}','key':googleAPIKEY},
    );
    if(response.statusCode==200){
      return PathDir.fromMap(response.data);
    }
    return null;
  }

}