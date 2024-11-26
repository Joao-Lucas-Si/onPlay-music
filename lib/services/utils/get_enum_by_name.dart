Enumerated getEnumByName<Enumerated extends Enum>(
        {required List<Enumerated> values, required String name}) =>
    values.firstWhere((value) => value.name == name);
