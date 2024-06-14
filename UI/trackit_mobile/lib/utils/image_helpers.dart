import 'dart:convert';

import 'package:flutter/material.dart';

class ImageHelpers {
  static Widget getImage(String? image,
      {double height = 40, double width = 40}) {
    return image?.isNotEmpty ?? true
        ? Image.memory(
            base64Decode(image!),
            height: height,
            width: width,
          )
        : Image.asset("assets/images/NoImageFound.jpg",
            height: height, width: height);
  }
}
