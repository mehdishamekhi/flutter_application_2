class Variants {
  String? id;
  String? name;
  int? pricechange;

  String? typeid;
  String? value;
  Variants(this.id, this.name, this.pricechange, this.typeid, this.value);

  factory Variants.fromMapjson(Map<String, dynamic> jsonject) {
    return Variants(
      jsonject['id'],
      jsonject['name'],
      jsonject['price_change'],
      jsonject['type_id'],
      jsonject['value'],
    );
  }
}
