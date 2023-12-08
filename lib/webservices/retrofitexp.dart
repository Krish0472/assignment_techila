import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../models/product.dart';
part 'retrofitexp.g.dart';

@RestApi(baseUrl: "http://dummyjson.com/")
abstract class WebServicesTwo {
  factory WebServicesTwo(Dio dio, {String baseUrl}) = _WebServicesTwo;

  @GET("/products")
  Future<MyProducts> getTasks();

}