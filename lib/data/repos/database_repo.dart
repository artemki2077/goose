import 'package:goose/data/models/product.dart';
import 'package:hive/hive.dart';

class DataBaseRepo {
  final box = Hive.box('db');

  List<Product> getAll() {
    return box.values.map((json) {
      return Product.fromJson(json);
    }).toList();
  }

  Future<void> add(Product product) async {
    print("add");
    await box.add(product.toJson());
    print(box.length);
  }

  Future<void> delete(Product product)async{
    int indexOfProduct = box.values.map((e) => Product.fromJson(e)).toList().indexWhere((Product e) => (e.originalLink == product.originalLink));
    await box.deleteAt(indexOfProduct);
  }
}
