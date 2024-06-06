import 'package:flutter/material.dart';

import '../../utils/styles/color.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return  Divider(
      color: appPrincipalColor.withOpacity(0.2),
      thickness: 1,
    );
  }
}
