import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_sumativo_3/providers/login_form_provider.dart';
import 'package:trabajo_sumativo_3/widgets/login_form.dart';
import 'package:trabajo_sumativo_3/widgets/widgets.dart';
//import 'package:trabajo_sumativo_3/ui/input_decorations.dart';


class LoginScreen extends StatelessWidget {

  const LoginScreen({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
        body: AuthBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 150,),//Separador
                CardContainer(
                  child: Column(
                    children:[
                      const SizedBox(height: 10),//Separador
                      Text('Login',style: Theme.of(context).textTheme.headline5,),//Titulo del formulario
                      const SizedBox(height: 20),//Separador
                      
                      ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: LoginForm(),// Llamamos al formulario  
                      ),

                      const SizedBox(height: 50),//Separador

                      TextButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, 'add_user'),
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Colors.indigo.withOpacity(0.1)),
                            shape: MaterialStateProperty.all(StadiumBorder())),
                        child: const Text('Crea tu cuenta'),
                      )

                    ]
                  )
                )
              ],             
            ),
          ),
        ),
      );
    }
}

/* 

class LoginForm extends StatelessWidget {

  const LoginForm({ super.key });

   @override
   Widget build(BuildContext context) {
       return Container(child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          //Campo usuario
          TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Ingrese usuario',
                labelText: 'Usuario',
                prefixIcon: Icons.people,
                ),
              validator: (value){
                return (value!= null && value.length >=4)? null: 'El usuario esta vacio';
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
                prefixIcon: Icons.lock_outline,
                ),
              validator: (value){
                return (value!= null && value.length >=4)? null: 'Contraseña esta vacia';
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
              onPressed: () async{
                Navigator.pushNamed(context,'list');
              },
          )
        ],),
        ),);
  }
} */