abstract class CategoryProductEvent {}

class CategoryProductInitializeEvent extends CategoryProductEvent {
  String categoryid;
  CategoryProductInitializeEvent(this.categoryid);
}
