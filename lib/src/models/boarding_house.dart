import 'dart:convert';

import 'package:flutter/services.dart';

/// BoardingHouse model loaded from local JSON assets.
class BoardingHouse {
  final String id;
  final String name;
  final String address;
  final double pricePerNight;
  final List<String> amenities;
  final String contact;
  final String imageUrl;

  const BoardingHouse({
    required this.id,
    required this.name,
    required this.address,
    required this.pricePerNight,
    required this.amenities,
    required this.contact,
    required this.imageUrl,
  });

  factory BoardingHouse.fromJson(Map<String, dynamic> json) {
    return BoardingHouse(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      pricePerNight: (json['pricePerNight'] as num?)?.toDouble() ?? 0,
      amenities: (json['amenities'] as List<dynamic>? ?? const [])
          .map((item) => item.toString())
          .toList(),
      contact: json['contact'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  static Future<List<BoardingHouse>> loadFromAsset({
    String assetPath = 'assets/data/products.json',
  }) async {
    final jsonString = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
    final rawItems = decoded['boarding_houses'];

    if (rawItems is! List) {
      throw const FormatException('Missing "boarding_houses" array in JSON');
    }

    return rawItems
        .map((item) => BoardingHouse.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
