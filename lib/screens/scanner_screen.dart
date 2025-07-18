import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping/providers/product_catalog_provider.dart';
import 'package:smart_shopping/widgets/nutritional_pie_chart.dart';
import 'package:smart_shopping/models/product.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Consumer<ProductCatalogProvider>(
          builder: (context, provider, child) {
            if (provider.scannedProduct != null) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  provider.clearScannedProduct();
                },
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  // Azione per chiudere la schermata di scansione
                  // Es: Navigator.of(context).pop();
                },
              );
            }
          },
        ),
        title: Consumer<ProductCatalogProvider>(
          builder: (context, provider, child) {
            return Text(
              provider.scannedProduct != null ? 'Scan Result' : 'Scanning',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            );
          },
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Consumer<ProductCatalogProvider>(
        builder: (context, provider, child) {
          if (provider.scannedProduct != null) {
            final product = provider.scannedProduct!;
            return _buildScanResultContent(context, product, provider);
          } else {
            return _buildScanningContent(context, provider);
          }
        },
      ),
    );
  }

  Widget _buildScanResultContent(BuildContext context, Product product, ProductCatalogProvider provider) {
    // Determina il colore del Nutri-Score in base ai criteri
    Color nutriScoreColor;
    if (product.nutriscore == 'E' || product.sugars > 20.0 || product.fat > 30.0) {
      nutriScoreColor = Colors.red;
    } else if (product.nutriscore == 'A' && product.sugars <= 5.0 && product.fat <= 10.0) {
      nutriScoreColor = const Color.fromARGB(255, 58, 164, 119); // Verde più scuro
    } else {
      nutriScoreColor = Colors.orange;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Informazioni base del prodotto scansionato
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 57, 56, 56),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox.shrink(),
                    // --- MODIFICA QUI: Applicazione del colore dinamico al Nutri-Score ---
                    Text(
                      'Nutri-Score: ${product.nutriscore}',
                      style: TextStyle( // Usiamo TextStyle dinamico
                        fontSize: 14,
                        color: nutriScoreColor, // Applica il colore calcolato
                        fontWeight: FontWeight.w700, // Più bold per risaltare
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Modificato a bianco per tema scuro
                    fontFamily: 'Poppins',
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 4),
                Text(
                  'Brand: ${product.brand}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'Poppins',
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          size: 100,
                          color: Colors.grey,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Sezione Tabs (Nutrition / Allergies)
          DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 58, 164, 119),
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: 'Nutrition'),
                      Tab(text: 'Allergies'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Valori nutrizionali
                            _buildNutritionalDetail('Calorie', '${product.calories} kcal'),
                            _buildNutritionalDetail('Grassi', '${product.fat.toStringAsFixed(1)} g'),
                            _buildNutritionalDetail('Zuccheri', '${product.sugars.toStringAsFixed(1)} g'),
                            _buildNutritionalDetail('Sale', '${product.salt.toStringAsFixed(3)} g'),
                            const SizedBox(height: 30),

                            // Grafico nutrizionale spostato più in basso
                            Center(
                              child: SizedBox(
                                width: 220,
                                height: 220,
                                child: NutritionalPieChart(product: product),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text(
                          'No allergy information available.',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Sezione Positives / Negatives
          _buildNutritionalImpactSection('Negatives', [
            _buildImpactItem('Cholesterol', '50gr', const Color.fromARGB(255, 131, 12, 3)),
            _buildImpactItem('Unsat. Fats', '30gr', Color.fromARGB(255, 131, 12, 3)),
          ]),
          const SizedBox(height: 16),
          _buildNutritionalImpactSection('Positives', [
            _buildImpactItem('Protein', '50gr', const Color.fromARGB(255, 139, 251, 143)),
            _buildImpactItem('Energy', '55gr', const Color.fromARGB(255, 139, 251, 143)),
          ]),
          const SizedBox(height: 24),

          // Sezione Alternative Products
          const Text(
            'Alternative Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Nessun prodotto alternativo disponibile.',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Alert, se presente
          if (provider.showAlert)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.shade400),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Attenzione: Prodotto con Nutri-Score E o alto contenuto di zuccheri!',
                      style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScanningContent(BuildContext context, ProductCatalogProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24, width: 2),
          ),
          child: const Center(
            child: Icon(
              Icons.qr_code_scanner,
              size: 80,
              color: Colors.white54,
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Scanning...',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Next Steps...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              _buildStepItem('Enable Camera access at', 'settings - Privacy - Camera'),
              _buildStepItem('Place your food product with the bar code at the center of your screen', ''),
              _buildStepItem('Nutriscan will handle the rest', ''),
            ],
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: provider.simulateBarcodeScan,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 58, 164, 119),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Simula Scansione Barcode',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 24, 26, 30),
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionalDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionalImpactSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: items,
        ),
      ],
    );
  }

  Widget _buildImpactItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: $value',
              style: TextStyle(
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(String mainText, String subText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color.fromARGB(255, 58, 164, 119), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                  softWrap: true,
                ),
                if (subText.isNotEmpty)
                  Text(
                    subText,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                    softWrap: true,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}