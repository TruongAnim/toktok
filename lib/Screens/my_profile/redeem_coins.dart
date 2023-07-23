import 'package:flutter/material.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/Components/redeem_product.dart';

class RedeemCoins extends StatelessWidget {
  const RedeemCoins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Your Coin Balance",
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 120,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/coin.png',
                  scale: 1.4,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "750",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12))),
              child: ListView(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Redeem Coin Offers",
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageRoutes.redeemHistory);
                        },
                        child: Text(
                          "History",
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RedeemProduct(false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
