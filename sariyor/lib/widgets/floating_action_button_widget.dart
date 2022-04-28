import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 85, 72, 164),
      onPressed: () {
        showModalBottomSheet(
            context: context, builder: (_) => buildCreateEventWidget());
      },
      child: const Icon(Icons.add),
    );
  }

  Wrap buildCreateEventWidget() {
    return Wrap(
      children: const [
        Center(child: Text('Etkinlik Ekleme Buraya Gelecek!!!'))
      ],
    );
  }
}
