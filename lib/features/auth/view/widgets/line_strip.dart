import 'package:flutter/material.dart';
import 'package:metro_mate/core/const/colors.dart';

class LineStrip extends StatelessWidget {
  const LineStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 5,
      child: Row(
        textDirection: TextDirection.ltr,
        children: List.generate(
          4,
          (index) => Expanded(
            child: Container(
              height: 5,
              color: AppColors.line(index + 1),
            ),
          ),
        ),
      ),
    );
  }
}