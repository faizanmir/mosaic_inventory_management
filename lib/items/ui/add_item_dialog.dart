import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mosaic_inventory_management/models/item.dart';

enum TextBoxIdentifier { rate, itemName, count }

class AddItemDialog extends StatefulWidget {
  final Function(Item) onItemAdded;

  const AddItemDialog({Key? key, required this.onItemAdded}) : super(key: key);

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  String? itemName;
  double? rate;
  double? count;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              getTextField("Item Name", TextBoxIdentifier.itemName,
                  (p0) => itemName = p0),
              const SizedBox(
                height: 10,
              ),
              getTextField("Rate", TextBoxIdentifier.rate,
                  (p0) => rate = double.parse(p0)),
              const SizedBox(
                height: 10,
              ),
              getTextField("Count", TextBoxIdentifier.count,
                  (p0) => count = double.parse(p0)),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Add Item"),
                  textColor: Colors.white,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.onItemAdded(Item.fromMap(
                          {"count": count, "rate": rate, "name": itemName}));
                      Navigator.pop(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget getTextField(String label, TextBoxIdentifier textBoxIdentifier,
      Function(String) onChanged) {
    return TextFormField(
      inputFormatters: [
        (textBoxIdentifier == TextBoxIdentifier.rate ||
                textBoxIdentifier == TextBoxIdentifier.count)
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter
      ],
      validator: (p0) => p0!.isEmpty ? "Field is necessary" : null,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        focusedErrorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        label: Text(label),
        errorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
