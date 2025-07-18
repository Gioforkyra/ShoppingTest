import 'package:flutter/material.dart';

class StapleItem {
  String name;
  int quantity;

  StapleItem({required this.name, required this.quantity});
}

class ShoppingListProvider extends ChangeNotifier {
  final List<StapleItem> _items = [];

  List<StapleItem> get items => List.unmodifiable(_items);

  void addItem(String name) {
    // Controlla se l'item esiste già
    final existingItemIndex = _items.indexWhere((item) => item.name.toLowerCase() == name.toLowerCase());
    
    if (existingItemIndex != -1) {
      // Se esiste, incrementa la quantità
      _items[existingItemIndex].quantity++;
    } else {
      // Se non esiste, aggiungilo
      _items.add(StapleItem(name: name, quantity: 1));
    }
    
    notifyListeners();
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void clearList() {
    _items.clear();
    notifyListeners();
  }

  int get itemCount => _items.length;

  bool get isEmpty => _items.isEmpty;
}