class Categories {
  String? collectionId;
  String? color;
  String? icon;
  String? id;
  String? thumbnail;
  String? title;
  Categories(
    this.collectionId,
    this.color,
    this.icon,
    this.id,
    this.thumbnail,
    this.title,
  );

  factory Categories.fromMapJson(Map<String, dynamic> jsonobject) {
    return Categories(
      jsonobject['collectionId'],
      jsonobject['color'],
      'http://startflutter.ir/api/files/${jsonobject['collectionId']}/${jsonobject['id']}/${jsonobject['icon']}',
      jsonobject['id'],
      'http://startflutter.ir/api/files/${jsonobject['collectionId']}/${jsonobject['id']}/${jsonobject['thumbnail']}',
      jsonobject['title'],
    );
  }
}
