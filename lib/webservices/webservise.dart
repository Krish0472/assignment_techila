import 'package:dio/dio.dart';
import '../models/product.dart';

class WebServices {
  WebServices._();
 static final instance = WebServices._();

   Future getData() async {
    try {
      var response = await Dio().get('https://dummyjson.com/products');
      Dio().options.headers['content-Type'] = 'text/plain; charset=UTF-8';
      Dio().options.headers['Access-Control-Allow-Origin'] = '*';
      Dio().options.headers['Access-Control-Allow-Methods'] = 'GET , POST';

      List res = response.data["products"] as List;
      List<Product> productList = res.map((e) => Product.fromJson(e))
          .toList();
      return productList;
    }
    catch (e) {
      print(e);
    }
  }

}

