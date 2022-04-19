import 'package:arapay/utility/main.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.active,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final double width, aspectRetio;
  final bool active;
  final String title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          // onTap: () => Navigator.pushNamed(
          //   context,
          //   DetailsScreen.routeName,
          //   arguments: ProductDetailsArguments(product: product),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AspectRatio(
              //   aspectRatio: 1.02,
              //   child: Container(
              //     padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              //     decoration: BoxDecoration(
              //       color: kSecondaryColor.withOpacity(0.1),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     // child: Hero(
              //     //   tag: product.id.toString(),
              //     //   child: Image.asset(product.images[0]),
              //     // ),
              //   ),
              // ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: active
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: active
                            ? const Color(0xFFFF4848)
                            : const Color(0xFFDBDEE4),
                        size: getProportionateScreenWidth(10),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
