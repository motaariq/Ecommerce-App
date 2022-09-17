import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/components/components.dart';
import 'package:ecommerce/shared/cubit/shopCubit.dart';
import 'package:ecommerce/shared/cubit/shopStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class categoriesScreen extends StatelessWidget {
  const categoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
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
                condition: ShopCubit.get(context).categorymodel != null,
                builder: (context) => CategoryPageBuilder(ShopCubit.get(context).categorymodel!,),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())));
      },
    );
  }
}
