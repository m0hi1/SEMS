import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool? isNumeric;
  final bool? isMobile;
  final bool? isDisabled;
  final bool? isRequired;
  final void Function(TextEditingController)? onContactClicked;
  final VoidCallback? onFieldTapped;
  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    this.isNumeric = false,
    this.isMobile = false,
    this.isDisabled = false,
    this.onContactClicked,
    this.onFieldTapped,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onFieldTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          enabled: !isDisabled!,
          validator: (value) {
            if (!isRequired! && value!.isEmpty) return null;
            if (value == null || value.isEmpty) {
              return 'Please enter $title';
            }
            if (isMobile! && value.length != 10) {
              return 'Please enter a valid mobile number';
            }

            return null;
          },
          controller: controller,
          inputFormatters: [
            if (isNumeric!) FilteringTextInputFormatter.digitsOnly,
            if (isMobile!) LengthLimitingTextInputFormatter(13),
            if (isMobile!) FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: InputDecoration(
            labelText: title,

            labelStyle: const TextStyle(color: Colors.black),

            prefixIcon: isMobile!
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15), // (10),
                    child: const Text(
                      '+91',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                      textScaler: TextScaler.linear(1.2),
                    ),
                  )
                : null,

            suffixIcon: !isMobile!
                ? null
                : IconButton(
                    onPressed: () {
                      if (onContactClicked != null) {
                        onContactClicked!(controller);
                      }
                    },
                    icon: const Icon(
                      Icons.contact_phone,
                      color: Color.fromARGB(255, 2, 20, 109),
                      size: 30,
                    ),
                  ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),

            // disabledBorder: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
