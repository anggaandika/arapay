import 'package:arapay/utility/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderMiniWidget extends StatelessWidget {
  const HeaderMiniWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => context.read<Home>().menuTogel = false,
          icon: const Icon(Icons.arrow_back_ios, color: kTextColor),
        ),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Container()
      ],
    );
  }
}
