import 'package:flutter_application_2/data/model/variant.dart';
import 'package:flutter_application_2/data/model/variant_type.dart';

class ProductVariant {
  VariantType varianttypes;
  List<Variants> variantslist;
  ProductVariant(
    this.varianttypes,
    this.variantslist,
  );
}
