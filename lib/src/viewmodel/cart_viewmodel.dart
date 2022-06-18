import 'package:fashion_app/network/dio_service.dart';
import 'package:fashion_app/src/data/model/address.dart';
import 'package:fashion_app/src/data/model/cart_model/cart_model.dart';
import 'package:fashion_app/src/data/model/inventory.dart';
import 'package:fashion_app/src/data/model/cart.dart';
import 'package:fashion_app/src/data/model/order.dart';
import 'package:fashion_app/src/data/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class CartViewModel extends ChangeNotifier with DioService {
  List<Cart> listCart = [];
  int curr = 1;
  bool isFound = true;
  String message = '';
  double total = 0;
  int productCount = 0;
  List<Order> listOrder = [];

  CartModel? cartModel;
  bool isLoadingCart = true;
  GetStorage session = GetStorage();

  addToCart(Product product, Inventory inventoryy) {
    productCount = 0;
    if (listCart.isEmpty) {
      listCart.add(
        Cart().copyWith(
          product: product.copyWith(inventory: [inventoryy]),
        ),
      );
      productCount = listCart.length;
      print('EMPTY ${productCount}');
    } else {
      for (int i = 0; i < listCart.length; i++) {
        var index = listCart[i]
            .product
            ?.inventory
            ?.indexWhere((element) => element.id == inventoryy.id);
        debugPrint("INDEX ${index}");
        if (index != -1) {
          if (listCart[i].quantity < inventoryy.stockQuantity!) {
            listCart[i].quantity++;
          } else {
            message = "Số lượng không đủ";
          }
        } else {
          isFound = false;
        }
      }
      if (!isFound) {
        listCart.add(
          Cart().copyWith(
            product: product.copyWith(inventory: [inventoryy]),
          ),
        );
        notifyListeners();
      }

      productCount += listCart.length;
      print('NOT EMPTY ${productCount}');
    }
    calculatePrice();
    notifyListeners();
  }

  void calculatePrice() {
    total = 0;
    listCart.forEach((element) {
      total += element.product!.price! * element.quantity;
    });
    notifyListeners();
  }

  Future increQuantity(Cart order, Inventory inventory) async {
    if (order.quantity < inventory.stockQuantity!) {
      order.quantity++;
    } else {
      message = "Số lượng ko đủ";
    }
    calculatePrice();
    notifyListeners();
  }

  void deceQuanity(Cart order) {
    if (order.quantity > 1) {
      order.quantity--;
    } else {}
    calculatePrice();
    notifyListeners();
  }

  void removeCart(int index) {
    listCart.removeAt(index);
    if (productCount != 0) {
      productCount--;
    }
    calculatePrice();
    notifyListeners();
  }

  void checkOutCart() {
    listOrder.add(Order(
        createAt: "12-10-2012",
        total: total.toString(),
        listItemCart: listCart,
        address: Address(
            userName: "KHOA",
            addressTitle1: "VO VAN VAN",
            addressTitle2: "9384932",
            phone: "97334324"),
        orderNumber: "098765456789"));
  }

  Future getCartProduk() async {
    cartModel = null;
    isLoadingCart = true;

    final res = await dio
        .post('showkranjang', data: {"user_id": session.read('userID')});
    isLoadingCart = false;
    notifyListeners();
    if (res.statusCode == 201) {
      cartModel = CartModel.fromJson(res.data);
      notifyListeners();
    }
  }
}
