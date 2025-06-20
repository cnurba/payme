import 'package:flutter/cupertino.dart';

class PayMeCheckBox extends StatefulWidget {
  const PayMeCheckBox({super.key, required this.onSelect, this.selected =false});

  final Function(bool) onSelect;
  final bool selected;

  @override
  State<PayMeCheckBox> createState() => _PayMeCheckBoxState();
}

class _PayMeCheckBoxState extends State<PayMeCheckBox> {
  bool selected = false;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CupertinoSwitch(
            value: selected,
            onChanged: (v) {
              selected = v;
              setState(() {});
              widget.onSelect(selected);
            }),
        const SizedBox(width: 8),
        Text(
          selected ? "Срочный" : "Не срочный",
          style: const TextStyle(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
