import 'package:onPlay/services/utils/get_enum_by_name.dart';

enum RelationshipStyle {
  name,
  circleImage,
  
  option,
  image;

  static RelationshipStyle fromString(String name) =>
      getEnumByName(values: values, name: name);
}
