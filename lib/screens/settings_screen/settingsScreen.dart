import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/components/components.dart';
import 'package:ecommerce/shared/cubit/shopCubit.dart';
import 'package:ecommerce/shared/cubit/shopStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../../components/controllers.dart';


class settingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getProfile(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopProfileSuccessState) {
            nameProfileController.text = state.model.data!.name!;
            emailProfileController.text = state.model.data!.email!;
            phoneProfileController.text = state.model.data!.phone!;
          }
          if (state is ShopUpdateSuccessState) {
            showToast(
                state.model.message,
                context: context,
                position: StyledToastPosition.bottom,
                animation: StyledToastAnimation.slideFromBottom,
                textStyle:TextStyle(color: Colors.white, fontFamily: 'jannah')
              );
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'jannah',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              body: ConditionalBuilder(
                condition: ShopCubit.get(context).model != null,
                builder: (context) => settingsBuilder(
                    context, ShopCubit.get(context).model!, state),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ));
        },
      ),
    );
  }
}
