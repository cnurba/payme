import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/application/brands_future_provider.dart';
import 'package:payme/app/brands/presentation/brands_screen.dart';
import 'package:payme/app/widgets/home_menu_widget.dart';
import 'package:payme/core/failure/app_result.dart';

class BrandsHomeWidget extends ConsumerWidget {
  const BrandsHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(brandsFutureProvider);

    return resultAsync.when(
      data: (apiResult) {
        if (apiResult is ApiResultWithData) {
          final brands = apiResult.data;
          return HomeMenuWidget(
            bgColor: Colors.lightBlueAccent,
            buttonText: "Перейти",
            countText: "Загружены",
            title: 'Категории',
            description: "Cоздать заявку!",
            count: brands.length,
            onTap: () {
              if (brands.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Нет категорий для отображения")),
                );
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return BrandsScreen(brands: brands);
                  },
                ),
              );
            },
          );
        } else {
          return SizedBox.shrink();
        }
      },
      error: (e, s) => SizedBox.shrink(),
      loading: () => SizedBox.shrink(),
    );
  }
}
