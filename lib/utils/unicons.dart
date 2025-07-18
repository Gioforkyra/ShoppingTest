import 'package:flutter/widgets.dart';

class Unicons {
  Unicons._(); // Costruttore privato

  static const _kFontFam = 'Unicons'; // Deve corrispondere a 'family' in pubspec.yaml
  static const String? _kFontPkg = null;

  // ESEMPI - Dovrai sostituire questi valori con i code points reali delle icone Unicons che ti servono!
  // Trovali nella documentazione/cheat sheet del font Unicons.
  static const IconData uniHeartFill = IconData(0xe9a6, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData uniShoppingBag = IconData(0xe963, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData uniQrcodeScan = IconData(0xe993, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData uniUserCircle = IconData(0xe9c5, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData uniSearch = IconData(0xe9b6, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  // ... aggiungi tutte le icone che userai
}