import 'package:applicatio01statemanagment/models/product.dart';
import 'package:applicatio01statemanagment/webservices/webservise.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';

enum Status{
  inital,
  loading,
  success,
}

class DataProvider extends ChangeNotifier{

  User user = User(email: '', password: '');

  Status _status = Status.inital;
Status get status => _status;
List<Product> products =[]; //get list from api
List<Product> get _product => products;

List<Product> productList =[];  //Cart list data

  num _totalAmount =0;
num get totalAmount => _totalAmount;

Future<List<Product>> fetchData() async {
  final webservise = WebServices.instance;
  try{
    _status = Status.success;
    products = await webservise.getData();
  } catch (e){
    print(e);
  }
  notifyListeners();
  return _product;

}

void _setTotalAmount ()
{
  _totalAmount = 0;
  for(var product in productList) {
    _totalAmount = _totalAmount + (product.quantity! * product.price);
  }
}
void addToCart(Product product) {
  (productList.any((element) => element.id == product.id)) ? addQuantity(product.id)
      : productList.add(Product
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
      rating: product.rating)
  );
      _setTotalAmount();
}


void addQuantity(int productId) {
    int index = productList.indexWhere((element) => element.id == productId);
    productList[index].quantity = productList[index].quantity! + 1;
    _setTotalAmount();
    notifyListeners();
  }

  void qtyRemove(int productid){
  int index = productList.indexWhere((element) => element.id == productid);
  productList[index].quantity = productList[index].quantity! - 1;
  _setTotalAmount();
  notifyListeners();
}
void delFromCart(Product product ){
  int index = productList.indexWhere((element) => element.id == product.id);
  if (index != -1){
    productList.removeAt(index);
  }
  _setTotalAmount();
  notifyListeners();
}

bool _isChecked = false;
bool get isChecked => _isChecked;
 void toggleCheckbox() {
    _isChecked = !_isChecked;
    notifyListeners();
  }
  bool _isLoggedIn  = false;
 bool get isLoggedIn => _isLoggedIn;
 Future<void> signIn ({required String username, required String password}) async{
  // await Future.delayed(Duration(seconds: 2));
   if(username == user.email  && password == user.password){
   _isLoggedIn = true;
   //print(_isLoggedIn);
   notifyListeners();
   }
   else {

     throw Exception('Invalid credentials please try again ');
   }
 }

 void signOut(){
   _isLoggedIn = false;
   notifyListeners();
 }

}


/*
/*
 Future<void> getProducts() async {
    try {
      _setState(DataState.loading);
      _products = await WebService.getProducts();
      _setState(DataState.loaded);
    } on Failure catch (f) {
      _setFailure(f);
      _setState(DataState.notLoaded);
    }
    notifyListeners();
  }
 */


// Future<void> fetchData() async {
//   _status = Status.loading;
//   notifyListeners();
//   await Future.delayed(Duration(seconds: 2));
//   _status = Status.success;
//    var res = await Dio().get('https://dummyjson.com/products');
//     List data = json.decode(res.data)['products'];
//     notifyListeners();
//     return data.map((e) => Product.fromJson(e)).toList();
// }
 */

