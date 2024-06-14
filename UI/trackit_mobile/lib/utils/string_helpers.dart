import 'dart:convert';

import 'package:flutter/cupertino.dart';

class StringHelpers {
  static String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  static Image imageFromBase64String(String base64Image) =>
      Image.memory(base64Decode(base64Image));

  static colorFromHex(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length <= 7) buffer.write('ff');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static int intFromColor(String hexColor) {
    if (hexColor == "") return 0;
    String variant = "0xFF${hexColor.substring(1)}";
    return int.tryParse(variant) ?? 0;
  }
}
