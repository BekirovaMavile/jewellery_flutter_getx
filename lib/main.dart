import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jewellry_shop/states/jew_state.dart';
import 'package:jewellry_shop/ui/_ui.dart';
import 'package:jewellry_shop/ui/screens/home_screen.dart';
import 'package:jewellry_shop/ui_kit/app_theme.dart';

void main() {
  _bind();
  runApp(const MyApp());
}

class MyAppController extends GetxController {
  final _state = Get.find<JewState>();
  bool get isLight => _state.isLigth();
}

class MyApp extends GetView<MyAppController> {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'Jewellery Shop',
      theme: controller.isLight ? AppTheme.lightTheme : AppTheme.darkTheme,
      home: const HomeScreen(),
    ));
  }
}

void _bind() {
  Get.lazyPut(() => JewState());
  Get.lazyPut(() => JewListController());
  Get.lazyPut(() => JewDetailController());
  Get.lazyPut(() => CartScreenController());
  Get.lazyPut(() => FavoriteScreenController());
  Get.lazyPut(() => MyAppController());
}
