import 'package:assignment_techila/webservices/webservise.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class Repo {
  final webService = WebServices.instance;

  List<Product> products = []; //get list from api
  List<Product> get _product => products;

  List<Product> productWishList = [];
  List<Product> productListCart = []; //list for cart

  num _totalAmount = 0;
  num get totalAmount => _totalAmount;

  Future<List<Product>> fetchData() async {
    products = await webService.getData();
    return _product;
  }

  List<Product> addToCart(Product product) {
    (productListCart.any((element) => element.id == product.id))
        ? addQuantity(product.id)
        : productListCart.add(Product(
            id: product.id,
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
    setTotalAmount();
    return productListCart;
  }

  List<Product> addToWishList(Product product) {
    productWishList.add(Product(
        category: product.category,
        id: product.id,
        title: product.title,
        price: product.price,
        thumbnail: product.thumbnail,
        images: product.images));
    return productWishList;
  }

  List<Product> delFromWishList(Product product) {
    int index =
        productWishList.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      productWishList.removeAt(index);
    }
    debugPrint('hiii > ${productWishList.length}');
    return productWishList;
  }

  List<Product> addQuantity(int productId) {
    int index =
        productListCart.indexWhere((element) => element.id == productId);
    productListCart[index].quantity = productListCart[index].quantity! + 1;
    setTotalAmount();
    return productListCart;
  }

  List<Product> qtyRemove(int productid) {
    int index =
        productListCart.indexWhere((element) => element.id == productid);
    productListCart[index].quantity = productListCart[index].quantity! - 1;
    setTotalAmount();
    return productListCart;
  }

  num setTotalAmount() {
    _totalAmount = 0;
    for (var product in productListCart) {
      _totalAmount = _totalAmount + (product.quantity! * product.price);
    }
    return _totalAmount;
  }

  List<Product> delFromCart(Product product) {
    int index =
        productListCart.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      productListCart.removeAt(index);
    }
    setTotalAmount();
    return productListCart;
  }
}
