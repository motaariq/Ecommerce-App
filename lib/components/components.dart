import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/components/conistants.dart';
import 'package:ecommerce/components/controllers.dart';
import 'package:ecommerce/models/categoryModel.dart';
import 'package:ecommerce/models/categorydataModel.dart';
import 'package:ecommerce/models/favoritesModel.dart';
import 'package:ecommerce/models/homeModel.dart';
import 'package:ecommerce/models/userModel.dart';
import 'package:ecommerce/screens/categories_screen/categoryproductScreen.dart';
import 'package:ecommerce/screens/onBoarding_screen/onBoarding_screen.dart';
import 'package:ecommerce/screens/register_screen/rigesterScreen.dart';
import 'package:ecommerce/shared/cubit/shopCubit.dart';
import 'package:ecommerce/shared/cubit/shopStates.dart';
import 'package:flutter/material.dart';

//navigate and replace
navigatePush(context, state) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => state,
      ));
}

//just navigate
navigateTo(context, state) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => state,
      ));
}

//print full text
void printFullString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => print(match.group(0)));
}

//onboarding design
Widget onBoardingItem(boardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            model.image,
            height: 300,
            width: 320,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          model.title,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'jannah'),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Text(model.body,
              style: TextStyle(fontSize: 15, fontFamily: 'jannah')),
        )
      ],
    );

//products design
Widget productsBuilder(homeModel model, categoryModel catmodel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data!.banners!
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 250,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  scrollDirection: Axis.horizontal)),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Categories',
              style: TextStyle(
                  fontFamily: 'jannah',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 90,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              itemBuilder: (context, index) =>
                  CategoryHomeItem(catmodel.data!.data[index], context),
              itemCount: 5,
              separatorBuilder: (context, index) => SizedBox(
                width: 3,
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 1.1,
              mainAxisSpacing: 1,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.73,
              children: List.generate(
                  model.data!.products!.length,
                  (index) => productGridItem(
                        model.data!.products![index],
                        context,
                      )),
            ),
          )
        ],
      ),
    );
Widget productGridItem(Products model, context) => Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red[500],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      'Discount',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'jannah',
                          fontSize: 10),
                    ),
                  ),
                )
            ]),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        height: 1.4,
                        fontFamily: 'jannah'),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            height: 1.4,
                            fontFamily: 'jannah'),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice!.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              height: 1.4,
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'jannah'),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id!);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id]!
                                    ? Colors.blue
                                    : Colors.grey,
                            child: Icon(
                              Icons.favorite_outline,
                              size: 14,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

//category design
Widget CategoryPageBuilder(categoryModel model) => Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) =>
                CategoryPageItem(model.data!.data[index], context),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey[500],
            ),
            itemCount: model.data!.data.length,
          ),
        )
      ],
    );
Widget CategoryPageItem(DataCategoryModel model, context) => Container(
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image!),
            height: 100,
            width: 100,
          ),
          SizedBox(
            width: 7,
          ),
          Text(
            model.name!,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'jannah',
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              ShopCubit.get(context).getCategoryProducts('');
              navigateTo(context, categoryProductScreen());
              print(model.id);
            },
            child: Text(
              '>',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'jannah',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
Widget CategoryHomeItem(DataCategoryModel model, context) => InkWell(
      onTap: () {
        ShopCubit.get(context).getCategoryProducts(model.id!);
        navigateTo(context, categoryProductScreen());
        print(model.id);
      },
      child: Container(
        width: 100,
        height: 100,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            child: Image(
              image: NetworkImage(model.image!),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100,
            child: Text(
              model.name!,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'jannah',
                fontSize: 16,
              ),
            ),
          )
        ]),
      ),
    );
Widget CategoryProductBuilder(categorydataModel model) => Column(
      children: [
        Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                CategoryProductItem(model.data!.data![index]),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey[500],
            ),
            itemCount: model.data!.data!.length,
          ),
        )
      ],
    );
Widget CategoryProductItem(categorydataModelData model) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 100.0,
        child: Row(
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              Image(
                image: NetworkImage(model.image!),
                width: 120.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red[500],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      'Discount',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'jannah',
                          fontSize: 10),
                    ),
                  ),
                )
            ]),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        height: 1.4,
                        fontFamily: 'jannah'),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            height: 1.4,
                            fontFamily: 'jannah'),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              height: 1.4,
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'jannah'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

//favorites design
Widget favoritesBuilder(favoritesModel model, context) => Column(
      children: [
        Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                favoritesItem(model.data!.data![index], context),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey[500],
            ),
            itemCount: model.data!.data!.length,
          ),
        ),
      ],
    );
Widget favoritesItem(favoritesitemData model, context) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              Image(
                image: NetworkImage(model.product!.image!),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              if (model.product!.discount != 0)
                Container(
                  color: Colors.red[500],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      'Discount',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'jannah',
                          fontSize: 10),
                    ),
                  ),
                )
            ]),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.product!.name!}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        height: 1.4,
                        fontFamily: 'jannah'),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price!.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            height: 1.4,
                            fontFamily: 'jannah'),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          model.product!.oldPrice!.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              height: 1.4,
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'jannah'),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product!.id!);
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            size: 18,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

//profile design
Widget settingsBuilder(context, userModel model, state) => Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                height: 60,
                child: TextFormField(
                  controller: nameProfileController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name mustn't be empty";
                    }
                  },
                  style: TextStyle(color: Colors.black, fontFamily: 'jannah'),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: model.data?.name.toString(),
                      labelStyle: TextStyle(
                          color: Colors.blueGrey, fontFamily: 'jannah'),
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
                        borderSide: BorderSide(color: Colors.blueGrey),
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 60,
                child: TextFormField(
                  controller: emailProfileController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "email mustn't be empty";
                    }
                  },
                  style: TextStyle(color: Colors.black, fontFamily: 'jannah'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: model.data?.email.toString(),
                      labelStyle: TextStyle(
                          color: Colors.blueGrey, fontFamily: 'jannah'),
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
                        borderSide: BorderSide(color: Colors.blueGrey),
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 60,
                child: TextFormField(
                  controller: phoneProfileController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "phone mustn't be empty";
                    }
                  },
                  style: TextStyle(color: Colors.black, fontFamily: 'jannah'),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: model.data?.phone.toString(),
                      labelStyle: TextStyle(
                          color: Colors.blueGrey, fontFamily: 'jannah'),
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
                        borderSide: BorderSide(color: Colors.blueGrey),
                      )),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ConditionalBuilder(
                  condition: state is! ShopUpdateLoadingState,
                  builder: (context) => Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: TextButton(
                            onPressed: () {
                              return ShopCubit.get(context).userUpdate(
                                name: nameProfileController.text,
                                email: emailProfileController.text,
                                phone: phoneProfileController.text,
                              );
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'jannah',
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                  fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      )),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: TextButton(
                    onPressed: () {
                      return ShopCubit.get(context).signOut(context);
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'jannah',
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
