import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Network/local/Chache_Helper.dart';
import '../../component/component.dart';
import '../../const.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../home/Home_Layout.dart';
import '../shop_register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              Cache_Helper.saveDataToSharedPref(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                NavigateAndRep(context, Home_Layout());
                showToast(msg: "${state.loginModel.message}");
              });
              // print("your Message Is ${state.loginModel.message}");
              // print("your Token Is ${state.loginModel.data!.token}");
            } else {
              showToast(msg: "${state.loginModel.message}");
              // print("your Message Is ${state.loginModel.message}");
            }
          }
        },
        builder: (context, state) {
          var cubobj = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image(
                          height: 200,
                          image: AssetImage("lib/assets/images/login1.png"),
                        ),
                      ),
                      const Text("LOGIN", style: TextStyle(fontSize: 40)),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultForm(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        text: "Email-Address",
                        onchange: (value) {},
                        onsubmit: (value) {},
                        Validator: (value) {
                          if (value.isEmpty) {
                            return "Email-Address Must Not Be Empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultForm(
                          isSecure: cubobj.isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock,
                          suffixIcon: cubobj.Suffix,
                          text: "Password",
                          onchange: (value) {},
                          onsubmit: (value) {},
                          Validator: (value) {
                            if (value.isEmpty) {
                              return "Password Must Not Be Empty";
                            } else {
                              return null;
                            }
                          },
                          onTap: () {
                            cubobj.showpassword();
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultButton(
                        onpress: () {
                          if (formKey.currentState!.validate()) {
                            cubobj.userModel(
                                email: emailController.text,
                                password: passwordController.text);
                            // NavigateTo(context, shop_home());
                          }
                        },
                        text: "Login",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't Have An Account ?"),
                          defaultTextButton(
                              onpress: () {
                                NavigateTo(context, shop_register());
                              },
                              text: "REGISTER "),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
