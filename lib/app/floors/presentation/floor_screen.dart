import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/floors/application/floor_provider.dart';
import 'package:payme/app/floors/domain/models/floor_model.dart';
import 'package:payme/core/extensions/route_extension.dart';
import 'package:payme/core/failure/app_result.dart';

class FloorScreen extends ConsumerWidget {
  const FloorScreen({super.key, this.onFloorSelected});

  final Function(FloorModel)? onFloorSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFloor = ref.watch(floorProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(onFloorSelected == null ? 'Этажы' : 'Выберите этаж'),
        centerTitle: true,
      ),
      body: asyncFloor.when(
        data: (apiResult) {
          if (apiResult is ApiResultWithData) {
            final _floors = apiResult.data as List<FloorModel>;
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.5,
              ),
              itemCount: _floors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (onFloorSelected != null) {
                      onFloorSelected!(_floors[index]);
                      context.pop();
                    }
                  },
                  child: Card(
                    child: Center(
                      child: Text(
                        _floors[index].name,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
      ),
    );
  }
}
