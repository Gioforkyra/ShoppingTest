import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping/providers/product_catalog_provider.dart';
import 'package:smart_shopping/screens/shopping_list_screen.dart';
import 'package:smart_shopping/screens/catalogue_screen.dart';
import 'package:smart_shopping/screens/scanner_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductCatalogProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 1;
  final List<Color> _itemSelectedColors = [
    Color.fromARGB(255, 58, 164, 119),
    Color.fromARGB(255, 58, 164, 119),
    Color.fromARGB(255, 58, 164, 119),
    Color.fromARGB(255, 58, 164, 119),
    Color.fromARGB(255, 58, 164, 119),
  ];

  static final List<Widget> _pages = <Widget>[
    const CatalogueScreen(),
    const ScannerScreen(),
    const ShoppingListScreen(),
    const Center(child: Text('Schermata Analisi Placeholder', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Schermata Profilo Placeholder', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        cardTheme: CardThemeData(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: const Color.fromARGB(255, 223, 138, 140),
          margin: EdgeInsets.zero,
        ),
      ),

      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        body: _pages[_selectedIndex],

        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: const Color(0xFF1A1A1A),

          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Catalogo"),
              selectedColor: _itemSelectedColors[0],
              unselectedColor: Color.fromARGB(255, 58, 164, 119),
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.crop_free),
              title: const Text("Scanner"),
              selectedColor: _itemSelectedColors[1],
              unselectedColor: Color.fromARGB(255, 58, 164, 119),
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              title: const Text("Lista"),
              selectedColor: _itemSelectedColors[2],
              unselectedColor: Color.fromARGB(255, 58, 164, 119),
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.bar_chart_outlined),
              title: const Text("Analisi"),
              selectedColor: _itemSelectedColors[3],
              unselectedColor: Color.fromARGB(255, 58, 164, 119),
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profilo"),
              selectedColor: _itemSelectedColors[4],
              unselectedColor: Color.fromARGB(255, 58, 164, 119),
            ),
          ],
        ),
      ),
    );
  }
}

