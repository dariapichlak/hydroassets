
// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'dart:typed_data';

// ======== MODELE PRODUKTÓW I OPAKOWAŃ (przeklej z poprzedniego pliku) ========

class ProductPack {
  final double amount; // np. 5, 20
  final String unit;   // "kg", "L", "m"
  final double price;

  ProductPack({required this.amount, required this.unit, required this.price});
}

class Product {
  final String name;
  final String category; // grunt, hydroizolacja, dodatek, mata, płatki, naicoplast
  final List<ProductPack> packs;

  Product({required this.name, required this.category, required this.packs});
}

// ======== LISTA PRODUKTÓW ========

final List<Product> products = [
  // Hydroizolacje
  Product(name: "Nailastic 5F", category: "hydroizolacja", packs: [
    ProductPack(amount: 1, unit: "kg", price: 36.65),
    ProductPack(amount: 5, unit: "kg", price: 150.67),
    ProductPack(amount: 20, unit: "kg", price: 496.92),
  ]),
  Product(name: "Nailastic 10F", category: "hydroizolacja", packs: [
    ProductPack(amount: 1, unit: "kg", price: 60.58),
    ProductPack(amount: 5, unit: "kg", price: 270.29),
    ProductPack(amount: 20, unit: "kg", price: 961.86),
  ]),
  Product(name: "Nailastic AP", category: "hydroizolacja", packs: [
    ProductPack(amount: 1, unit: "kg", price: 123.55),
    ProductPack(amount: 5, unit: "kg", price: 584.25),
    ProductPack(amount: 10, unit: "kg", price: 1131.60),
  ]),
  Product(name: "Nailastic 7", category: "hydroizolacja", packs: [
    ProductPack(amount: 1, unit: "kg", price: 48.15),
    ProductPack(amount: 5, unit: "kg", price: 208.48),
    ProductPack(amount: 20, unit: "kg", price: 713.40),
  ]),
  Product(name: "Nailastic BIT-F", category: "hydroizolacja", packs: [
    ProductPack(amount: 1, unit: "kg", price: 50.80),
    ProductPack(amount: 5, unit: "kg", price: 221.40),
    ProductPack(amount: 20, unit: "kg", price: 767.52),
  ]),
  Product(name: "Nailastic BIT", category: "hydroizolacja", packs: [
    ProductPack(amount: 1, unit: "kg", price: 48.15),
    ProductPack(amount: 5, unit: "kg", price: 208.48),
    ProductPack(amount: 20, unit: "kg", price: 713.40),
  ]),
  Product(name: "Cemenguaina", category: "hydroizolacja", packs: [
    ProductPack(amount: 5, unit: "kg", price: 289.67),
    ProductPack(amount: 20, unit: "kg", price: 969.24),
  ]),
  Product(name: "Cemenguaina Fibrata", category: "hydroizolacja", packs: [
    ProductPack(amount: 5, unit: "kg", price: 304.43),
    ProductPack(amount: 20, unit: "kg", price: 1028.28),
  ]),
  // Grunty
  Product(name: "Naiprimer 45", category: "grunt", packs: [
    ProductPack(amount: 1, unit: "L", price: 109.96),
    ProductPack(amount: 5, unit: "L", price: 522.75),
  ]),
  Product(name: "Naiprimer 45H", category: "grunt", packs: [
    ProductPack(amount: 1, unit: "L", price: 102.21),
    ProductPack(amount: 5, unit: "L", price: 478.78),
  ]),
  Product(name: "Primaresina Barriera a Vapore", category: "grunt", packs: [
    ProductPack(amount: 5, unit: "kg", price: 729.94),
    ProductPack(amount: 10, unit: "kg", price: 1434.80),
    ProductPack(amount: 20, unit: "kg", price: 2789.64),
  ]),
  Product(name: "Nailastic BIT-F jako grunt", category: "grunt", packs: [
    ProductPack(amount: 1, unit: "kg", price: 50.80),
    ProductPack(amount: 5, unit: "kg", price: 221.40),
    ProductPack(amount: 20, unit: "kg", price: 767.52),
  ]),
  Product(name: "Nailastic BIT jako grunt", category: "grunt", packs: [
    ProductPack(amount: 1, unit: "kg", price: 48.15),
    ProductPack(amount: 5, unit: "kg", price: 208.48),
    ProductPack(amount: 20, unit: "kg", price: 713.40),
  ]),
  Product(name: "Nairust", category: "grunt", packs: [
    ProductPack(amount: 1, unit: "L", price: 89.99),
    ProductPack(amount: 5, unit: "L", price: 416.97),
  ]),
  // Dodatek
  Product(name: "Polimero", category: "dodatek", packs: [
    ProductPack(amount: 0.29, unit: "L", price: 82.23),
  ]),
  // Mata
  Product(name: "MAT225", category: "mata", packs: [
    ProductPack(amount: 1, unit: "m", price: 36.00),
    ProductPack(amount: 25, unit: "m", price: 761.06),
    ProductPack(amount: 100, unit: "m", price: 3044.24),
  ]),
  Product(name: "TexCore130", category: "mata", packs: [
    ProductPack(amount: 1, unit: "m", price: 28.00),
    ProductPack(amount: 50, unit: "m", price: 900.98),
  ]),
  // Płatki dekoracyjne
  Product(name: "Płatki Dekoracyjne", category: "płatki", packs: [
    ProductPack(amount: 1, unit: "kg", price: 100.00),
  ]),
  // Naicoplast
  Product(name: "Naicoplast", category: "naicoplast", packs: [
    ProductPack(amount: 1, unit: "kg", price: 77.06),
    ProductPack(amount: 5, unit: "kg", price: 353.32),
    ProductPack(amount: 10, unit: "kg", price: 668.51),
  ]),
];


// ======== ZUŻYCIA, WZORY, OGRANICZENIA ========

const Map<String, double> gruntUsage = {
  "Naiprimer 45": 0.2,
  "Naiprimer 45H": 0.18,
  "Primaresina Barriera a Vapore": 0.35,
  "Nailastic BIT jako grunt": 1.0,
  "Nailastic BIT-F jako grunt": 1.0,
  "Nairust": 0.1,
};
const double polimeroUsage = 0.029;
const double matUsage = 1.05;
const double platkiUsage = 0.1;
const double naicoplastUsage = 0.5;

const List<String> hydroExcludedForBitGrunt = [
  "Nailastic BIT-F",
  "Nailastic BIT",
  "Cemenguaina",
  "Cemenguaina Fibrata",
];

const Map<String, Map<String, double>> hydroUsage = {
  "default": {
    "Nailastic 5F": 2.0,
    "Nailastic 10F": 2.0,
    "Nailastic BIT-F": 2.5,
    "Nailastic BIT": 2.0,
    "Cemenguaina": 2.0,
    "Cemenguaina Fibrata": 2.0,
    "Nailastic AP": 1.2,
    "Nailastic 7": 2.0,
  },
  "bitGrunt": {
    "Nailastic 5F": 1.0,
    "Nailastic 10F": 1.0,
    "Nailastic AP": 1.0,
    "Nailastic 7": 1.0,
  },
};

// ======== ALGORYTM DOBORU OPAKOWAŃ ========

Map<ProductPack, int> selectPacks(Product product, double needed) {
  final packs = List<ProductPack>.from(product.packs)
    ..sort((a, b) => b.amount.compareTo(a.amount));
  double remain = needed;
  Map<ProductPack, int> selection = {};

  for (final pack in packs) {
    int count = (remain ~/ pack.amount);
    remain -= count * pack.amount;
    if (count > 0) selection[pack] = count;
  }
  if (remain > 0) {
    final smallest = packs.last;
    selection[smallest] = (selection[smallest] ?? 0) + 1;
  }
  return selection;
}

// ======== GŁÓWNA FUNKCJA WYCENY ========

class EstimateResult {
  final Map<String, Map<ProductPack, int>> packList;
  final double totalPrice;
  EstimateResult(this.packList, this.totalPrice);
}

EstimateResult calculateEstimate({
  required double area,
  required String grunt,
  required String hydro,
  required String dodatek,
  required String mata,
  required String platki,
  required String naicoplast,
}) {
  final Map<String, Map<ProductPack, int>> packList = {};
  double totalPrice = 0.0;

  // GRUNT
  if (grunt != "brak gruntu" && gruntUsage.containsKey(grunt)) {
    double needed = area * gruntUsage[grunt]!;
    final product = products.firstWhere((p) => p.name == grunt);
    var packs = selectPacks(product, needed);
    packList["Grunt: $grunt"] = packs;
    packs.forEach((pack, qty) => totalPrice += pack.price * qty);
  }

  // DODATEK
  if (dodatek != "brak dodatków") {
    double needed = area * polimeroUsage;
    final product = products.firstWhere((p) => p.name == dodatek);
    var packs = selectPacks(product, needed);
    packList["Dodatek: $dodatek"] = packs;
    packs.forEach((pack, qty) => totalPrice += pack.price * qty);
  }

  // MATA
  if (mata != "brak maty") {
    double needed = area * matUsage;
    final product = products.firstWhere((p) => p.name == mata);
    var packs = selectPacks(product, needed);
    packList["Mata: $mata"] = packs;
    packs.forEach((pack, qty) => totalPrice += pack.price * qty);
  }

  // PŁATKI
  if (platki != "brak płatków") {
    double needed = area * platkiUsage;
    final product = products.firstWhere((p) => p.name == platki);
    var packs = selectPacks(product, needed);
    packList["Płatki: $platki"] = packs;
    packs.forEach((pack, qty) => totalPrice += pack.price * qty);
  }

  // NAICOPLAST
  if (naicoplast != "brak Naicoplast") {
    double needed = area * naicoplastUsage;
    final product = products.firstWhere((p) => p.name == naicoplast);
    var packs = selectPacks(product, needed);
    packList["Naicoplast: $naicoplast"] = packs;
    packs.forEach((pack, qty) => totalPrice += pack.price * qty);
  }

  // HYDROIZOLACJA
  double? zuzycie;
  bool bitGrunt = grunt == "Nailastic BIT jako grunt" || grunt == "Nailastic BIT-F jako grunt";
  if (bitGrunt) {
    zuzycie = hydroUsage["bitGrunt"]?[hydro];
  } else {
    zuzycie = hydroUsage["default"]?[hydro];
  }
  if (bitGrunt && hydroExcludedForBitGrunt.contains(hydro)) {
    // Pomijamy niedozwolone
  } else if (zuzycie != null) {
    double needed = area * zuzycie;
    final product = products.firstWhere((p) => p.name == hydro);
    var packs = selectPacks(product, needed);
    packList["Hydroizolacja: $hydro"] = packs;
    packs.forEach((pack, qty) => totalPrice += pack.price * qty);
  }
  return EstimateResult(packList, totalPrice);
}

// ======== UI WIDGET + PDF ========

class Calculator2 extends StatefulWidget {
  @override
  State<Calculator2> createState() => _Calculator2State();
}

class _Calculator2State extends State<Calculator2> {
  final _formKey = GlobalKey<FormState>();
  final _areaController = TextEditingController();
  final _rabatController = TextEditingController(text: "0");
  final _clientNameController = TextEditingController();
final _clientPhoneController = TextEditingController();
final _clientEmailController = TextEditingController();
  // ===== WYKONANIE – pola stanu =====
  final TextEditingController _dojazdKmController = TextEditingController(text: "0");
  final TextEditingController _execRabatController = TextEditingController(text: "0");

  // Opcje zakresu wykonania – każda pozycja ma etykietę, typ wyceny i stawkę
  // typ: fixed | per_m2 | per_10m2
  final Map<String, List<Map<String, dynamic>>> _executionOptions = {
    "Przygotowanie podłoża": [
      {"id": "oczyszczenie_odkurzanie", "label": "oczyszczenie powierzchni z zanieczyszczeń i pyłu, odkurzanie", "type": "fixed", "price": 0.0},
      {"id": "naprawy_miejscowe", "label": "naprawa ewentualnych uszkodzeń powierzchni, miejscowe naprawy", "type": "fixed", "price": 0.0},
      {"id": "naprawa_pekniec", "label": "naprawa pęknięć wzdłużnych", "type": "per_10m2", "price": 400.0},
      {"id": "skucie_plytek", "label": "skucie płytek", "type": "per_m2", "price": 35.0},
      {"id": "wyrownanie_podloza", "label": "wzmocnienie i wyrównanie powierzchni np. wylewki samopoziomujące", "type": "per_m2", "price": 100.0},
      {"id": "gruntowanie", "label": "gruntowanie", "type": "fixed", "price": 0.0},
      {"id": "usuniecie_starych_pow", "label": "usunięcie starych powłok i warstw malarskich", "type": "per_m2", "price": 50.0},
      {"id": "mycie_cisnieniowe", "label": "mycie ciśnieniowe powierzchni", "type": "per_m2", "price": 35.0},
      {"id": "uszczelnienie_naroznikow", "label": "uszczelnienie połączeń i narożników", "type": "fixed", "price": 0.0},
      {"id": "szlifowanie", "label": "szlifowanie maszyną przemysłową całej powierzchni", "type": "per_m2", "price": 150.0},
    ],
    "Nałożenie warstwy bazowej żywicy": [
      {"id": "bazowa_mieszanie", "label": "wymieszanie składników zgodnie z instrukcjami producenta", "type": "fixed", "price": 0.0},
      {"id": "bazowa_nalozenie", "label": "nałożenie pierwszej warstwy żywicy przy użyciu narzędzi do aplikacji", "type": "fixed", "price": 0.0},
    ],
    "Nałożenie warstwy końcowej żywicy": [
      {"id": "koncowa_mieszanie", "label": "wymieszanie składników zgodnie z instrukcjami producenta", "type": "fixed", "price": 0.0},
      {"id": "koncowa_nalozenie", "label": "nałożenie pierwszej warstwy żywicy przy użyciu narzędzi do aplikacji", "type": "fixed", "price": 0.0},
      {"id": "zasyp_platkami", "label": "wykonanie zasypu z płatków dekoracyjnych", "type": "fixed", "price": 0.0},
      {"id": "lakierowanie", "label": "lakierowanie odpowiednim lakierem", "type": "fixed", "price": 0.0},
    ],
    "Prace dodatkowe": [
      {"id": "rusztowania", "label": "montaż i demontaż rusztowań w celu wykonania prac na wysokościach", "type": "per_m2", "price": 200.0},
      {"id": "murarskie_tynkarskie", "label": "prace murarskie i tynkarskie w celu przygotowania powierzchni do nałożenia powłoki żywicznej", "type": "per_m2", "price": 20.0},
      {"id": "montaz_listew", "label": "montaż listew, opierzeń", "type": "per_m2", "price": 30.0},
      {"id": "doklejanie_plytek", "label": "doklejanie płytek", "type": "fixed", "price": 0.0},
    ],
    "Oczyszczanie i usuwanie odpadów": [
      {"id": "demontaz_elementow", "label": "demontaż istniejących elementów, które mogą przeszkadzać w wykonaniu usługi", "type": "per_m2", "price": 30.0},
      {"id": "oczyszczenie_terenu", "label": "oczyszczenie terenu z gruzu i innych odpadów budowlanych", "type": "fixed", "price": 0.0},
      {"id": "utylizacja", "label": "utylizacja odpadów zgodnie z przepisami i dostarczenie do wyznaczonych miejsc", "type": "per_m2", "price": 50.0},
    ],
  };

  final Set<String> _selectedExecution = {};



  final gruntOptions = [
    "Naiprimer 45",
    "Naiprimer 45H",
    "Nailastic BIT jako grunt",
    "Nailastic BIT-F jako grunt",
    "Primaresina Barriera a Vapore",
    "Nairust",
    "brak gruntu",
  ];
  final hydroOptions = [
    "Nailastic 5F",
    "Nailastic 10F",
    "Nailastic BIT-F",
    "Nailastic BIT",
    "Cemenguaina",
    "Cemenguaina Fibrata",
    "Nailastic AP",
    "Nailastic 7",
  ];
  final dodatekOptions = [
    "Polimero",
    "brak dodatków",
  ];
  final mataOptions = [
    "MAT225",
    "TexCore130",
    "brak maty",
  ];
  final platkiOptions = [
    "Płatki Dekoracyjne",
    "brak płatków",
  ];
  final naicoplastOptions = [
    "Naicoplast",
    "brak Naicoplast",
  ];
  final osobaOptions = ["Marek", "Iwona", "Roman"];

  final Map<String, Map<String, String>> osobyDane = {
  "Marek": {
    "imie": "Marek Gołembiewski",
    "tel": "505 785 328",
    "mail": "marek@zremontowani.pl",
  },
  "Iwona": {
    "imie": "Iwona Pavelka",
    "tel": "510 747 343",
    "mail": "iwona@zremontowani.pl",
  },
  "Roman": {
    "imie": "Roman Bliwert",
    "tel": "797 127 427",
    "mail": "roman@zremontowani.pl",
  },
};


  String? selectedGrunt = "Naiprimer 45";
  String? selectedHydro = "Nailastic 5F";
  String? selectedDodatek = "brak dodatków";
  String? selectedMata = "brak maty";
  String? selectedPlatki = "brak płatków";
  String? selectedNaicoplast = "brak Naicoplast";
  String? selectedOsoba = "Marek";

  EstimateResult? _result;
  double? _lastArea;
  double _lastRabat = 0.0;

void _calculate() {
  if (!_formKey.currentState!.validate()) return;
  final area = double.tryParse(_areaController.text.replaceAll(',', '.'));
  if (area == null || area <= 0) return;

  double rabat = double.tryParse(_rabatController.text.replaceAll(',', '.')) ?? 0.0;
  double maxRabat = (selectedOsoba == "Iwona" || selectedOsoba == "Roman") ? 25.0 : 100.0;
  if (rabat < 0) rabat = 0.0;
  if (rabat > maxRabat) rabat = maxRabat;

  final result = calculateEstimate(
    area: area,
    grunt: selectedGrunt ?? "brak gruntu",
    hydro: selectedHydro ?? hydroOptions.first,
    dodatek: selectedDodatek ?? "brak dodatków",
    mata: selectedMata ?? "brak maty",
    platki: selectedPlatki ?? "brak płatków",
    naicoplast: selectedNaicoplast ?? "brak Naicoplast",
  );
  setState(() {
    _result = result;
    _lastArea = area;
    _lastRabat = rabat;
  });
}


  List<String> _hydroFilteredOptions() {
    final isBitGrunt = selectedGrunt == "Nailastic BIT jako grunt" || selectedGrunt == "Nailastic BIT-F jako grunt";
    final excluded = [
      "Nailastic BIT-F",
      "Nailastic BIT",
      // "Cemenguaina",
      // "Cemenguaina Fibrata",
    ];
    return isBitGrunt
        ? hydroOptions.where((h) => !excluded.contains(h)).toList()
        : hydroOptions;
  }



  // ===== WYKONANIE – logika kosztów =====
  double _computeExecutionTasksCost(double area) {
    double sum = 0.0;
    for (final entry in _executionOptions.entries) {
      for (final item in entry.value) {
        final String id = item["id"];
        if (_selectedExecution.contains(id)) {
          final String type = item["type"];
          final double price = (item["price"] as num).toDouble();
          if (type == "fixed") {
            sum += price;
          } else if (type == "per_m2") {
            sum += price * area;
          } else if (type == "per_10m2") {
            if (area > 0) {
              final blocks = (area / 10.0).ceil();
              sum += price * blocks;
            }
          }
        }
      }
    }
    return sum;
  }

  List<String> _selectedExecutionLabels() {
    final labels = <String>[];
    for (final entry in _executionOptions.entries) {
      for (final item in entry.value) {
        if (_selectedExecution.contains(item["id"])) {
          labels.add(item["label"] as String);
        }
      }
    }
    return labels;
  }

  Widget _buildExecutionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Wykonanie",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        const SizedBox(height: 12),

        // Dojazd [km]
        _decoratedField(
          child: TextFormField(
            controller: _dojazdKmController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: "Dojazd [km]",
              labelStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.black),
            validator: (v) {
              if (v == null || v.isEmpty) return null;
              final value = double.tryParse(v.replaceAll(',', '.'));
              if (value == null || value < 0) return 'Podaj liczbę km ≥ 0';
              return null;
            },
          ),
        ),

        const SizedBox(height: 12),

        // Rabat na wykonanie [%]
        _decoratedField(
          child: TextFormField(
            controller: _execRabatController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: "Rabat na wykonanie (max 15%)",
              labelStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.black),
            validator: (v) {
              if (v == null || v.isEmpty) return null;
              final value = double.tryParse(v.replaceAll(',', '.'));
              if (value == null || value < 0 || value > 15) return '0-15%';
              return null;
            },
          ),
        ),

        const SizedBox(height: 12),

        // Lista usług podzielona na kategorie
        ..._executionOptions.entries.map((cat) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(cat.key, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                children: [
                  for (final item in cat.value)
                    CheckboxListTile(
                      value: _selectedExecution.contains(item["id"]),
                      onChanged: (v) => setState(() {
                        if (v == true) {
                          _selectedExecution.add(item["id"] as String);
                        } else {
                          _selectedExecution.remove(item["id"] as String);
                        }
                      }),
                      activeColor: Colors.orange,
                      title: Text(item["label"] as String, style: const TextStyle(color: Colors.black)),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildResult(EstimateResult result) {
  final sumaBrutto = result.totalPrice;
  final rabatValue = sumaBrutto * (_lastRabat / 100.0);
  final sumaPoRabacie = sumaBrutto - rabatValue;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_lastArea != null)
          Text(
            "Powierzchnia: ${_lastArea!.toStringAsFixed(2)} m²",
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        const SizedBox(height: 8),
        const Text(
          "Lista zakupowa",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        const SizedBox(height: 8),
        ...result.packList.entries.expand((entry) {
          return [
            Text(
              entry.key,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            ...entry.value.entries.map((e) => Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 2),
                  child: Text(
                    '${e.key.amount}${e.key.unit} × ${e.value} = ${(e.key.price * e.value).toStringAsFixed(2)} zł',
                    style: const TextStyle(color: Colors.black),
                  ),
                )),
            const SizedBox(height: 8),
          ];
        }),
        const Divider(color: Colors.orange),
        Text(
          "SUMA: ${result.totalPrice.toStringAsFixed(2)} zł",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        if (_lastRabat > 0)
          Text(
            "Rabat: $_lastRabat%",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        if (_lastRabat > 0)
          Text(
            "Do zapłaty po rabacie: ${sumaPoRabacie.toStringAsFixed(2)} zł (brutto)",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.orange),
          ),
        
        // ===== Sekcja Wykonanie (opcjonalna) =====
        () {
          final km = double.tryParse(_dojazdKmController.text.replaceAll(',', '.')) ?? 0.0;
          final travelCost = km > 0 ? km * 3.0 : 0.0;
          final tasksCost = _computeExecutionTasksCost(_lastArea ?? 0.0);
          final robocizna = (result.totalPrice * 2.0) + (km > 0 ? 1000.0 : 0.0);

          double execRabat = double.tryParse(_execRabatController.text.replaceAll(',', '.')) ?? 0.0;
          if (execRabat < 0) execRabat = 0.0;
          if (execRabat > 15) execRabat = 15.0;

          final execSubtotal = robocizna + travelCost + tasksCost;
          final execAfterDiscount = execSubtotal * (1 - execRabat / 100.0);
          final showExecution = km > 0 || _selectedExecution.isNotEmpty || execRabat > 0;

          final grandTotal = sumaPoRabacie + (showExecution ? execAfterDiscount : 0.0);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showExecution) ...[
                const SizedBox(height: 8),
                const Divider(color: Colors.orange),
                const Text(
                  "Wykonanie",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 6),
                Text(
                  "Robocizna: 2× materiały${km > 0 ? " + 1000 zł" : ""} = ${robocizna.toStringAsFixed(2)} zł",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                if (travelCost > 0)
                  Text(
                    "Dojazd: ${km.toStringAsFixed(0)} km × 3,00 zł = ${travelCost.toStringAsFixed(2)} zł",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                if (tasksCost > 0)
                  Text(
                    "Prace z listy: ${tasksCost.toStringAsFixed(2)} zł",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                if (execRabat > 0)
                  Text(
                    "Rabat na wykonanie: ${execRabat.toStringAsFixed(0)}%",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                const SizedBox(height: 6),
                const Divider(color: Colors.orange),
                Text(
                  "Suma wykonania po rabacie: ${execAfterDiscount.toStringAsFixed(2)} zł",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.orange),
                ),
                if (_selectedExecution.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Text(
                    "Zakres wykonania:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  ..._selectedExecutionLabels().map((s) => Padding(
                        padding: const EdgeInsets.only(left: 12.0, bottom: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("• ", style: TextStyle(color: Colors.black)),
                            Expanded(child: Text(s, style: const TextStyle(color: Colors.black))),
                          ],
                        ),
                      )),
                ],
                const SizedBox(height: 8),
                const Divider(color: Colors.orange),
                Text(
                  "Do zapłaty łącznie: ${grandTotal.toStringAsFixed(2)} zł",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.orange),
                ),
              ],
            ],
          );
        }(),
const SizedBox(height: 24),
        Center(
          child: SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
              label: const Text('Eksportuj do PDF', style: TextStyle(color: Colors.white, fontSize: 20)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 2,
              ),
              onPressed: () => _generatePDF(context),
            ),
          ),
        ),
      ],
    ),
  );
}

  Future<void> _generatePDF(BuildContext context) async {
    if (_result == null) return;

    final arial = pw.Font.ttf(await rootBundle.load('assets/fonts/arial.ttf'));
    final arialBold = pw.Font.ttf(await rootBundle.load('assets/fonts/arialbd.ttf'));
    final logoImage = await networkImage(
  'https://raw.githubusercontent.com/dariapichlak/hydroassets/main/oferta_logo2.jpg',
);
    final klientImie = _clientNameController.text.trim();
final klientMail = _clientEmailController.text.trim();
final klientTel = _clientPhoneController.text.trim();
    final now = DateTime.now();
    final numerOferty = DateFormat('ddMMyyyyHHmm').format(now);
    final dataWygenerowania = DateFormat('dd.MM.yyyy').format(now);

   final osobaInfo = osobyDane[selectedOsoba] ?? {};
final osobaPrzygotowujaca = osobaInfo["imie"] ?? '';
final emailPrzygotowujacego = osobaInfo["mail"] ?? '';
final telPrzygotowujacego = osobaInfo["tel"] ?? '';


    final powierzchnia = _lastArea?.toStringAsFixed(0) ?? '-';

    List<List<String>> rows = [];
    _result!.packList.forEach((cat, packs) {
      packs.forEach((pack, qty) {
        final nazwa = '${cat.split(':').last.trim()} ${pack.amount}${pack.unit}';
        final ilosc = '${qty} op.';
        final cena = (pack.price * qty);
        final rabatStr = _lastRabat > 0 ? "${_lastRabat.toStringAsFixed(0)}%" : "-";
        final cenaPoRabacie = cena * (1 - _lastRabat / 100.0);
        rows.add([
          nazwa,
          ilosc,
          cena.toStringAsFixed(2) + " zł",
          rabatStr,
          cenaPoRabacie.toStringAsFixed(2) + " zł"
        ]);
      });
    });

    final sumaBrutto = _result!.totalPrice;
    final rabatValue = sumaBrutto * (_lastRabat / 100.0);
    final sumaPoRabacie = sumaBrutto - rabatValue;
    final sumaNetto = sumaPoRabacie / 1.23;
    // ===== WYKONANIE – wyliczenia do PDF =====
    final double km = double.tryParse(_dojazdKmController.text.replaceAll(',', '.')) ?? 0.0;
    final double travelCost = km > 0 ? km * 3.0 : 0.0;
    final double robocizna = (sumaBrutto * 2.0) + (km > 0 ? 1000.0 : 0.0);
    final double tasksCost = _computeExecutionTasksCost(_lastArea ?? 0.0);
    double execRabat = double.tryParse(_execRabatController.text.replaceAll(',', '.')) ?? 0.0;
    if (execRabat < 0) execRabat = 0.0;
    if (execRabat > 15) execRabat = 15.0;
    final double execSubtotal = robocizna + travelCost + tasksCost;
    final double execAfterDiscount = execSubtotal * (1 - execRabat / 100.0);
    final bool showExecution = km > 0 || _selectedExecution.isNotEmpty || execRabat > 0;
    final double grandTotal = sumaPoRabacie + (showExecution ? execAfterDiscount : 0.0);

    final pdf = pw.Document();
    final czyJestRabat = _lastRabat > 0;

    pdf.addPage(
  pw.Page(
    margin: pw.EdgeInsets.zero, // Usuwamy domyślne marginesy – pełna kontrola layoutu
    build: (pw.Context context) {
      return pw.Row(
        children: [
          // LEWA CZĘŚĆ (2/3 szerokości) - oferta na białym tle
          pw.Container(
            width: PdfPageFormat.a4.width * 2 / 3,
            height: PdfPageFormat.a4.height,
            color: PdfColors.white,
            padding: const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 28),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                // --- Tu wkleiłem całą Twoją poprzednią zawartość Column ---
                // NAGŁÓWEK I OSOBA
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [pw.Container(child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
pw.Text('OFERTA', style: pw.TextStyle(font: arialBold, fontSize: 26, color: PdfColors.black)),
                pw.SizedBox(height: 2),
                pw.Text('# $numerOferty', style: pw.TextStyle(font: arialBold, fontSize: 14, color: PdfColors.grey700)),
pw.SizedBox(height: 2),
   pw.Text('Wygenerowano: $dataWygenerowania',
                  style: pw.TextStyle(font: arial, fontSize: 9, color: PdfColors.black)),
                ],),),
                pw.Container(child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
 pw.Text('Zremontowani.pl LTD',
                  style: pw.TextStyle(font: arialBold, fontSize: 12)),
                  pw.SizedBox(height: 3),
                pw.Text('ul. Wiczlińska 115A', style: pw.TextStyle(font: arial, fontSize: 9)),
                pw.SizedBox(height: 2,),
                pw.Text('81-578 Gdynia', style: pw.TextStyle(font: arial, fontSize: 9)),
                pw.SizedBox(height: 2,),
                pw.Text('NIP: 9121931736', style: pw.TextStyle(font: arial, fontSize: 9)),
                pw.SizedBox(height: 2,),
                ],),),
                ],),          
   pw.SizedBox(height: 16),               
 pw.Text('Klient:', style: pw.TextStyle(font: arialBold, fontSize: 12)),
 pw.SizedBox(height: 3),
                          pw.Text(klientImie, style: pw.TextStyle(font: arial, fontSize: 9)),
                          pw.SizedBox(height: 2),
                          pw.Text(klientMail, style: pw.TextStyle(font: arial, fontSize: 9)),
                           pw.SizedBox(height: 2),
                          pw.Text(klientTel, style: pw.TextStyle(font: arial, fontSize: 9)),
                pw.SizedBox(height: 14,),
                 pw.Text('Wycena materiałów', style: pw.TextStyle(font: arialBold, fontSize: 12)),
                 pw.SizedBox(height: 6),
                  pw.Text('Powierzchnia : $powierzchnia m2',
                      style: pw.TextStyle(font: arial, fontSize: 9)),
                        pw.SizedBox(height: 8), 
                pw.Divider(color: PdfColors.orange),
                // TABELA z rabatem
                pw.Table(
  border: pw.TableBorder.all(color: PdfColors.white, width: 1),
  columnWidths: czyJestRabat
      ? {
          0: const pw.FlexColumnWidth(3.1),
          1: const pw.FlexColumnWidth(1.0),
          2: const pw.FlexColumnWidth(1.6),
          3: const pw.FlexColumnWidth(1.0),
          4: const pw.FlexColumnWidth(1.5),
        }
      : {
          0: const pw.FlexColumnWidth(3.1),
          1: const pw.FlexColumnWidth(1.2),
          2: const pw.FlexColumnWidth(1.6),
        },
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(color: PdfColors.white),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 4),
                          child: pw.Text("Produkt", style: pw.TextStyle(font: arialBold, fontSize: 9)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 4),
                          child: pw.Text("Ilość", style: pw.TextStyle(font: arialBold, fontSize: 9)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 4),
                          child: pw.Text("Cena", style: pw.TextStyle(font: arialBold, fontSize: 9)),
                        ),
                        if (czyJestRabat)
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Text("Rabat", style: pw.TextStyle(font: arialBold, fontSize: 9)),
          ),
        if (czyJestRabat)
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Text("Cena po rabacie", style: pw.TextStyle(font: arialBold, fontSize: 9)),
          ),
                      ],
                    ),
                    ...rows.map((row) => pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 4),
                          child: pw.Text(row[0], style: pw.TextStyle(font: arial, fontSize: 8)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 4),
                          child: pw.Text(row[1], style: pw.TextStyle(font: arial, fontSize: 8)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 4),
                          child: pw.Text(row[2], style: pw.TextStyle(font: arial, fontSize: 8)),
                        ),
                       
                        if (czyJestRabat)
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Text(row[3], style: pw.TextStyle(font: arial, fontSize: 9)),
          ),
        if (czyJestRabat)
          pw.Padding(
            padding:  const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Text(row[4], style: pw.TextStyle(font: arial, fontSize: 9)),
          ),
                      ],
                    )),
                  ],
                ),
                pw.SizedBox(height: 3),
                pw.Divider(color: PdfColors.orange),
                     pw.SizedBox(height: 6),
                // Podsumowanie
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                         if (_lastRabat > 0)
                          pw.Text('Rabat: $_lastRabat%',
                              style: pw.TextStyle(font: arial, fontSize: 9)),
                              pw.SizedBox(height: 3),
                        pw.Text('Cena netto: ${sumaNetto.toStringAsFixed(2)} zł',
                            style: pw.TextStyle(font: arial, fontSize: 9)),
                             pw.SizedBox(height: 3),
                        pw.Text('VAT 23%',
                            style: pw.TextStyle(font: arial, fontSize: 9)),
                             pw.SizedBox(height: 3),
                        pw.Text('Razem: ${sumaPoRabacie.toStringAsFixed(2)} zł brutto',
                            style: pw.TextStyle(font: arialBold, fontSize: 10, color: PdfColors.black)),
                      ],
                    )
                  ],
                ),
                pw.SizedBox(height: 18),
                
                // ===== WYKONANIE (opcjonalnie) =====
                if (showExecution) ...[
                  pw.SizedBox(height: 12),
                  pw.Text('Wykonanie', style: pw.TextStyle(font: arialBold, fontSize: 12)),
                  pw.SizedBox(height: 6),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Robocizna: 2× materiały' + (km > 0 ? ' + 1000 zł' : '') + ' = ${robocizna.toStringAsFixed(2)} zł',
                        style: pw.TextStyle(font: arial, fontSize: 9),
                      ),
                      if (travelCost > 0)
                        pw.Text(
                          'Dojazd: ${km.toStringAsFixed(0)} km × 3,00 zł = ${travelCost.toStringAsFixed(2)} zł',
                          style: pw.TextStyle(font: arial, fontSize: 9),
                        ),
                      if (tasksCost > 0)
                        pw.Text(
                          'Prace z listy: ${tasksCost.toStringAsFixed(2)} zł',
                          style: pw.TextStyle(font: arial, fontSize: 9),
                        ),
                      if (execRabat > 0)
                        pw.Text(
                          'Rabat na wykonanie: ${execRabat.toStringAsFixed(0)}%',
                          style: pw.TextStyle(font: arial, fontSize: 9),
                        ),
                      pw.SizedBox(height: 6),
                      pw.Divider(color: PdfColors.orange),
                      pw.Text(
                        'Suma wykonania po rabacie: ${execAfterDiscount.toStringAsFixed(2)} zł',
                        style: pw.TextStyle(font: arialBold, fontSize: 10, color: PdfColors.orange),
                      ),
                      if (_selectedExecution.isNotEmpty) ...[
                        pw.SizedBox(height: 6),
                        pw.Text('Zakres wykonania:', style: pw.TextStyle(font: arialBold, fontSize: 10)),
                        pw.SizedBox(height: 4),
                        ..._selectedExecutionLabels().map(
                          (s) => pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('• ', style: pw.TextStyle(font: arial, fontSize: 9)),
                              pw.Expanded(child: pw.Text(s, style: pw.TextStyle(font: arial, fontSize: 9))),
                            ],
                          ),
                        ),
                      ],
                      pw.SizedBox(height: 8),
                      pw.Divider(color: PdfColors.orange),
                      pw.Text(
                        'Razem do zapłaty: ${grandTotal.toStringAsFixed(2)} zł',
                        style: pw.TextStyle(font: arialBold, fontSize: 12, color: PdfColors.orange),
                      ),
                    ],
                  ),
                ],
// KLIENT i POWIERZCHNIA
            
            
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                         
                           pw.Text('Oferta przygotowana przez:', style: pw.TextStyle(font: arialBold, fontSize: 10)),
                            pw.SizedBox(height: 3),
                pw.Text(osobaPrzygotowujaca, style: pw.TextStyle(font: arial, fontSize: 9)),
                 pw.SizedBox(height: 2),
                   pw.Text(telPrzygotowujacego, style: pw.TextStyle(font: arial, fontSize: 9)),
                 pw.SizedBox(height: 2),
               pw.Text(emailPrzygotowujacego, style: pw.TextStyle(font: arial, fontSize: 9)),
                pw.SizedBox(height: 14),
             
                    pw.Text('Materiały dostępne na',
                        style: pw.TextStyle(font: arialBold, fontSize: 10, color: PdfColors.orange)),
                          pw.Text('www.zremontowani.pl',
                        style: pw.TextStyle(font: arialBold, fontSize: 10, color: PdfColors.orange)),
                         pw.SizedBox(height: 14),
                    pw.Text('Oferta ważna przez 7 dni od daty wygenerowania.',
                        style: pw.TextStyle(font: arial, fontSize: 9, color: PdfColors.grey700)),
                          pw.SizedBox(height: 2),
                          if (_lastRabat > 0)
      pw.Text(
        'Oferta wraz z rabatami ważna tylko przy zamówieniu u przedstawiciela handlowego.',
        style: pw.TextStyle(font: arial, fontSize: 9, color: PdfColors.grey700),
      ),      
                  ],
                      ),
                    ),
                  
                  ],
                ),  
              ],
            ),
          ),
          // PRAWA CZĘŚĆ (1/3 szerokości) – logo rozciągnięte na całą wysokość

pw.Container(
  alignment: pw.Alignment.center,
  child: pw.Image(
    logoImage,
   fit: pw.BoxFit.cover, // pełne wypełnienie
              width: PdfPageFormat.a4.width / 3,
              height: PdfPageFormat.a4.height,
  ),
),

        ],
      );
    },
  ),
);


    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    appBar: AppBar(
      title: Center(
        child: Text('Gotowy do liczenia!',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Colors.grey[850],
      elevation: 1,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/appuiback1.png', 
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top:36.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ------- FORMULARZ (na białym kontenerze) -------
                  Container(
                    width: 500,
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 36),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 22,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         Image.asset(
        'assets/logo.png', // Ścieżka do Twojego obrazka
        height: 70),
        const SizedBox(height: 16,),
                          _decoratedField(
                            child: DropdownButtonFormField<String>(
                              value: selectedOsoba,
                              items: osobaOptions.map((osoba) =>
                                  DropdownMenuItem(value: osoba, child: Text(osoba, style: const TextStyle(color: Colors.black)))
                              ).toList(),
                              onChanged: (v) => setState(() => selectedOsoba = v),
                              decoration: const InputDecoration(
                                labelText: "Osoba generująca ofertę",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _decoratedField(
                            child: TextFormField(
                              controller: _areaController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: const InputDecoration(
                                labelText: "Powierzchnia [m²]",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.black),
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Podaj powierzchnię';
                                final value = double.tryParse(v.replaceAll(',', '.'));
                                if (value == null || value <= 0) return 'Niepoprawna wartość';
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          _decoratedField(
                            child: DropdownButtonFormField<String>(
                              value: selectedGrunt,
                              items: gruntOptions.map((g) => DropdownMenuItem(value: g, child: Text(g, style: const TextStyle(color: Colors.black)))).toList(),
                              onChanged: (v) => setState(() => selectedGrunt = v),
                              decoration: const InputDecoration(
                                labelText: "Typ gruntu",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _decoratedField(
                            child: DropdownButtonFormField<String>(
                              value: selectedHydro,
                              items: _hydroFilteredOptions().map((h) => DropdownMenuItem(value: h, child: Text(h, style: const TextStyle(color: Colors.black)))).toList(),
                              onChanged: (v) => setState(() => selectedHydro = v),
                              decoration: const InputDecoration(
                                labelText: "Typ hydroizolacji",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _decoratedField(
                            child: DropdownButtonFormField<String>(
                              value: selectedDodatek,
                              items: dodatekOptions.map((d) => DropdownMenuItem(value: d, child: Text(d, style: const TextStyle(color: Colors.black)))).toList(),
                              onChanged: (v) => setState(() => selectedDodatek = v),
                              decoration: const InputDecoration(
                                labelText: "Dodatki",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _decoratedField(
                            child: DropdownButtonFormField<String>(
                              value: selectedMata,
                              items: mataOptions.map((m) => DropdownMenuItem(value: m, child: Text(m, style: const TextStyle(color: Colors.black)))).toList(),
                              onChanged: (v) => setState(() => selectedMata = v),
                              decoration: const InputDecoration(
                                labelText: "Mata",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _decoratedField(
                            child: DropdownButtonFormField<String>(
                              value: selectedPlatki,
                              items: platkiOptions.map((p) => DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(color: Colors.black)))).toList(),
                              onChanged: (v) => setState(() => selectedPlatki = v),
                              decoration: const InputDecoration(
                                labelText: "Płatki dekoracyjne",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _decoratedField(
                            child: DropdownButtonFormField<String>(
                              value: selectedNaicoplast,
                              items: naicoplastOptions.map((n) => DropdownMenuItem(value: n, child: Text(n, style: const TextStyle(color: Colors.black)))).toList(),
                              onChanged: (v) => setState(() => selectedNaicoplast = v),
                              decoration: const InputDecoration(
                                labelText: "Naicoplast",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16),
                         _decoratedField(
                child: TextFormField(
                  controller: _rabatController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: "Rabat na materiały (max 25%)",
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black),
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    final value = double.tryParse(v.replaceAll(',', '.'));
                    // Ustal limit rabatu na podstawie wybranej osoby
                    double maxRabat = (selectedOsoba == "Iwona" || selectedOsoba == "Roman") ? 25.0 : 100.0;
                    if (value == null || value < 0 || value > maxRabat) return '0-${maxRabat.toInt()}%';
                    return null;
                  },
                ),
              ),
                          const SizedBox(height: 16),
                          
                          const SizedBox(height: 16),
                          _buildExecutionSection(),
                          const SizedBox(height: 16),

                          const Text(
                            "Dane Klienta",

                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.orange),
                          ),
                          const SizedBox(height: 12),
                          _decoratedField(
                            child: TextFormField(
                              controller: _clientNameController,
                              decoration: const InputDecoration(
                                labelText: "Imię i nazwisko klienta",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.black),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Wpisz imię i nazwisko';
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          _decoratedField(
                            child: TextFormField(
                              controller: _clientPhoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: "Telefon klienta",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.black),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Wpisz telefon';
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          _decoratedField(
                            child: TextFormField(
                              controller: _clientEmailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "Email klienta",
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.black),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Wpisz email';
                                if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(v)) return 'Niepoprawny email';
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.calculate, color: Colors.white),
                              label: const Text('Wyceń', style: TextStyle(color: Colors.white, fontSize: 20)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                elevation: 2,
                              ),
                              onPressed: _calculate,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ------- WYCENA i PDF (osobny kontener, widoczny tylko po wycenie) -------
                  if (_result != null)
                  Container(
                margin: const EdgeInsets.only(top: 36),
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 22,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
                  child: _buildResult(_result!),
                ),
              ),
              const SizedBox(height: 40,),
                ],
              ),
            ),
            
          ),
        ),
      ],
    ),
  );
}

Widget _decoratedField({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.07),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: child,
  );
}
}
