import 'package:flutter/material.dart';
import 'package:flutter_uber_eats/common/layouts/default_layout.dart';

class RootTab extends StatelessWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Text(
        'Root Tab',
      ),
    );
  }
}
