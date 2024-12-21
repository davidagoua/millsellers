import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class InputWrapperView extends GetView {

  final Widget child;

  const InputWrapperView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    ).px(3).card.color(const Color.fromRGBO(243, 243, 243, 1)).elevation(0)
        .customRounded(BorderRadius.circular(5))
        .p0.make();
  }
}
