class Property {
  String? title;
  String? value;
  Property(this.title, this.value);

  factory Property.frommapobject(Map<String, dynamic> jsonobject) {
    return Property(
      jsonobject['title'],
      jsonobject['value'],
    );
  }
}
