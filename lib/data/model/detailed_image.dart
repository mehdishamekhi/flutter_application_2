class DetailedImage {
  String? image;
  String? productid;
  DetailedImage(this.image, this.productid);
  factory DetailedImage.frommapjson(Map<String, dynamic> jsonobject) {
    return DetailedImage(
      'http://startflutter.ir/api/files/${jsonobject['collectionId']}/${jsonobject['id']}/${jsonobject['image']}',
      jsonobject['product_id'],
    );
  }
}
