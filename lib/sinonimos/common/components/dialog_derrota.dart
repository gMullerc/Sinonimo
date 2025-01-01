import 'package:flutter/material.dart';

class DialogDerrota extends StatelessWidget {
  final Function fecharModal;
  const DialogDerrota({super.key, required this.fecharModal});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('This is a typical dialog.'),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => fecharModal(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
