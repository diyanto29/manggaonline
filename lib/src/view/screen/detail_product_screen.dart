import 'dart:math';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_app/main.dart';
import 'package:fashion_app/src/const/app_colors.dart';
import 'package:fashion_app/src/const/app_font.dart';
import 'package:fashion_app/src/const/endpoint.dart';
import 'package:fashion_app/src/data/model/inventory.dart';
import 'package:fashion_app/src/data/model/product.dart';
import 'package:fashion_app/src/data/model/produk_model/datum.dart';
import 'package:fashion_app/src/router/router_path.dart';
import 'package:fashion_app/src/viewmodel/auth_viemodel.dart';
import 'package:fashion_app/src/viewmodel/cart_viewmodel.dart';
import 'package:fashion_app/src/viewmodel/choice_chip.dart';
import 'package:fashion_app/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DetailProductScreen extends StatefulWidget {
  final DataProduk? product;

  const DetailProductScreen({Key? key, this.product}) : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  List<String> listImage = [
    'https://www.girlteencare.com/wp-content/uploads/2021/04/dd51d83736d0741a3a78ad68e8077805.jpg',
    'https://www.efasheen.com/wp-content/uploads/2020/12/Pantone-Colors.png',
    'https://thevou.com/wp-content/uploads/2021/05/Current-fashion-trends-wtvox.com-Boiler-suits-01.jpg',
  ];
  Inventory? inventory = Inventory();

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: true);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.product!.name!,
          style: AppFont.semiBold,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(
        //       Icons.favorite_border,
        //       color: Colors.black,
        //       size: 22,
        //     ),
        //   ),
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       icon: Badge(
        //         badgeColor: AppColors.primaryColorRed,
        //         badgeContent: Text(
        //           cartViewModel.productCount.toString(),
        //           style: AppFont.regular
        //               .copyWith(fontSize: 12, color: Colors.white),
        //         ),
        //         position: BadgePosition.topEnd(top: -8, end: -5),
        //         child: Icon(
        //           Icons.shopping_cart_outlined,
        //           color: Colors.black,
        //         ),
        //       )),
        // ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                EndPoint.photoUrl + widget.product!.image!,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product!.name!,
                            style: AppFont.bold.copyWith(fontSize: 18),
                          ),
                        ),
                        Text(
                          "Rp ${formatCurrency.format(widget.product!.price)}",
                          style: AppFont.bold.copyWith(fontSize: 18),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Stok : " + widget.product!.stok.toString(),
                      style: AppFont.regular.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Berat : " + widget.product!.weigth.toString() + " gram",
                      style: AppFont.regular.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Row(
                    //   children: [
                    //     RatingBar.builder(
                    //       initialRating: 5,
                    //       direction: Axis.horizontal,
                    //       itemSize: 15,
                    //       itemCount: 5,
                    //       ignoreGestures: true,
                    //       itemBuilder: (context, _) => Icon(
                    //         Icons.star,
                    //         color: Colors.amber,
                    //       ),
                    //       onRatingUpdate: (rating) {
                    //         print(rating);
                    //       },
                    //     ),
                    //     SizedBox(
                    //       width: 5,
                    //     ),
                    //     Text('(10)')
                    //   ],
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.product?.description ?? '',
                      style: AppFont.regular.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          height: 1.4,
                          letterSpacing: .2,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    // Text(
                    //   "Rating & Review",
                    //   style: AppFont.bold.copyWith(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 23,
                    //       color: Colors.black),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (BuildContext ctx) {
          return Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(2, -2),
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColorRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                onPressed: () {
                  Provider.of<ProductViewModel>(ctx, listen: false)
                      .addKeranjang(widget.product!.id.toString());
                },
                child: Text(
                  "Add to cart".toUpperCase(),
                  style: AppFont.medium
                      .copyWith(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  showChooseSize(BuildContext ctx, Product? product) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        ProductViewModel productViewModel = ProductViewModel(); // cre
        ProductViewModel productViewModel2 =
            ProductViewModel(); // cre// ate instance provider
        String select = '';
        Inventory? a;
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xffF9F9F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Text(
                        "Size",
                        style: AppFont.semiBold.copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, bottom: 15),
                                child: ChangeNotifierProvider.value(
                                  value: productViewModel,
                                  child: Consumer<ProductViewModel>(
                                    builder: (BuildContext context, productVM,
                                        Widget? child) {
                                      return ChoiceOption(
                                        listSize: product!.inventory!
                                            .map((e) => e.size!)
                                            .toSet()
                                            .toList(),
                                        onSelectCallBack: (value) {
                                          var size = product.inventory!
                                              .firstWhere((element) =>
                                                  element.size == value);
                                          if (size != null) {
                                            inventory?.size = size.size;
                                            // print(inventory?.size);
                                          }
                                          var a = product.inventory?.firstWhere(
                                              (element) =>
                                                  element.color ==
                                                      inventory?.color &&
                                                  element.size ==
                                                      inventory?.size,
                                              orElse: () => Inventory());
                                          if (a?.id != null) {
                                            print('ok');
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Mặc hàng này không có size");
                                          }
                                        },
                                      );
                                    },
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Colors",
                        style: AppFont.semiBold.copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, bottom: 15),
                                child: ChangeNotifierProvider.value(
                                  value: productViewModel,
                                  child: Consumer<ProductViewModel>(
                                    builder: (BuildContext context, productVM,
                                        Widget? child) {
                                      return ChoiceOption(
                                        listSize: product!.inventory!
                                            .map((e) => e.color!)
                                            .toSet()
                                            .toList(),
                                        onSelectCallBack: (value) {
                                          var size = product.inventory!
                                              .firstWhere((element) =>
                                                  element.color == value);
                                          if (size != null) {
                                            inventory?.color = size.color;
                                            // print(inventory?.color);
                                          }
                                          a = product.inventory?.firstWhere(
                                              (element) =>
                                                  element.color ==
                                                      inventory?.color &&
                                                  element.size ==
                                                      inventory?.size);
                                          print(a?.id);
                                          if (a != null) {
                                            print(a?.stockQuantity);
                                          } else {
                                            print('f');
                                          }
                                        },
                                      );
                                    },
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColorRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        onPressed: () {
                          // String? size = product.inventory![productViewModel.selectIndex].size;
                          // String? color = product.inventory![productViewModel.selectIndex].color;
                          Provider.of<ProductViewModel>(ctx, listen: false)
                              .addKeranjang(product!.id!);
                        },
                        child: Text(
                          "Add to cart".toUpperCase(),
                          style: AppFont.medium
                              .copyWith(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildText(List<String> list) {
    return Wrap(
      children: list.map((e) => Text(e)).toList(),
    );
  }
}
