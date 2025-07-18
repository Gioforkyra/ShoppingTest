// lib/widgets/nutritional_pie_chart.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_shopping/models/product.dart';

class NutritionalPieChart extends StatefulWidget {
  final Product product;

  const NutritionalPieChart({Key? key, required this.product}) : super(key: key);

  @override
  State<NutritionalPieChart> createState() => _NutritionalPieChartState();
}

class _NutritionalPieChartState extends State<NutritionalPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    // Calcoliamo il totale dei macro-nutrienti principali
    final totalMacro = product.fat + product.sugars + product.salt + product.carbohydrates + product.proteins;

    if (totalMacro == 0) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Dati nutrizionali non disponibili per il grafico a torta.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    String centerPercentageText = '0.0%';
    String maxMacroName = '';

    // Trova il macro-nutriente con il valore più alto
    double maxMacroValue = 0;
    if (product.fat > maxMacroValue) {
      maxMacroValue = product.fat;
      maxMacroName = 'Grassi';
    }
    if (product.sugars > maxMacroValue) {
      maxMacroValue = product.sugars;
      maxMacroName = 'Zuccheri';
    }
    if (product.salt > maxMacroValue) {
      maxMacroValue = product.salt;
      maxMacroName = 'Sale';
    }
    if (product.carbohydrates > maxMacroValue) { // AGGIUNTO
      maxMacroValue = product.carbohydrates;
      maxMacroName = 'Carboidrati';
    }
    if (product.proteins > maxMacroValue) { // AGGIUNTO
      maxMacroValue = product.proteins;
      maxMacroName = 'Proteine';
    }


    if (totalMacro > 0) {
      centerPercentageText = '${(maxMacroValue / totalMacro * 100).toStringAsFixed(1)}%';
    }

    return AspectRatio(
      aspectRatio: 1.0, // Modificato per un formato quadrato
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row( // Usiamo una Row per affiancare grafico e legenda
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3, // Regola questo valore per bilanciare spazio con la legenda
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 6,
                            centerSpaceRadius: 70,
                            sections: _getSections(totalMacro),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              centerPercentageText,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            if (maxMacroName.isNotEmpty)
                              Text(
                                maxMacroName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2, // Spazio per la legenda, puoi aumentare se necessario
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0), // Sposta la legenda a destra
                      child: SingleChildScrollView( // Consente lo scrolling se ci sono molte voci
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _generateLegendItems(totalMacro),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  List<PieChartSectionData> _getSections(double total) {
    final List<Color> colors = [
      const Color.fromARGB(255, 214, 88, 55), // Grassi - Colore esistente
      const Color.fromARGB(255, 205, 128, 66), // Zuccheri - Colore esistente
      const Color.fromARGB(255, 232, 213, 87), // Sale - Colore esistente
      const Color.fromARGB(255, 166, 212, 94), // Colore per Carboidrati (nuovo)
      const Color.fromARGB(255, 42, 183, 113), // Colore per Proteine (nuovo)
    ];

    final List<double> values = [
      widget.product.fat,
      widget.product.sugars,
      widget.product.salt,
      widget.product.carbohydrates, // AGGIUNTO
      widget.product.proteins, // AGGIUNTO
    ];

    List<PieChartSectionData> sections = [];
    for (int i = 0; i < values.length; i++) {
      if (values[i] > 0) {
        final isTouched = i == touchedIndex;
        final double radius = isTouched ? 40 : 30;
        
        sections.add(
          PieChartSectionData(
            color: colors[i],
            value: values[i],
            title: '',
            radius: radius,
          ),
        );
      }
    }
    return sections;
  }

  List<Widget> _generateLegendItems(double total) {
    final List<Map<String, dynamic>> data = [
      {'label': 'Grassi', 'value': widget.product.fat, 'color': const Color.fromARGB(255, 214, 88, 55)},
      {'label': 'Zuccheri', 'value': widget.product.sugars, 'color': const Color.fromARGB(255, 205, 128, 66)},
      {'label': 'Sale', 'value': widget.product.salt, 'color': const Color.fromARGB(255,232, 213, 87)},
      {'label': 'Carboidrati', 'value': widget.product.carbohydrates, 'color': const Color.fromARGB(255, 166, 212, 94)}, // AGGIUNTO
      {'label': 'Proteine', 'value': widget.product.proteins, 'color': const Color.fromARGB(255, 42, 183, 113)}, // AGGIUNTO
    ];

    List<Widget> legendItems = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i]['value'] > 0) {
        final percent = (data[i]['value'] / total * 100);
        legendItems.add(
          _LegendRow(
            color: data[i]['color'] as Color,
            // Per mettere tutto su una riga, riduco la precisione e disabilito softWrap nel _LegendRow
            title: '${data[i]['label']}: ${data[i]['value'].toStringAsFixed(1)}g (${percent.toStringAsFixed(percent == percent.roundToDouble() ? 0 : 1)}%)',
          ),
        );
      }
    }
    return legendItems;
  }
}

class _LegendRow extends StatelessWidget {
  final Color color;
  final String title;

  const _LegendRow({Key? key, required this.color, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Occupa solo lo spazio minimo
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 6),
          Flexible( // Usa Flexible per consentire il troncamento se la riga è troppo lunga
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 10, // Dimensione del font ridotta per accomodare più testo
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              softWrap: false, // Evita che il testo vada a capo
              maxLines: 1,     // Forza il testo su una singola riga
              overflow: TextOverflow.ellipsis, // Aggiunge "..." se il testo è troppo lungo
            ),
          ),
        ],
      ),
    );
  }
}