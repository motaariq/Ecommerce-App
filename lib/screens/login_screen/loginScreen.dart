import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/components/components.dart';
import 'package:ecommerce/components/conistants.dart';
import 'package:ecommerce/components/controllers.dart';
import 'package:ecommerce/layout/homeLayout.dart';
import 'package:ecommerce/screens/register_screen/rigesterScreen.dart';
import 'package:ecommerce/shared/Cache/cacheHelper.dart';
import 'package:ecommerce/shared/cubit/shopCubit.dart';
import 'package:ecommerce/shared/cubit/shopStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// ignore: must_be_immutable
class loginScreen extends StatelessWidget {
  var formkeyy = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessState) {
          if (state.model.status!) {
            print(state.model.data!.token);
            showToast(state.model.message,
                context: context,
                animation: StyledToastAnimation.slideFromBottom,
                position: StyledToastPosition.bottom,
                textStyle:
                    TextStyle(fontFamily: 'jannah', color: Colors.white));
            cacheHelper
                .saveData(key: 'token', value: state.model.data!.token)
                .then((value) {
              token = state.model.data!.token;
              if (value == true) {
                emailController.text = '';
                passwordController.text = '';
                ShopCubit.get(context).currentIndex = 0;
                navigatePush(context, homeLayout());
              }
            });
          } else {
            showToast(state.model.message,
                context: context,
                animation: StyledToastAnimation.slideFromBottom,
                position: StyledToastPosition.bottom,
                textStyle:
                    TextStyle(fontFamily: 'jannah', color: Colors.white));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formkeyy,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'jannah'),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'jannah'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "email mustn't be empty";
                              }
                            },
                            controller: emailController,
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'jannah'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Colors.blueGrey,
                                    fontFamily: 'jannah'),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.blueGrey,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              ShopCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            },
                            obscureText: ShopCubit.get(context).isVis,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is too short";
                              }
                            },
                            controller: passwordController,
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'jannah'),
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.blueGrey),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    return ShopCubit.get(context).changeVis();
                                  },
                                  icon: ShopCubit.get(context).visiable,
                                  color: Colors.blueGrey,
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.blueGrey,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopLoadingState,
                            builder: (context) => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.blue),
                                  child: TextButton(
                                      onPressed: () {
                                        if (formkeyy.currentState!.validate()) {
                                          ShopCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'jannah',
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don't have an account ?",
                              style:
                                  TextStyle(fontSize: 15, fontFamily: 'jannah'),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, registerScreen());
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(fontFamily: 'jannah'),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
