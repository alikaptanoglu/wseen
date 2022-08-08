import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Consumer<ModelProvider>(
      builder: (context, value, child) {
        return IndexedStack(
          alignment: Alignment.center,
          index: value.signState,
          children: const [
            SignUpPage(),
            LoginPage(),
          ],
        );
      },
    );
  }
}



