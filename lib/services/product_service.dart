import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kstmis/models/products.dart';


fetchProduct(List<Products>listProduct) async {

  final endpoint = Uri.https('api.kstmis.me', '/public/api/products');
  final response = await http.get(endpoint);
  final jsonString = jsonDecode(response.body);
  if (response.statusCode == 200) {
      jsonString.forEach((v) {
        final product = Products.fromJson(v);
        listProduct.add(product);
    });
      return listProduct;
  } else {
    throw Exception("Failed to load data");
  }
}
