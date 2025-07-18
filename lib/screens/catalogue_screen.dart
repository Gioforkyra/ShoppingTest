import 'package:flutter/material.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({Key? key}) : super(key: key);

  @override
  _CatalogueScreenState createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  int selectedCategoryIndex = 0;
  PageController _pageController = PageController();
  
  final List<String> categories = [
    'Tutti',
    'Frutta & Verdura',
    'Bevande',
    'Carne & Pesce',
    'Latticini',
    'Panetteria',
    'Surgelati'
  ];

  final Map<String, List<Product>> categoryProducts = {
    'Tutti': [],
    'Frutta & Verdura': [
      Product(
        name: 'Fragole',
        price: 20.00,
        rating: 5.0,
        image: 'https://i.pinimg.com/736x/5e/5c/20/5e5c203888b3a26011e65feb36015b6e.jpg',
      ),
      Product(
        name: 'Cavolfiore',
        price: 10.00,
        rating: 5.0,
        image: 'https://i.pinimg.com/736x/7f/7b/0a/7f7b0a6693c0ae39b397efdb72d804bb.jpg',
      ),
      Product(
        name: 'Arance',
        price: 15.00,
        rating: 4.5,
        image: 'https://images.unsplash.com/photo-1557800636-894a64c1696f?w=300&h=300&fit=crop',
      ),
      Product(
        name: 'Banane',
        price: 8.00,
        rating: 4.8,
        image: 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=300&h=300&fit=crop',
      ),
      Product(
        name: 'Pomodori',
        price: 12.00,
        rating: 4.7,
        image: 'https://i.pinimg.com/736x/36/fd/74/36fd74fe95dee0139e533f25128761e6.jpg',
      ),
      Product(
        name: 'Carote',
        price: 6.00,
        rating: 4.6,
        image: 'https://i.pinimg.com/736x/b6/c7/5d/b6c75de307bcf0075896a0c03a7a20f4.jpg',
      ),
    ],
    'Bevande': [
      Product(
        name: 'Coca Cola',
        price: 3.50,
        rating: 4.2,
        image: 'https://i.pinimg.com/736x/d9/90/b4/d990b4e3fafb7073f2ab7241e48aea0b.jpg',
      ),
      Product(
        name: 'Acqua Naturale',
        price: 1.00,
        rating: 4.8,
        image: 'https://i.pinimg.com/736x/d9/cf/b3/d9cfb329b9b48737bf12c2f20c3cd3eb.jpg',
      ),
      Product(
        name: 'Succo d\'Arancia',
        price: 4.50,
        rating: 4.5,
        image: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?w=300&h=300&fit=crop',
      ),
      Product(
        name: 'Birra',
        price: 5.00,
        rating: 4.3,
        image: 'https://images.unsplash.com/photo-1608270586620-248524c67de9?w=300&h=300&fit=crop',
      ),
    ],
    'Carne & Pesce': [
      Product(
        name: 'Pollo',
        price: 25.00,
        rating: 4.6,
        image: 'https://i.pinimg.com/736x/6f/4e/60/6f4e600a5d1b4354756f354ea0e9dbee.jpg',
      ),
      Product(
        name: 'Salmone',
        price: 35.00,
        rating: 4.8,
        image: 'https://i.pinimg.com/736x/34/c8/a4/34c8a486ed577f550a416cdcaa504399.jpg',
      ),
      Product(
        name: 'Manzo',
        price: 40.00,
        rating: 4.7,
        image: 'https://i.pinimg.com/736x/cd/8f/f5/cd8ff5780c65fa2b4ed065b33bbaa015.jpg',
      ),
      Product(
        name: 'Gamberetti',
        price: 28.00,
        rating: 4.5,
        image: 'https://i.pinimg.com/736x/ae/6e/74/ae6e74e75c0aed3dccc0d89687f6f2bc.jpg',
      ),
    ],
    'Latticini': [
      Product(
        name: 'Latte',
        price: 2.50,
        rating: 4.6,
        image: 'https://i.pinimg.com/736x/13/f2/fc/13f2fc8e4a6af772c14974f0d10be512.jpg',
      ),
      Product(
        name: 'Formaggio',
        price: 18.00,
        rating: 4.7,
        image: 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=300&h=300&fit=crop',
      ),
      Product(
        name: 'Yogurt',
        price: 4.00,
        rating: 4.4,
        image: 'https://i.pinimg.com/736x/10/0b/b3/100bb3cacdf3d51db867ce3ed064bb1c.jpg',
      ),
      Product(
        name: 'Burro',
        price: 6.00,
        rating: 4.5,
        image: 'https://i.pinimg.com/736x/ed/6a/ad/ed6aad0aea4669b25829d3ce75deb2bf.jpg',
      ),
    ],
    'Panetteria': [
      Product(
        name: 'Pane',
        price: 3.00,
        rating: 4.8,
        image: 'https://images.unsplash.com/photo-1586444248902-2f64eddc13df?w=300&h=300&fit=crop',
      ),
      Product(
        name: 'Cornetti',
        price: 5.00,
        rating: 4.6,
        image: 'https://i.pinimg.com/736x/18/c1/90/18c190c26ed4011b258849e2f9418819.jpg',
      ),
      Product(
        name: 'Biscotti',
        price: 4.50,
        rating: 4.3,
        image: 'https://i.pinimg.com/736x/41/4b/24/414b2429172581ce83d9e1b776b33cf6.jpg',
      ),
    ],
    'Surgelati': [
      Product(
        name: 'Pizza Surgelata',
        price: 8.00,
        rating: 4.2,
        image: 'https://i.pinimg.com/736x/d4/b4/f8/d4b4f882648c939ba0bcffeb5424ddd8.jpg',
      ),
      Product(
        name: 'Gelato',
        price: 12.00,
        rating: 4.7,
        image: 'https://i.pinimg.com/736x/c9/eb/cc/c9ebcc1ea7846e06df8efc30c51091cc.jpg',
      ),
      Product(
        name: 'Verdure Miste',
        price: 6.00,
        rating: 4.4,
        image: 'https://i.pinimg.com/736x/6d/96/b6/6d96b607e64412bdc642a3b76950f935.jpg',
      ),
    ],
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Product> getAllProducts() {
    List<Product> allProducts = [];
    categoryProducts.forEach((category, products) {
      if (category != 'Tutti') {
        allProducts.addAll(products);
      }
    });
    return allProducts;
  }

  List<Product> getProductsForCategory(String category) {
    if (category == 'Tutti') {
      return getAllProducts();
    }
    return categoryProducts[category] ?? [];
  }

  void _nextCategory() {
    if (selectedCategoryIndex < categories.length - 1) {
      setState(() {
        selectedCategoryIndex++;
      });
      _pageController.animateToPage(
        selectedCategoryIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousCategory() {
    if (selectedCategoryIndex > 0) {
      setState(() {
        selectedCategoryIndex--;
      });
      _pageController.animateToPage(
        selectedCategoryIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color.fromARGB(255, 58, 164, 119)),
          onPressed: () {},
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Ciao, {nome}',
              style: TextStyle(
                color: Color.fromARGB(255, 58, 164, 119),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color.fromARGB(255, 58, 164, 119)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color.fromARGB(255, 58, 164, 119)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Sezione Categorie con navigazione
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categoria',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: selectedCategoryIndex > 0 ? _previousCategory : null,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: selectedCategoryIndex > 0 ? Color.fromARGB(255, 58, 164, 119) : Colors.grey,
                            size: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: selectedCategoryIndex < categories.length - 1 ? _nextCategory : null,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: selectedCategoryIndex < categories.length - 1 ? Color.fromARGB(255, 58, 164, 119) : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedCategoryIndex == index;
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(
                            categories[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategoryIndex = index;
                            });
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          selectedColor: Color.fromARGB(255, 58, 164, 119),
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          checkmarkColor: Color.fromARGB(255, 58, 164, 119),
                          showCheckmark: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Sezione Prodotti con PageView
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Prodotti',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      itemCount: categories.length,
                      itemBuilder: (context, categoryIndex) {
                        final products = getProductsForCategory(categories[categoryIndex]);
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(product: product);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final double rating;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Immagine prodotto con pulsante add
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        // Aggiungi alla lista
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} aggiunto alla lista'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Informazioni prodotto
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '€${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            product.rating.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}