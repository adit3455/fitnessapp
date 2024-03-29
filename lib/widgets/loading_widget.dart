import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final int count;
  const LoadingWidget({required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            count,
            (index) => const CardLoading(
                  height: 60,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  margin: EdgeInsets.symmetric(vertical: 5),
                )));
  }
}
