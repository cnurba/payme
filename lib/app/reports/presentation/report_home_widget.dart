import 'package:flutter/material.dart';
import 'package:payme/app/a_home/widgets/home_menu_widget.dart';
import 'package:payme/app/reports/presentation/report_menu_screen.dart';
import 'package:payme/core/extensions/route_extension.dart';

class ReportHomeWidget extends StatelessWidget {
  const ReportHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeMenuWidget(
      bgColor: Colors.green,
      buttonText: "Перейти",
      countText: "Кол-во отчетов",
      title: 'Отчеты',
      description: "Посмотреть\nотчеты",
      count: 1,
      onTap: () {
        context.push(ReportMenuScreen());
      },
    );
  }
}
