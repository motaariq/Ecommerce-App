import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/components/components.dart';
import 'package:ecommerce/shared/cubit/shopCubit.dart';
import 'package:ecommerce/shared/cubit/shopStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHome()..getCategory(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopChangeFavoritesSuccessState) {
            showToast(state.model.message,
                context: context,
                backgroundColor: Colors.blue,
                animation: StyledToastAnimation.slideFromBottom,
                position: StyledToastPosition.bottom,
                textStyle:TextStyle(fontFamily: 'jannah', color: Colors.white));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Salla',
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'jannah',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            body: ConditionalBuilder(
                condition: ShopCubit.get(context).homemodel != null && ShopCubit.get(context).categorymodel != null,
                builder: (context) => productsBuilder(
                      ShopCubit.get(context).homemodel!,
                      ShopCubit.get(context).categorymodel!,
                      context,
                    ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())),
          );
        },
      ),
    );
  }
}
