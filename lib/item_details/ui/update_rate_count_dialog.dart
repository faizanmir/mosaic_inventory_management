import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParameterChangeDialog extends StatefulWidget {
  final bool isCount;
  final Function(double) onParameterChange;

  const ParameterChangeDialog(
      {Key? key,
        required this.isCount,
        required this.onParameterChange,
       })
      : super(key: key);

  @override
  _ParameterChangeDialogState createState() => _ParameterChangeDialogState();
}

class _ParameterChangeDialogState extends State<ParameterChangeDialog> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Text(
                widget.isCount
                    ? "Please enter the new count "
                    : "Please enter the new rate ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: controller,
              decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  )),
            ),
            MaterialButton(
              textColor: Colors.white,
              child: const Text("Change"),
              color: Colors.blue,
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  var change = double.parse(controller.text);
                  widget.onParameterChange(change);
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}