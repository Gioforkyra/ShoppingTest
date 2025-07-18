// lib/providers/product_catalog_provider.dart

import 'package:flutter/material.dart';
import 'package:smart_shopping/models/product.dart'; // Importa la classe Product

class ProductCatalogProvider with ChangeNotifier {
  Product? _scannedProduct;
  bool _showAlert = false;
  String _selectedCategory = 'all';
  String _searchTerm = '';
  final List<Product> _favorites = [];

  Product? get scannedProduct => _scannedProduct;
  bool get showAlert => _showAlert;
  String get selectedCategory => _selectedCategory;
  String get searchTerm => _searchTerm;
  List<Product> get favorites => _favorites;

  // I tuoi prodotti mock sono definiti qui con URL di immagini reali
  final Map<String, Map<String, dynamic>> _mockProductsData = {
    '3017620422003': {
      'name': 'Nutella',
      'brand': 'Ferrero',
      'nutriscore': 'E',
      'calories': 539,
      'fat': 30.9,
      'sugars': 56.3,
      'salt': 0.107,
      'carbohydrates': 57.5, // AGGIUNTO
      'proteins': 6.3, // AGGIUNTO
      'price': 4.50,
      'image': 'https://i.pinimg.com/736x/d8/1e/29/d81e29ec82b776a1d63812cd783410c3.jpg',
      'category': 'Dolci e Snack'
    },
    '8076809513463': {
      'name': 'Pasta Barilla Spaghetti',
      'brand': 'Barilla',
      'nutriscore': 'A',
      'calories': 350,
      'fat': 1.5,
      'sugars': 3.2,
      'salt': 0.006,
      'carbohydrates': 70.0, // AGGIUNTO
      'proteins': 12.0, // AGGIUNTO
      'price': 1.20,
      'image': 'https://i.pinimg.com/736x/7d/d9/d6/7dd9d676c346c1bc1e5b6db17f3df16a.jpg',
      'category': 'Pasta e Cereali'
    },
    '8003170087057': {
      'name': 'Olio Extra Vergine',
      'brand': 'Monini',
      'nutriscore': 'C',
      'calories': 884,
      'fat': 100.0,
      'sugars': 0.0,
      'salt': 0.0,
      'carbohydrates': 0.0, // AGGIUNTO
      'proteins': 0.0, // AGGIUNTO
      'price': 6.90,
      'image': 'https://i.pinimg.com/736x/04/3d/6d/043d6d31ee8d83ed6370c3d8612047a4.jpg',
      'category': 'Condimenti'
    },
    '8718907204558': {
      'name': 'Avocado Hass',
      'brand': 'N/A',
      'nutriscore': 'B',
      'calories': 160,
      'fat': 14.66,
      'sugars': 0.66,
      'salt': 0.007,
      'carbohydrates': 8.53, // AGGIUNTO
      'proteins': 2.0, // AGGIUNTO
      'price': 1.80,
      'image': 'https://i.pinimg.com/736x/aa/87/60/aa8760b67f03a40b63bc83277bdf11a4.jpg',
      'category': 'Frutta e Verdura'
    },
    '2000000000001': {
      'name': 'Petto di Pollo Fresco',
      'brand': 'Fileni',
      'nutriscore': 'A',
      'calories': 165,
      'fat': 3.6,
      'sugars': 0.0,
      'salt': 0.09,
      'carbohydrates': 0.0, // AGGIUNTO
      'proteins': 31.0, // AGGIUNTO
      'price': 8.90,
      'image': 'https://i.pinimg.com/736x/68/b9/f8/68b9f8d7d77ddb3d3de7d8e63a28a919.jpg',
      'category': 'Carne e Pesce'
    },
    '0000000000002': {
      'name': 'Mela Rossa Gala',
      'brand': 'Melinda',
      'nutriscore': 'A',
      'calories': 52,
      'fat': 0.17,
      'sugars': 10.39,
      'salt': 0.001,
      'carbohydrates': 13.81, // AGGIUNTO
      'proteins': 0.26, // AGGIUNTO
      'price': 0.80,
      'image': 'https://i.pinimg.com/736x/50/6b/4e/506b4ed1f20085d68b8b4f403bb110d4.jpg',
      'category': 'Frutta e Verdura'
    },
    '8000000000003': {
      'name': 'Yogurt Greco 0% Grassi',
      'brand': 'Fage',
      'nutriscore': 'A',
      'calories': 59,
      'fat': 0.4,
      'sugars': 3.6,
      'salt': 0.05,
      'carbohydrates': 3.6, // AGGIUNTO
      'proteins': 10.0, // AGGIUNTO
      'price': 1.50,
      'image': 'https://i.pinimg.com/736x/05/c6/32/05c632067894743145357cc228af5f4e.jpg',
      'category': 'Latticini'
    },
    '8000000000004': {
      'name': 'Pane Integrale Biologico',
      'brand': 'Esselunga',
      'nutriscore': 'B',
      'calories': 247,
      'fat': 3.5,
      'sugars': 2.8,
      'salt': 1.0,
      'carbohydrates': 48.0, // AGGIUNTO
      'proteins': 11.0, // AGGIUNTO
      'price': 2.10,
      'image': 'https://i.pinimg.com/736x/bd/a0/2e/bda02edec71d12b79183f8577edce78c.jpg',
      'category': 'Pane e Cereali'
    },
    '1234567890123': {
      'name': 'Biscotti al Cioccolato',
      'brand': 'Oro Saiwa',
      'nutriscore': 'D',
      'calories': 480,
      'fat': 20.0,
      'sugars': 30.0,
      'salt': 0.5,
      'carbohydrates': 65.0, // AGGIUNTO
      'proteins': 5.0, // AGGIUNTO
      'price': 2.50,
      'image': 'https://i.pinimg.com/736x/ab/e2/c6/abe2c688ad1b316892bde61f27ccb8b5.jpg',
      'category': 'Dolci e Snack'
    },
    '9876543210987': {
      'name': 'Filetto di Salmone Fresco',
      'brand': 'Aqua',
      'nutriscore': 'B',
      'calories': 208,
      'fat': 13.0,
      'sugars': 0.0,
      'salt': 0.09,
      'carbohydrates': 0.0, // AGGIUNTO
      'proteins': 20.0, // AGGIUNTO
      'price': 22.00,
      'image': 'https://i.pinimg.com/736x/34/6f/b0/346fb094ae39180301832617ec358757.jpg',
      'category': 'Carne e Pesce'
    },
    '5432109876543': {
      'name': 'Lenticchie Secche',
      'brand': 'Pedon',
      'nutriscore': 'A',
      'calories': 116,
      'fat': 0.3,
      'sugars': 0.5,
      'salt': 0.002,
      'carbohydrates': 20.0, // AGGIUNTO
      'proteins': 9.0, // AGGIUNTO
      'price': 1.80,
      'image': 'https://i.pinimg.com/736x/7f/a5/64/7fa5644998822c48646a083fe262766e.jpg',
      'category': 'Legumi'
    },
    '1122334455667': {
      'name': 'Patatine Fritte Classiche',
      'brand': 'San Carlo',
      'nutriscore': 'D',
      'calories': 530,
      'fat': 34.0,
      'sugars': 0.5,
      'salt': 1.1,
      'carbohydrates': 50.0, // AGGIUNTO
      'proteins': 6.0, // AGGIUNTO
      'price': 1.99,
      'image': 'https://i.pinimg.com/736x/71/f6/51/71f6519e398af3cdc6d3a359833bb2b6.jpg',
      'category': 'Snack Salati'
    },
    '7788990011223': {
      'name': 'Succo di Frutta Tropicale',
      'brand': 'Valfrutta',
      'nutriscore': 'C',
      'calories': 48,
      'fat': 0.0,
      'sugars': 10.0,
      'salt': 0.01,
      'carbohydrates': 11.5, // AGGIUNTO
      'proteins': 0.5, // AGGIUNTO
      'price': 1.60,
      'image': 'https://i.pinimg.com/736x/67/22/b5/6722b554aedce8e04b73988caf2c10f6.jpg',
      'category': 'Bevande'
    },
  };

  // Questi sono i prodotti per la visualizzazione del catalogo per categoria
  final Map<String, List<Map<String, dynamic>>> _productCatalogData = {
    'Frutta e Verdura': [
      {'id': 'banana', 'name': 'Banane', 'brand': 'Biologiche', 'nutriscore': 'A', 'calories': 89, 'fat': 0.3, 'sugars': 12.2, 'salt': 0.001, 'price': 2.50, 'image': '🍌'},
      {'id': 'mele_golden', 'name': 'Mele Golden', 'brand': 'Del Trentino', 'nutriscore': 'A', 'calories': 52, 'fat': 0.2, 'sugars': 10.4, 'salt': 0.001, 'price': 3.20, 'image': '🍎'},
      {'id': 'pomodori', 'name': 'Pomodori Ciliegino', 'brand': 'Biologici', 'nutriscore': 'A', 'calories': 18, 'fat': 0.2, 'sugars': 2.6, 'salt': 0.005, 'price': 4.80, 'image': '🍅'},
      {'id': 'carote', 'name': 'Carote', 'brand': 'Fresche', 'nutriscore': 'A', 'calories': 41, 'fat': 0.2, 'sugars': 4.7, 'salt': 0.069, 'price': 1.90, 'image': '🥕'},
      {'id': 'spinaci', 'name': 'Spinaci Freschi', 'brand': 'Biologici', 'nutriscore': 'A', 'calories': 23, 'fat': 0.4, 'sugars': 0.4, 'salt': 0.079, 'price': 2.80, 'image': '🥬'},
      {'id': 'avocado_hass_cat', 'name': 'Avocado Hass', 'brand': 'N/A', 'nutriscore': 'B', 'calories': 160, 'fat': 14.66, 'sugars': 0.66, 'salt': 0.007, 'price': 1.80, 'image': '🥑'},
    ],
    'Latticini': [
      {'id': 'latte', 'name': 'Latte Intero', 'brand': 'Parmalat', 'nutriscore': 'B', 'calories': 64, 'fat': 3.6, 'sugars': 4.8, 'salt': 0.044, 'price': 1.35, 'image': '🥛'},
      {'id': 'yogurt', 'name': 'Yogurt Greco', 'brand': 'Fage', 'nutriscore': 'A', 'calories': 97, 'fat': 5.0, 'sugars': 4.0, 'salt': 0.053, 'price': 3.20, 'image': '🥛'},
      {'id': 'parmigiano', 'name': 'Parmigiano 24 mesi', 'brand': 'Caseificio', 'nutriscore': 'C', 'calories': 392, 'fat': 28.1, 'sugars': 0.0, 'salt': 1.39, 'price': 18.50, 'image': '🧀'},
      {'id': 'mozzarella', 'name': 'Mozzarella di Bufala', 'brand': 'Campana', 'nutriscore': 'C', 'calories': 280, 'fat': 22.0, 'sugars': 1.0, 'salt': 0.5, 'price': 6.80, 'image': '🧀'},
      {'id': 'ricotta', 'name': 'Ricotta Fresca', 'brand': 'Santa Lucia', 'nutriscore': 'B', 'calories': 130, 'fat': 9.0, 'sugars': 3.0, 'salt': 0.1, 'price': 2.10, 'image': '🧀'},
    ],
    'Carne e Pesce': [
      {'id': 'pollo', 'name': 'Petto di Pollo', 'brand': 'Fileni', 'nutriscore': 'A', 'calories': 165, 'fat': 3.6, 'sugars': 0.0, 'salt': 0.074, 'price': 8.90, 'image': '🍗'},
      {'id': 'salmone', 'name': 'Salmone Norvegese', 'brand': 'Fresco', 'nutriscore': 'B', 'calories': 208, 'fat': 13.0, 'sugars': 0.0, 'salt': 0.44, 'price': 22.00, 'image': '🐟'},
      {'id': 'tonno', 'name': 'Tonno in Scatola', 'brand': 'Rio Mare', 'nutriscore': 'B', 'calories': 116, 'fat': 0.8, 'sugars': 0.0, 'salt': 1.0, 'price': 2.80, 'image': '🐟'},
      {'id': 'merluzzo', 'name': 'Filetto di Merluzzo', 'brand': 'Findus', 'nutriscore': 'A', 'calories': 82, 'fat': 0.7, 'sugars': 0.0, 'salt': 0.1, 'price': 12.50, 'image': '🐟'},
    ],
    'Pasta e Cereali': [
      {'id': 'pasta_barilla', 'name': 'Pasta Barilla Spaghetti', 'brand': 'Barilla', 'nutriscore': 'A', 'calories': 350, 'fat': 1.5, 'sugars': 3.2, 'salt': 0.006, 'price': 1.20, 'image': '🍝'},
      {'id': 'riso', 'name': 'Riso Carnaroli', 'brand': 'Scotti', 'nutriscore': 'A', 'calories': 130, 'fat': 0.3, 'sugars': 0.1, 'salt': 0.005, 'price': 2.90, 'image': '🍚'},
      {'id': 'pane_integrale', 'name': 'Pane Integrale', 'brand': 'Mulino Bianco', 'nutriscore': 'B', 'calories': 247, 'fat': 3.5, 'sugars': 2.8, 'salt': 1.0, 'price': 2.50, 'image': '🍞'},
      {'id': 'avena', 'name': 'Fiocchi d\'Avena', 'brand': 'Quaker', 'nutriscore': 'A', 'calories': 379, 'fat': 6.5, 'sugars': 1.2, 'salt': 0.02, 'price': 3.80, 'image': '🥣'},
      {'id': 'quinoa', 'name': 'Quinoa Tricolore', 'brand': 'Náttúra', 'nutriscore': 'A', 'calories': 368, 'fat': 6.1, 'sugars': 2.3, 'salt': 0.005, 'price': 4.90, 'image': '🥣'},
    ],
    'Dolci e Snack': [
      {'id': 'nutella_cat', 'name': 'Nutella', 'brand': 'Ferrero', 'nutriscore': 'E', 'calories': 539, 'fat': 30.9, 'sugars': 56.3, 'salt': 0.107, 'price': 4.50, 'image': '🍫'},
      {'id': 'biscotti', 'name': 'Biscotti Digestive', 'brand': 'McVitie\'s', 'nutriscore': 'D', 'calories': 471, 'fat': 16.0, 'sugars': 16.0, 'salt': 1.75, 'price': 2.90, 'image': '🍪'},
      {'id': 'cioccolato', 'name': 'Cioccolato Fondente 70%', 'brand': 'Lindt', 'nutriscore': 'D', 'calories': 598, 'fat': 42.0, 'sugars': 24.0, 'salt': 0.003, 'price': 3.50, 'image': '🍫'},
      {'id': 'gelato', 'name': 'Gelato alla Vaniglia', 'brand': 'Algida', 'nutriscore': 'D', 'calories': 207, 'fat': 11.0, 'sugars': 23.0, 'salt': 0.15, 'price': 5.50, 'image': '🍦'},
      {'id': 'patatine_classiche', 'name': 'Patatine Fritte Classiche', 'brand': 'San Carlo', 'nutriscore': 'D', 'calories': 530, 'fat': 34.0, 'sugars': 0.5, 'salt': 1.1, 'price': 1.99, 'image': '🍟'},
    ],
    'Bevande': [
      {'id': 'acqua', 'name': 'Acqua Naturale', 'brand': 'San Pellegrino', 'nutriscore': 'A', 'calories': 0, 'fat': 0.0, 'sugars': 0.0, 'salt': 0.0, 'price': 0.85, 'image': '💧'},
      {'id': 'succo', 'name': 'Succo d\'Arancia', 'brand': 'Yoga', 'nutriscore': 'C', 'calories': 45, 'fat': 0.2, 'sugars': 8.8, 'salt': 0.002, 'price': 2.20, 'image': '🧃'},
      {'id': 'te', 'name': 'Tè Verde', 'brand': 'Twinings', 'nutriscore': 'A', 'calories': 1, 'fat': 0.0, 'sugars': 0.0, 'salt': 0.0, 'price': 4.50, 'image': '🍵'},
      {'id': 'cola', 'name': 'Coca-Cola Zero Zuccheri', 'brand': 'Coca-Cola', 'nutriscore': 'B', 'calories': 0, 'fat': 0.0, 'sugars': 0.0, 'salt': 0.01, 'price': 1.80, 'image': '🥤'},
    ],
    'Condimenti': [
      {'id': 'olio_extra_vergine', 'name': 'Olio Extra Vergine', 'brand': 'Monini', 'nutriscore': 'C', 'calories': 884, 'fat': 100.0, 'sugars': 0.0, 'salt': 0.0, 'price': 6.90, 'image': '🫒'},
      {'id': 'aceto', 'name': 'Aceto Balsamico', 'brand': 'Modena', 'nutriscore': 'A', 'calories': 88, 'fat': 0.0, 'sugars': 17.0, 'salt': 0.02, 'price': 8.50, 'image': '🍶'},
      {'id': 'sale_fino', 'name': 'Sale Fino', 'brand': 'Italkali', 'nutriscore': 'C', 'calories': 0, 'fat': 0.0, 'sugars': 0.0, 'salt': 100.0, 'price': 0.80, 'image': '🧂'},
      {'id': 'maionese', 'name': 'Maionese Classica', 'brand': 'Knorr', 'nutriscore': 'D', 'calories': 680, 'fat': 74.0, 'sugars': 3.0, 'salt': 1.2, 'price': 3.10, 'image': '🥣'},
    ],
    'Legumi': [ // Nuova Categoria
      {'id': 'lenticchie', 'name': 'Lenticchie Secche', 'brand': 'Pedon', 'nutriscore': 'A', 'calories': 116, 'fat': 0.3, 'sugars': 0.5, 'salt': 0.002, 'price': 1.80, 'image': '🌰'},
      {'id': 'ceci', 'name': 'Ceci Lessi', 'brand': 'Valfrutta', 'nutriscore': 'A', 'calories': 140, 'fat': 2.5, 'sugars': 0.5, 'salt': 0.005, 'price': 1.50, 'image': '🥫'},
    ],
    'Snack Salati': [ // Nuova Categoria
      {'id': 'arachidi', 'name': 'Arachidi Tostate', 'brand': 'Dole', 'nutriscore': 'C', 'calories': 567, 'fat': 49.0, 'sugars': 4.0, 'salt': 0.05, 'price': 3.00, 'image': '🥜'},
      {'id': 'taralli', 'name': 'Taralli Classici', 'brand': 'Pugliese', 'nutriscore': 'C', 'calories': 450, 'fat': 18.0, 'sugars': 2.0, 'salt': 2.5, 'price': 2.20, 'image': '🥨'},
    ],
  };

  List<String> get categories => _productCatalogData.keys.toList();

  List<Product> get allProducts {
    List<Product> products = [];
    _productCatalogData.forEach((category, productList) {
      for (var data in productList) {
        products.add(Product.fromMap(data, data['id'] as String, category));
      }
    });
    return products;
  }

  List<Product> get filteredProducts {
    List<Product> productsToFilter = [];
    if (_selectedCategory == 'all') {
      productsToFilter = allProducts;
    } else {
      productsToFilter = _productCatalogData[_selectedCategory]
              ?.map((data) => Product.fromMap(data, data['id'] as String, _selectedCategory))
              .toList() ??
          [];
    }

    if (_searchTerm.isEmpty) {
      return productsToFilter;
    } else {
      return productsToFilter.where((product) {
        final matchesSearch = product.name.toLowerCase().contains(_searchTerm.toLowerCase()) ||
            product.brand.toLowerCase().contains(_searchTerm.toLowerCase());
        return matchesSearch;
      }).toList();
    }
  }

  void simulateBarcodeScan() {
    final barcodes = _mockProductsData.keys.toList();
    // Usa Random() per una casualità migliore, instanzialo una sola volta
    // o usa una variabile locale se la instanzi sempre qui.
    // Per semplicità e per questo caso d'uso, va bene così per ora.
    final randomIndex = DateTime.now().microsecondsSinceEpoch % barcodes.length;
    final randomBarcode = barcodes[randomIndex];

    final productData = _mockProductsData[randomBarcode];

    if (productData != null) {
      // Assicurati che l'ID sia randomBarcode e la categoria sia quella del dato mock
      _scannedProduct = Product.fromMap(productData, randomBarcode, productData['category'] as String);
      
      // La logica dell'alert è già qui e va bene
      _showAlert = (_scannedProduct!.nutriscore == 'E' || _scannedProduct!.sugars > 20); // Esempio: zuccheri > 20g per 100g
      if (_showAlert) {
        Future.delayed(const Duration(seconds: 3), () {
          _showAlert = false;
          notifyListeners();
        });
      }
    } else {
      _scannedProduct = null; // Prodotto non trovato
      _showAlert = false;
    }
    notifyListeners();
  }

  void addToFavorites(Product product) {
    if (!_favorites.any((fav) => fav.id == product.id)) {
      _favorites.add(product);
      notifyListeners();
    }
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchTerm(String term) {
    _searchTerm = term;
    notifyListeners();
  }

  String getNutriscoreColor(String score) {
    switch (score) {
      case 'A':
        return 'green';
      case 'B':
        return 'lime';
      case 'C':
        return 'yellow';
      case 'D':
        return 'orange';
      case 'E':
        return 'red';
      default:
        return 'grey';
    }
  }

  String getTrafficLight(double value, Map<String, double> thresholds) {
    if (value <= thresholds['low']!) return 'green';
    if (value <= thresholds['medium']!) return 'yellow';
    return 'red';
  }

  void clearScannedProduct() {
    _scannedProduct = null;
    _showAlert = false; // Resetta anche l'alert
    notifyListeners();
  }
}