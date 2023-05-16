class VariantType {
  String? id;
  String? name;
  String? title;
  VariantTypeEnum? type;
  VariantType(this.id, this.name, this.title, this.type);

  factory VariantType.frommapjson(Map<String, dynamic> jsonobject) {
    return VariantType(
      jsonobject['id'],
      jsonobject['name'],
      jsonobject['title'],
      _gettypeenum(
        jsonobject['type'],
      ),
    );
  }
}

VariantTypeEnum _gettypeenum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.color;
    case 'Storage':
      return VariantTypeEnum.storage;
    case 'Voltage':
      return VariantTypeEnum.voltage;
    default:
      return VariantTypeEnum.color;
  }
}

enum VariantTypeEnum {
  color,
  storage,
  voltage,
}
