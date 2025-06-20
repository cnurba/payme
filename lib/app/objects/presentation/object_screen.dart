import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/objects/application/object_provider.dart';
import 'package:payme/app/objects/domain/models/object_model.dart';
import 'package:payme/core/extensions/route_extension.dart';
import 'package:payme/core/failure/app_result.dart';

class ObjectScreen extends ConsumerWidget {
  const ObjectScreen({super.key, this.onObjectSelected});
  final Function(ObjectModel)? onObjectSelected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncObject = ref.watch(objectProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(onObjectSelected == null ? 'Обьекты' : 'Выберите объект'),
        centerTitle: true,
      ),
      body: asyncObject.when(
        data: (apiResult) {
          if (apiResult is ApiResultWithData) {
            final objects = apiResult.data;
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.5,
              ),
              itemCount: objects.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onObjectSelected?.call(objects[index]);
                    context.pop();
                  },
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey,
                    surfaceTintColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        objects[index].name,
                        style: TextStyle(
                          fontSize: 22,
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
