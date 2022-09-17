import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/components/components.dart';
import 'package:ecommerce/models/categoryModel.dart';
import 'package:ecommerce/shared/cubit/shopCubit.dart';
import 'package:ecommerce/shared/cubit/shopStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class categoryProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int? id;
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black,
                  )),
              title: Text(
                'Categories',
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'jannah',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            body: ConditionalBuilder(
              condition: ShopCubit.get(context).categorydatamodel != null,
              builder: (context) => CategoryProductBuilder(
                  ShopCubit.get(context).categorydatamodel!),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
