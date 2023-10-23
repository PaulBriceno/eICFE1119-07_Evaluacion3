import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_sumativo_3/providers/product_form_provider.dart';
import 'package:trabajo_sumativo_3/services/product_service.dart';
import 'package:trabajo_sumativo_3/ui/input_decorations.dart';
import 'package:trabajo_sumativo_3/widgets/product_image.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productService.SelectProduct!),
        child: _ProductScreenBody(
          productService: productService,
        ));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              ProductImage(
                url: productService.SelectProduct!.productImage,
              ),
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(//Boton para regresar
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(//Boton camara para cambiar imagen
                    onPressed: () => {},
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          _ProductForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
          FloatingActionButton(//Boton para eliminar
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              await productService.deleteProduct(productForm.product,context);
            },
            heroTag: null,
          ),
          const SizedBox(width: 30,),
          FloatingActionButton(//Boton para guardar los cambios del formulario
            child: const Icon(Icons.save_alt),
            onPressed: () async {if (!productForm.isValidForm()) return;
              await productService.editOrCreateProduct(productForm.product,context);
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [

              TextFormField(//Campo nombre producto
                initialValue: product.productName,
                onChanged: (value) => product.productName = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'el nombre es obligatorio';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre',
                ),
              ),

              const SizedBox(height: 20),//Espacio

              TextFormField(//Campo precio
                keyboardType: TextInputType.number,
                initialValue: product.productPrice.toString(),
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.productPrice = 0;
                  } else {
                    product.productPrice = int.parse(value);
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: '-----',
                  labelText: 'Precio',
                ),
              ),

              const SizedBox(height: 20),//Espacio

              SwitchListTile.adaptive(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.orange,
                title: const Text('Disponible'),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}