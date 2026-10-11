import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

// assets/products.json dosyasını okuyup Product listesine çevirir
Future<List<Product>> loadProducts() async {
  final text = await rootBundle.loadString('assets/products.json');
  final map = json.decode(text) as Map<String, dynamic>;
  final list = map['data'] as List<dynamic>;

  return list
      .map((item) => Product.fromJson(item as Map<String, dynamic>))
      .toList();
}