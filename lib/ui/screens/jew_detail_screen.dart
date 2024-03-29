import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jewellry_shop/data/_data.dart';
import 'package:jewellry_shop/states/jew_state.dart';
import 'package:jewellry_shop/ui/widgets/counter_button.dart';
import 'package:jewellry_shop/ui_kit/_ui_kit.dart';

class JewDetailController extends GetxController {
  final _state = Get.find<JewState>();
  Jew get jew => _state.selectedJew();

  void onIncreaseQuantityTap() {
    _state.onIncreaseQuantityTap(jew);
  }

  void onDecreaseQuantityTap() {
    _state.onDecreaseQuantityTap(jew);
  }

  void onAddToCartTap() {
    _state.onAddToCartTap(jew);
  }

  void onAddRemoveFavoriteTap() {
    _state.onAddRemoveFavoriteTap(jew);
  }
}

class JewDetail extends GetView<JewDetailController> {
  const JewDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(child: Image.asset(controller.jew.image, scale: 2)),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _bottomAppBar(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(
        'Jewellery Detail Screen',
        style: TextStyle(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white),
      ),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
    );
  }

  Widget _floatingActionButton() {
    return Obx(() => FloatingActionButton(
      elevation: 0.0,
      backgroundColor: LightThemeColor.purple,
      onPressed: controller.onAddRemoveFavoriteTap,
      child: controller.jew.isFavorite ? const Icon(AppIcon.heart) : const Icon(AppIcon.outlinedHeart),
    ));
  }

  Widget _bottomAppBar(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomAppBar(
            child: SizedBox(
                height: 300,
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark ? DarkThemeColor.primaryDark : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RatingBar.builder(
                                itemPadding: EdgeInsets.zero,
                                itemSize: 20,
                                initialRating: controller.jew.score,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                glow: false,
                                ignoreGestures: true,
                                itemBuilder: (_, __) => const FaIcon(
                                  FontAwesomeIcons.solidStar,
                                  color: LightThemeColor.yellow,
                                ),
                                onRatingUpdate: (rating) {
                                  print('$rating');
                                },
                              ),
                              const SizedBox(width: 15),
                              Text(
                                controller.jew.score.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "(${controller.jew.voter})",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${controller.jew.price}",
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(color: LightThemeColor.purple),
                              ),
                              CounterButton(
                                onIncrementTap: controller.onIncreaseQuantityTap,
                                onDecrementTap: controller.onDecreaseQuantityTap,
                                label: Obx(() => Text(
                                  controller.jew.quantity.toString(),
                                  style: Theme.of(context).textTheme.displayLarge,
                                )),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Description",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            controller.jew.description,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: ElevatedButton(
                                onPressed: controller.onAddToCartTap,
                                child: const Text("Add to cart"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ),
        ),
    );
  }
}
