import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_modle.dart';
import 'db_helper.dart';

class CartProvider with ChangeNotifier {
  DBHelper db=DBHelper();
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  late Future<List<Cart>>_cart;
  Future<List<Cart>>get cart=>_cart;
  Future<List<Cart>>getData()async{
  _cart=db.getCartList();
  return _cart;
}
  void setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = totalPrice + productPrice;
    setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    setPrefItems();

    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    _totalPrice++;
    return _totalPrice;
  }

  void addCounter() {
    _counter++;
    setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    setPrefItems();

    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    _counter--;
    return _counter;
  }
}
