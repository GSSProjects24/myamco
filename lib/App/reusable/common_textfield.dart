import 'package:flutter/material.dart';
import 'package:myamco/App/config/app_colors.dart';


class CommonTextInput extends StatelessWidget {
  final String label;
  final String? hint;
  final String? initialValue;
  final bool readOnly;
  final int maxLines;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;

  const CommonTextInput({
    super.key,
    required this.label,
    this.hint,
    this.initialValue,
    this.readOnly = false,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.onSaved,
    this.validator,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initialValue,
          readOnly: readOnly,
          maxLines: maxLines,
          keyboardType: inputType,
          textInputAction: inputAction,
          onSaved: onSaved,
          validator: validator,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            fillColor: AppColors.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}
