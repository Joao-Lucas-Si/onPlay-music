import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

class Uint8listConverter extends JsonConverter<Uint8List, List<int>> {
  const Uint8listConverter();
  @override
  Uint8List fromJson(List<int> json) {
    return Uint8List.fromList(json);
  }

  @override
  List<int> toJson(Uint8List object) {
    return object.toList();
  }
}
