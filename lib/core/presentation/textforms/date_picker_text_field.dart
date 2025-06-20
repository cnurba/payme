import 'package:flutter/material.dart';
import 'package:payme/core/extensions/date_extensions.dart';

class DatePickerTextField extends StatefulWidget {
  const DatePickerTextField({
    super.key,
    required this.title,
    this.hintText = '',
    required this.onChanged,
    this.initialText = '',
    this.visible = true,
    this.width = 200,
  });

  final String title;
  final String initialText;
  final String hintText;
  final Function(DateTime) onChanged;
  final bool visible;
  final double width;

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialText.isNotEmpty) {
      _controller.text = widget.initialText;
    } else {
      _controller.text =
          DateTime.now().add(const Duration(days: 1)).toFormattedString();
    }
    _controller.addListener(() {
      //widget.onChanged(_controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: SizedBox(
        width: widget.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2.3,
              child: TextFormField(
                readOnly: true,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  border: OutlineInputBorder(
                    //borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green)
                  ),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2035),
                        ).then((value) {
                          if (value != null) {
                            _controller.text = value.toFormattedString();
                            widget.onChanged(value);
                          }
                        });
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
