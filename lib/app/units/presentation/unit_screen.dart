import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/units/application/unit_provider.dart';
import 'package:payme/app/units/domain/models/unit_model.dart';
import 'package:payme/core/failure/app_result.dart';

class UnitScreen extends ConsumerWidget {
  const UnitScreen({super.key, this.onUnitSelected});
  final Function(UnitModel)? onUnitSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUnit = ref.watch(unitProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          onUnitSelected == null ? 'Единицы измерения' : 'Выберите единицу',
        ),
        centerTitle: true,
      ),
      body: asyncUnit.when(
        data: (apiResult) {
          if (apiResult is ApiResultWithData) {
            final units = apiResult.data;
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      units[index].name.substring(0, 1).toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  title: Text(units[index].name),

                  onTap: () {
                    onUnitSelected?.call(units[index]);
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: units.length,
            );
          } else {
            return SizedBox.shrink();
          }
        },
        error: (e, s) => SizedBox.shrink(),
        loading: () => SizedBox.shrink(),
      ),
    );
  }
}
