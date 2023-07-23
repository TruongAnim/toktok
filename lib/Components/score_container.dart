import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/controllers/auth_controller.dart';

class CoinContainer extends StatelessWidget {
  const CoinContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Wrap(
        children: [
          Image.asset(
            'assets/coin.png',
            scale: 2.5,
          ),
          const SizedBox(width: 10),
          Obx(
            () {
              return Text(
                AuthController.instance.appUser.value.points.toString(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
