import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/presentation/brands_menu_widget.dart';
import 'package:payme/app/tasks/presentation/task_home_widget.dart';

import '../auth/application/current_user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(userProvider);
            return user.when(
              data: (v) => Text(v.name),
              error: (e, s) => SizedBox.shrink(),
              loading: () => SizedBox.shrink(),
            );
          },
        ),
      ),
      body: ListView(children: [TaskHomeWidget(), BrandsHomeWidget()]),
    );
  }
}
