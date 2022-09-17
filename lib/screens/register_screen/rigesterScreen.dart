import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/components/components.dart';
import 'package:ecommerce/components/controllers.dart';
import 'package:ecommerce/screens/login_screen/loginScreen.dart';
import 'package:ecommerce/shared/cubit/shopCubit.dart';
import 'package:ecommerce/shared/cubit/shopStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class registerScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.model.status!) {
            showToast(state.model.message,
                context: context,
                position: StyledToastPosition.bottom,
                animation: StyledToastAnimation.slideFromBottom,
                textStyle:
                    TextStyle(color: Colors.white, fontFamily: 'jannah'));
            navigateTo(context, loginScreen());
          } else {
            showToast(state.model.message,
                context: context,
                position: StyledToastPosition.bottom,
                animation: StyledToastAnimation.slideFromBottom,
                textStyle:
                    TextStyle(color: Colors.white, fontFamily: 'jannah'));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_outlined)),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'jannah'),
                        ),
                        Text(
                          'Sign up now to join us',
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
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name mustn't be empty";
                              }
                            },
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'jannah'),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                    color: Colors.blueGrey,
                                    fontFamily: 'jannah'),
                                prefixIcon: Icon(
                                  Icons.person_outlined,
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
                            controller: emailRegisterController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "email mustn't be empty";
                              }
                            },
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
                            controller: passwordRegisterController,
                            onFieldSubmitted: (value) {},
                            obscureText: ShopCubit.get(context).isVis,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is too short";
                              }
                            },
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
                          height: 15,
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            controller: phoneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "phone mustn't be empty";
                              }
                            },
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'jannah'),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'phone',
                                labelStyle: TextStyle(
                                    color: Colors.blueGrey,
                                    fontFamily: 'jannah'),
                                prefixIcon: Icon(
                                  Icons.phone,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingState,
                              builder: (context) => Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blue),
                                    child: TextButton(
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            ShopCubit.get(context).userRegister(
                                                name: nameController.text,
                                                email: emailRegisterController
                                                    .text,
                                                password:
                                                    passwordRegisterController
                                                        .text,
                                                phone: phoneController.text
                                                );
                                          }
                                        },
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontFamily: 'jannah',
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator())),
                        ),
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
