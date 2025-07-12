import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payme/app/clients/presentation/client_screen.dart';
import 'package:payme/auth/domain/repositories/i_secure_storage.dart';
import 'package:payme/core/extensions/route_extension.dart';
import 'package:payme/core/http/endpoints.dart';
import 'package:payme/injection.dart';

class ReportMenuScreen extends StatelessWidget {
  const ReportMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Отчеты')),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Заказ поставщику по контрагенту',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Сформировать заказ по поставщику за текущий день по объектам',
            ),
            onTap: () {
              context.push(
                ClientScreen(
                  onSelected: (clientModel) {
                    // Здесь вы можете передать UUID клиента в функцию скачивания отчета
                    downloadAndOpenReport(
                      context,
                      clientUuid: clientModel.uuid,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Функция для скачивания и открытия отчета
Future<void> downloadAndOpenReport(
  BuildContext context, {
  required String clientUuid,
}) async {
  // Показываем индикатор загрузки
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(child: CircularProgressIndicator()),
  );

  final dio = Dio();
  final url = Endpoints.report.reports;

  // Предполагается, что токен вы где-то храните (например, в SharedPreferences)
  final token =
      await getIt<ISecureStorage>().read(); // Ваша функция получения токена
  if (token == null) {
    Navigator.of(context).pop(); // Убираем индикатор
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Ошибка: токен не найден')));
    return;
  }

  if (token.access == "") {
    Navigator.of(context).pop(); // Убираем индикатор
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Ошибка: вы не авторизованы')));
    return;
  }

  try {
    final response = await dio.get(
      url,
      queryParameters: {
        'clientUuid': clientUuid, // Параметр запроса
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer ${token.access}',
          'Content-Type': 'application/json',
        },
        // ВАЖНО: указываем, что ожидаем получить массив байт
        responseType: ResponseType.bytes,
      ),
    );

    Navigator.of(context).pop(); // Убираем индикатор загрузки

    if (response.statusCode == 200) {
      // 1. Получаем директорию для сохранения файла
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/report.pdf';

      // 2. Сохраняем полученные байты в файл
      final file = File(filePath);
      await file.writeAsBytes(response.data);

      // 3. Открываем файл
      final openResult = await OpenFile.open(filePath);

      if (openResult.type != ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Не удалось открыть файл: ${openResult.message}'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка сервера: ${response.statusCode}')),
      );
    }
  } catch (e) {
    //Navigator.of(context).pop(); // Убираем индикатор
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Произошла ошибка: $e')));
  }
}
