import 'package:batubara/source/service/Auth/cubit/auth_cubit.dart';
import 'package:batubara/source/widget/color.dart';
import 'package:batubara/source/widget/customButton.dart';
import 'package:batubara/source/widget/customDialog.dart';
import 'package:batubara/source/widget/customForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  void login() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).login(context, controllerUsername.text, controllerPassword.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              EasyLoading.show();
            }
            if (state is LoginLoaded) {
              EasyLoading.dismiss();
              var json = state.json;
              var statusCode = state.statusCode;
              if (statusCode == 200) {
                if (json['status'] == 500) {
                  MyDialog.dialogAlert(context, json['message']);
                } else {
                  MyDialog.dialogSuccess(context, json['message'], SizedBox.shrink());
                }
              } else if (statusCode == 422) {
                MyDialog.dialogAlert(context, "${json['message']} \n ${json['errors']['barcode'][0]} \n ${json['errors']['password'][0]}");
              } else {
                MyDialog.dialogAlert(context, json['message']);
              }
            }
          },
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset("assets/boiler1.jpg"),
                const SizedBox(height: 10),
                const Center(child: Text("Perhitungan Batubara", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CustomFormField(
                            controller: controllerUsername,
                            hint: 'Masukan Username',
                            label: 'Username',
                            obscureText: false,
                            color: border,
                            prefixIcon: Icon(Icons.account_box_rounded),
                            messageError: 'Kolom tidak boleh kosong',
                          ),
                          const SizedBox(height: 14),
                          CustomFormField(
                            controller: controllerPassword,
                            hint: 'Masukan Password',
                            label: 'Password',
                            obscureText: obscureText,
                            color: border,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                            messageError: 'Kolom tidak boleh kosong',
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            text: 'LOGIN',
                            color: merah,
                            textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                            splashColor: Colors.red[600],
                            onTap: login,
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
