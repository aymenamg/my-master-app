import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  double _budget = 0.0;
  final List<Map<String, dynamic>> _productList = [];

  double get budget => _budget;
  List<Map<String, dynamic>> get productList => _productList;

  void setBudget(double value) {
    _budget = value;
    notifyListeners();
  }

  void addProduct(Map<String, dynamic> product) {
    // Check if product already exists
    int index = _productList.indexWhere((p) => p['name'] == product['name'] && p['price'] == product['price']);
    if (index != -1) {
      _productList[index]['quantity'] = (_productList[index]['quantity'] ?? 1) + 1;
    } else {
      product['quantity'] = 1;
      _productList.add(product);
    }
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < _productList.length) {
      int currentQty = _productList[index]['quantity'] ?? 1;
      if (currentQty > 1) {
        _productList[index]['quantity'] = currentQty - 1;
      } else {
        _productList.removeAt(index);
      }
      notifyListeners();
    }
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < _productList.length) {
      _productList[index]['quantity'] = (_productList[index]['quantity'] ?? 1) + 1;
      notifyListeners();
    }
  }

  void removeProduct(int index) {
    if (index >= 0 && index < _productList.length) {
      _productList.removeAt(index);
      notifyListeners();
    }
  }

  void clearProducts() {
    _productList.clear();
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var product in _productList) {
      double price = double.tryParse(product['price'].toString()) ?? 0.0;
      int quantity = product['quantity'] ?? 1;
      total += price * quantity;
    }
    return total;
  }

  bool get isBudgetExceeded {
    return _budget > 0 && totalPrice >= _budget;
  }
}
