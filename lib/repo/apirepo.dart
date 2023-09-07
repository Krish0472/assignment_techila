import 'package:applicatio01statemanagment/webservices/retrofitexp.dart';
import 'package:applicatio01statemanagment/webservices/webservise.dart';
import 'package:dio/dio.dart';

import '../models/product.dart';

class Repo {
  final webservise = WebServices.instance;

  final webservices = WebServicesTwo(Dio(BaseOptions(
    contentType: "application/json",
  ),),);



  List<Product> products =[]; //get list from api
  List<Product> get _product => products;

  List<Product> productListCart =[];
  List<Product> get _productListCart => productListCart;


  num _totalAmount =0;
  num get totalAmount => _totalAmount;



  Future<List<Product>> fetchData() async {
    products = await webservise.getData();
    return _product;
  }

  Future<List<Product>> fetchhData() async {
    final data = await webservices.getTasks();
    return data.products;
  }



  List<Product> addToCart(Product product)  {
    (productListCart.any((element) => element.id == product.id))? addQuantity(product.id)
        : productListCart.add(Product
      (id: product.id,
        title: product.title,
        price: product.price,
        thumbnail: product.thumbnail,
        images: product.images,
        quantity: 1,
        total: product.price * 1,
        discountPercentage: 0,
        discountedPrice: 0,
        category: product.category,
        description: product.description,
        rating: product.rating));
    _setTotalAmount();
    return productListCart;

  }

  void addQuantity(int productId) {
    int index = productListCart.indexWhere((element) => element.id == productId);
    productListCart[index].quantity = productListCart[index].quantity! + 1;
    _setTotalAmount();
  }

  void qtyRemove(int productid){
    int index = productListCart.indexWhere((element) => element.id == productid);
    productListCart[index].quantity = productListCart[index].quantity! - 1;
    _setTotalAmount();

  }

  void _setTotalAmount ()
  {
    _totalAmount = 0;
    for(var product in productListCart) {
      _totalAmount = _totalAmount + (product.quantity! * product.price);
    }
  }

 List<Product> delFromCart(Product product ){
    int index = productListCart.indexWhere((element) => element.id == product.id);
    if (index != -1){
      productListCart.removeAt(index);
    }
    _setTotalAmount();

   return productListCart;

  }




}