import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/clients/application/client_provider.dart';
import 'package:payme/app/clients/domain/models/client_model.dart';
import 'package:payme/core/extensions/route_extension.dart';
import 'package:payme/core/failure/app_result.dart';

// Провайдер для хранения текущего поискового запроса
final searchQueryProvider = StateProvider<String>((ref) => '');


class ClientScreen extends ConsumerStatefulWidget {
  const ClientScreen({super.key, this.onSelected});
  final Function(ClientModel)? onSelected;

  @override
  ConsumerState<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends ConsumerState<ClientScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose(); // Важно очищать контроллер
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Следим за асинхронными данными
    final asyncUnit = ref.watch(clientProvider);
    // 2. Следим за строкой поиска
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        // 3. Вместо простого текста используем поле для поиска
        title: TextField(
          controller: _searchController,
          autofocus: true, // Сразу активировать поле при открытии экрана
          decoration: InputDecoration(
            hintText: 'Поиск по наименованию...',
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            // Иконка для очистки поля поиска
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                ref.read(searchQueryProvider.notifier).state = '';
              },
            )
                : null,
          ),
          // Обновляем провайдер при каждом изменении текста
          onChanged: (query) {
            ref.read(searchQueryProvider.notifier).state = query;
          },
        ),
      ),
      body: asyncUnit.when(
        data: (apiResult) {
          if (apiResult is ApiResultWithData) {
            final allClients = apiResult.data as List<ClientModel>;

            // 4. Фильтруем список на основе поискового запроса
            final filteredClients = allClients.where((client) {
              final nameLower = client.name.toLowerCase();
              final searchLower = searchQuery.toLowerCase();
              return nameLower.contains(searchLower);
            }).toList();

            if (filteredClients.isEmpty && searchQuery.isNotEmpty) {
              return Center(child: Text('Поставщики не найдены'));
            }

            return ListView.separated(
              // Добавим, чтобы клавиатура скрывалась при скролле
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) {
                final client = filteredClients[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      client.name.isNotEmpty ? client.name.substring(0, 1).toUpperCase() : '?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  title: Text(client.name),
                  onTap: () {
                    if (widget.onSelected != null) {
                      widget.onSelected!(client);
                      // Убираем фокус с поля поиска, чтобы клавиатура скрылась перед возвратом
                      FocusScope.of(context).unfocus();
                      context.pop();
                    }
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: filteredClients.length,
            );
          } else {
            // Можно показать сообщение, если данные пришли, но в неверном формате
            return Center(child: Text('Некорректный формат данных'));
          }
        },
        error: (e, s) => Center(child: Text('Ошибка загрузки: $e')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

//
// class ClientScreen extends ConsumerWidget {
//   const ClientScreen({super.key, this.onSelected});
//   final Function(ClientModel)? onSelected;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final asyncUnit = ref.watch(clientProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           onSelected == null ? 'Список поставщиков' : 'Выберите поставщика',
//         ),
//         centerTitle: true,
//       ),
//       body: asyncUnit.when(
//         data: (apiResult) {
//           if (apiResult is ApiResultWithData) {
//             final clients = apiResult.data;
//             return ListView.separated(
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.green,
//                     child: Text(
//                       clients[index].name.substring(0, 1).toUpperCase(),
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 4,
//                   ),
//                   title: Text(clients[index].name),
//
//                   onTap: () {
//                     if (onSelected != null) {
//                       onSelected!(clients[index]);
//                       context.pop(context);
//                     }
//                   },
//                 );
//               },
//               separatorBuilder: (context, index) => Divider(),
//               itemCount: clients.length,
//             );
//           } else {
//             return SizedBox.shrink();
//           }
//         },
//         error: (e, s) => SizedBox.shrink(),
//         loading: () => SizedBox.shrink(),
//       ),
//     );
//   }
// }
