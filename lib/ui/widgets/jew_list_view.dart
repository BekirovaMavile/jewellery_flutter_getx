import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jewellry_shop/states/jew_state.dart';
import '../../data/_data.dart';
import '../../ui_kit/_ui_kit.dart';
import '../_ui.dart';

class JewListView extends StatelessWidget {
  JewListView({super.key, required this.jews, this.isReversed = false});

  final List<Jew> jews;
  final bool isReversed;
  final _state = Get.find<JewState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 200,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 20),
          itemBuilder: (_, index) {
            Jew jew = isReversed ? jews.reversed.toList()[index] : jews[index];
            return GestureDetector(
              onTap: () async {
                print('Клик на карточку');
                await _state.onSetSelectedJew(jew);
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const JewDetail()));
              },
              child: Container(
                width: 160,
                decoration: BoxDecoration(
                  color: isDark ? DarkThemeColor.primaryDark : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(jew.image, scale: 6, height: 90),
                      Text(
                        "\$${jew.price}",
                        style: AppTextStyle.h3Style.copyWith(color: LightThemeColor.purple),
                      ),
                      Text(
                        jew.name,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) {
            return Container(
              width: 50,
            );
          },
          itemCount: jews.length),
    );
  }
}

