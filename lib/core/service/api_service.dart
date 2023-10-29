// import 'dart:convert';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_commerce/core/model/categories_model.dart';
import 'package:flutter_commerce/core/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ProductModel>?> getProducts() async {
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

  Future<List<ProductModel>?> searchProducts(String query) async {
    try {
      var url = Uri.parse('https://dummyjson.com/products/search?q=${query}');
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

  Future<List<String>?> getCategories() async {
    try {
      var url = Uri.parse('https://dummyjson.com/products/categories');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<String> _model = categoriesModelFromJson(response.body);
        print(_model);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
