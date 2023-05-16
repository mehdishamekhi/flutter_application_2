class BannersList {
  String? categoryId;
  String? collectionId;
  String? id;
  String? thumbnail;
  BannersList(this.categoryId, this.collectionId, this.id, this.thumbnail);

  factory BannersList.frommapjson(Map<String, dynamic> jsonobject) {
    return BannersList(
      jsonobject['categoryId'],
      jsonobject['collectionId'],
      jsonobject['id'],
      'http://startflutter.ir/api/files/${jsonobject['collectionId']}/${jsonobject['id']}/${jsonobject['thumbnail']}',
    );
  }
}
