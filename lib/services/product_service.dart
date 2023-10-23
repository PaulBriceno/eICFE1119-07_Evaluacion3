import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trabajo_sumativo_3/models/productos.dart';

class ProductService extends ChangeNotifier{

  final String _baseUrl = '143.198.118.203:8000';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Listado> products = [];
  Listado? SelectProduct;
  bool isLoading = true;
  bool isEditCreate = true;

  ProductService() {
    loadProducts();
  }
  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_list_rest/',
    );

String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final productsMap = Product.fromJson(response.body);
    print(response.body);
    products = productsMap.listado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProduct(Listado product, BuildContext context) async {
    isEditCreate = true;
    notifyListeners();
    if (product.productId == 0) {
      await this.createProduct(product,context);
    } else {
      await this.updateProduct(product,context);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateProduct(Listado product, BuildContext context) async {// Servicio para modificar un producto
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_edit_rest/',
    );

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });

    final decodeResp = response.body;
   
    final index = products
        .indexWhere((element) => element.productId == product.productId);
    products[index] = product;

    Navigator.of(context).pushNamed('list');// Volvemos al listado
    return '';
  }

  Future<String> createProduct(Listado product, BuildContext context) async {// Servicio para crear un producto
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_edit_rest/',
    );

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });

    final decodeResp = response.body;

    this.products.add(product);
    
    //this.products.clear();//Borra el istado
    //loadProducts();
    Navigator.of(context).pushNamed('list');// Volvemos al listado
    return '';
  }

  Future<String> deleteProduct(Listado product, BuildContext context) async {// Servicio para eliminar un producto
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_edit_rest/',
    );

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });

    final decodeResp = response.body;

    this.products.clear();//Borra el istado
    loadProducts();
    Navigator.of(context).pushNamed('list');// Volvemos al listado
    return '';
  }

}