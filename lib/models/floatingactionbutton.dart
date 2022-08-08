import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/modelprovider.dart';

class ActionButton extends StatelessWidget {
  final ScrollController scrollController;
  const ActionButton({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Consumer<ModelProvider>(
      builder: (context, value, child) {
        double w = SizeConfig.screenWidth!;
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          bottom: w < 600 ? value.animatedFloatButtonPositionedValue - 10 : value.animatedFloatButtonPositionedValue,
          right: w < 600 ? 20 : 30,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: value.animatedFloatButtonPositionedValue == 30 ? 1 : 0,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => scrollController.position.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn),
                child: Container(
                  width: w < 600 ? 50 : 60, height: w < 600 ? 50 : 60, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle), child: const Center(child: Icon(Icons.keyboard_arrow_up, color: Colors.white)),),
              ),
            ),
          ),
        );
      },
    );
  }
}