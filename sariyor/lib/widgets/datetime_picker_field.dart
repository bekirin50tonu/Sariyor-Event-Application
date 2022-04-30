import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sariyor/extensions/context_extensions.dart';

// ignore: must_be_immutable
class CustomDateTimePicker extends StatefulWidget {
  CustomDateTimePicker(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.startTime,
      required this.endTime,
      required this.displayLabel})
      : super(key: key);
  String label;
  String displayLabel = "Tarih Giriniz";
  DateTime date = DateTime.now();
  DateTime? startTime = DateTime.now();
  DateTime? endTime = DateTime.now().add(const Duration(days: 30));
  Function(DateTime?) onPressed;

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.label),
      subtitle: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white10,
                textStyle: context.themeText.headline6!,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
            onPressed: () async {
              await showModalBottomSheet(
                  context: context,
                  builder: (contextModal) {
                    return Wrap(
                      children: [
                        Center(
                          child: Text(
                            "Tarih Seçiniz.",
                            style: context.themeText.headline5,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: CupertinoDatePicker(
                              use24hFormat: true,
                              minimumDate: widget.startTime!
                                  .subtract(const Duration(minutes: 10)),
                              initialDateTime: widget.startTime,
                              maximumDate: widget.endTime,
                              onDateTimeChanged: (date) {
                                widget.date = date;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () {
                                  widget.onPressed(widget.date);
                                  Navigator.pop(contextModal);
                                },
                                child: Text(
                                  "Seç",
                                  style: context.themeText.headline6,
                                )),
                          ),
                        )
                      ],
                    );
                  });
            },
            child: Center(
              child: Text(widget.displayLabel),
            )),
      ),
    );
  }
}
