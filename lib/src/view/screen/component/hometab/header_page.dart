import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HeaderPage extends StatelessWidget {
  List<String> listImage = [
    'https://cdn3.vectorstock.com/i/1000x1000/81/02/fresh-mango-juice-splash-banner-with-apteitic-vector-24518102.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0Yaa91-8Brc9J-shEYZrfo7cGYLg9ehoqeCBteN5MoRzlrD-J-he7Imedlwqvk-8VxEY&usqp=CAU',
    'https://png.pngtree.com/background/20210710/original/pngtree-mango-fruit-background-picture-picture-image_1035517.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        autoPlay: true,
        enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: listImage
          .map((e) => Image.network(
                e,
                fit: BoxFit.cover,
              ))
          .toList(),
    );
  }
}
