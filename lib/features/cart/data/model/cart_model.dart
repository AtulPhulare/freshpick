import 'package:flutter/material.dart';

class CartModel {
  final String name;
  final String imageUrl;
  final String unit;
  final Color pastel;
  double price;
  int qty;

  CartModel({
    required this.name,
    required this.imageUrl,
    required this.unit,
    required this.pastel,
    required this.price,
    required this.qty,
  });
}
