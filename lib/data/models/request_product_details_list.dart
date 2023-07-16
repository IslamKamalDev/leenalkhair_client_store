import 'package:leen_alkhier_store/data/responses/Units/uint_entity.dart';
import 'package:leen_alkhier_store/data/responses/contract_products_response.dart';

class ProductDetails {
  var product_id;
  var product_name;
  var product_image;
  var order_id;
  var quantity;
  List<UintEntity>? units;
  List<Units>? prod_units;
  ProductDetails({this.product_name, this.product_image,
    this.product_id, this.order_id, this.quantity, this.units,this.prod_units
  });


}
