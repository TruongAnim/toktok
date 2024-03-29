import 'package:flutter/material.dart';
import 'package:toktok/Theme/colors.dart';

class RedeemProductDetails {
  final String image;
  final String name;
  final String numberOfCoins;
  final Color color;
  final String redeemedCodes;

  RedeemProductDetails(this.image, this.name, this.numberOfCoins, this.color,
      this.redeemedCodes);
}

// ignore: must_be_immutable
class RedeemProduct extends StatelessWidget {
  bool isRedeemed = false;
  RedeemProduct(this.isRedeemed);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    List<RedeemProductDetails> redeemProductDetails = [
      RedeemProductDetails("assets/1.png", "Headphone", "1000",
          const Color(0xffEF2938), "XDWA124A"),
      RedeemProductDetails("assets/2.png", "M-audio Subscription (3m)", "250",
          const Color(0xff1B4499), "XDWA124A"),
      RedeemProductDetails("assets/3.png", "Flat 15% Cashback", "1000",
          const Color(0xffDBA32F), "XDWA124A"),
      RedeemProductDetails("assets/4.png", "Sunglasses", "5000",
          const Color(0xffCA2231), "XDWA124A"),
      RedeemProductDetails("assets/1.png", "Headphone", "1000",
          const Color(0xffEF2938), "XDWA124A"),
      RedeemProductDetails("assets/2.png", "M-audio Subscription (3m)", "250",
          const Color(0xff1B4499), "XDWA124A"),
      RedeemProductDetails("assets/3.png", "Flat 15% Cashback", "1000",
          const Color(0xffDBA32F), "XDWA124A"),
      RedeemProductDetails("assets/4.png", "Sunglasses", "5000",
          const Color(0xffCA2231), "XDWA124A"),
    ];
    return ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: redeemProductDetails.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Image.asset(redeemProductDetails[index].image),
                    PositionedDirectional(
                      start: 120,
                      top: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            redeemProductDetails[index].name,
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/coin.png",
                                scale: 2.5,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${redeemProductDetails[index].numberOfCoins} coins',
                                style: theme.textTheme.labelLarge!.copyWith(
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryColor.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PositionedDirectional(
                      bottom: 20,
                      end: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          isRedeemed
                              ? redeemProductDetails[index].redeemedCodes
                              : "Redeem now".toUpperCase(),
                          style: theme.textTheme.labelLarge!.copyWith(
                              color: secondaryColor,
                              fontSize: 8,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          );
        });
  }
}
