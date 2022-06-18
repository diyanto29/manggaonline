import 'package:fashion_app/src/data/service/product_service.dart';
import 'package:fashion_app/src/view/screen/component/hometab/body_page.dart';
import 'package:fashion_app/src/view/screen/component/hometab/header_page.dart';
import 'package:fashion_app/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: 45,
          child: TextField(
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Cari Produk Disini...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderPage(),
              SizedBox(
                height: 20,
              ),
              BodyPage(),
            ],
          ),
        ),
      ),
    );
  }
}
