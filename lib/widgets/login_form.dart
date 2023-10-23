import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_sumativo_3/providers/login_form_provider.dart';
import 'package:trabajo_sumativo_3/services/auth_service.dart';
import '../ui/input_decorations.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({ super.key });

   @override
   Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: LoginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(children: [
          //Campo usuario
          TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Ingrese usuario',
                labelText: 'Usuario',
                prefixIcon: Icons.people,),
                onChanged: (value) => LoginForm.email = value,
                validator: (value) {
                  return (value != null && value.length >= 4)
                      ? null
                      : 'El usuario no puede estar vacio';
                },
            ),

          const SizedBox(height: 30,), //Espacio
          //Campo contraseña
          TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: '**********',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,),
                onChanged: (value) => LoginForm.password = value,
                validator: (value) {
                return (value != null && value.length >= 4)
                    ? null
                    : 'La contraseña no puede estar vacio';
              },
            ),
          const SizedBox(height: 30,), //Espacio
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),            
            ),
            disabledColor: Colors.grey,
            color: Colors.orange,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 10),
              child: Text('Ingresar',style:  const TextStyle(color: Colors.white),),
              ),
              elevation: 0,         
              onPressed: LoginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);
                        if (!LoginForm.isValidForm()) return;
                        LoginForm.isLoading = true;
                        final String? errorMessage = await authService.login(
                            LoginForm.email, LoginForm.password);
                        if (errorMessage == null) {
                          Navigator.pushNamed(context, 'list');
                        } else {
                          print(errorMessage);
                        }
                        LoginForm.isLoading = false;
                      },
          )
        ],),
        ),);
  }
}