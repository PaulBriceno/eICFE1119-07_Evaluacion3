import 'package:flutter/material.dart';
import 'package:trabajo_sumativo_3/models/productos.dart';
import 'package:trabajo_sumativo_3/screen/loading_screen.dart';

import 'package:trabajo_sumativo_3/services/product_service.dart';

import 'package:provider/provider.dart';
import 'package:trabajo_sumativo_3/widgets/product_card.dart';


class ListProductoScreen extends StatelessWidget {

  const ListProductoScreen({ super.key });
  
   @override
   Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return const LoadingScreen();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado productos'),
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            productService.SelectProduct =
                productService.products[index].copy();
            Navigator.pushNamed(context, 'edit');
          },
          child: ProductCard(product: productService.products[index]),
        ),
      ),floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          productService.SelectProduct = Listado(
            productId: 0,
            productName: '',
            productPrice: 0,
            productImage: 'https://www.sogarca.com/wp-content/uploads/2015/06/No-disponible.jpg',
            productState: ''
           );
           Navigator.pushNamed(context, 'edit');
        },
      ),


    );
  }
}
