import 'package:flutter/material.dart';

class CommonDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final String hintText;
  final Function(String?) onChanged;

  const CommonDropdown({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue?.isNotEmpty == true ? selectedValue : null,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(fontSize: 4),),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
