import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget registerTextField(
    {bool? showCursor,
    bool? readOnly,
    required String hintText,
    required TextEditingController controller,
    TextInputType? keyboardtype,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    Function()? ontap}) {
  return TextField(
    showCursor: showCursor,
    readOnly: readOnly != null ? readOnly : false,
    onTap: ontap,
    controller: controller,
    keyboardType: keyboardtype,
    textCapitalization: textCapitalization,
    inputFormatters: inputFormatters,
    decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: controller.clear,
          icon: Icon(Icons.clear),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(15)),
  );
}
