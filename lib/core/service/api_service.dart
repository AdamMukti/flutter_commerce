// import 'dart:convert';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_commerce/core/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ProductModel>?> getUsers() async {
    try {
      var url = Uri.parse('https://dummyjson.com/products');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ProductModel> _model = productModelFromJson(
            json.encode(json.decode(response.body)['products']));
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
