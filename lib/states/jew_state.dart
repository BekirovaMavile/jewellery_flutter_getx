import 'package:flutter/material.dart';
import '../data/_data.dart';
import 'package:get/get.dart';
import '../ui/_ui.dart';
// import 'package:jewellry_shop/data/models/jew.dart';

class JewState {
  // JewState._();
  // static final _instance = JewState._();
  // factory JewState() => _instance;


  //Переменные
  RxList<JewCategory> categories = AppData.categories.obs;
  RxList<Jew> jews = AppData.jewItems.obs;
  RxList<Jew> jewsByCategory = AppData.jewItems.obs;
  RxList<Jew> cart = <Jew>[].obs;
  RxList<Jew> favorite = <Jew>[].obs;
  RxBool isLigth = true.obs;
  Rx<Jew> selectedJew = AppData.jewItems[0].obs;


  Future<void> onSetSelectedJew(Jew jew) async {
    selectedJew.value = jew;
  }

  Future<void> onCategoryTap(JewCategory category) async {
    categories.map((e) {
      if (e.type == category.type) {
        e.isSelected = true;
      } else {
        e.isSelected = false;
      }
    }).toList();
    categories.refresh();
    if (category.type == JewType.all) {
      jewsByCategory.value = jews;
    } else {
      jewsByCategory.value =
          jews.where((e) => e.type == category.type).toList();
    }
  }

  Future<void> onIncreaseQuantityTap(Jew jew) async {
    jew.quantity++;
    selectedJew.refresh();
    cart.refresh();
  }

  Future<void> onDecreaseQuantityTap(Jew jew) async {
    if (jew.quantity == 1) return;
    jew.quantity--;
    selectedJew.refresh();
    cart.refresh();
  }

  Future<void> onAddToCartTap(Jew jew) async {
    jew.cart = true;
    cart.value = jews.where((p0) => p0.cart).toList();
  }

  Future<void> onRemoveFromCartTap(Jew jew) async {
    jew.cart = false;
    jew.quantity = 1;
    cart.value = jews.where((p0) => p0.cart).toList();
  }

  Future<void> onCheckOutTap() async {
    for (var element in cart) {
      element.cart = false;
      element.quantity = 1;
    }
    cart.value = jews.where((p0) => p0.cart).toList();
  }

  Future<void> onAddRemoveFavoriteTap(Jew jew) async {
    jew.isFavorite = !jew.isFavorite;
    selectedJew.refresh();
    favorite.value = jews.where((p0) => p0.isFavorite).toList();
  }

  void toggleTheme() {
    isLigth.value = !isLigth.value;
  }

  String jewPrice(Jew jew) {
    return (jew.quantity * jew.price).toString();
  }

  double get subtotal {
    double amount = 0.0;
    for (var element in cart) {
      amount = amount + element.price * element.quantity;
    }
    return amount;
  }
}