import 'package:flutter/material.dart';
import 'package:fogsi/utils/theme.dart';

import '../../utils/colors.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final String label;
  final bool isNumericKeyBoard;
  final bool isObscure;
  final bool enabled;
  final IconButton? suffixIcon;
  final bool? obscureText;
  final InputBorder? inputBorder;
  final TextEditingController textEditingController;
  final EdgeInsets? padding;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onPressed;
  final Widget? prefixIcon;
  final Function(String)? onSubmitted;

  const CustomSearchField({
    required this.hintText,
    required this.textEditingController,
    this.inputBorder,
    this.padding,
    this.label = "",
    this.validator,
    this.onChanged,
    this.onPressed,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.isNumericKeyBoard = false,
    this.isObscure = false,
    this.enabled = true,
    required this.onSubmitted, // Add this line
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0),
      height: 45,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          label: Text(
            label,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          alignLabelWithHint: true,
          suffixIcon: suffixIcon,
          prefixIcon: Container(
            padding: EdgeInsets.zero,
            child: prefixIcon,
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Rubik',
              color: minContrastGrey
          ),
          contentPadding: EdgeInsets.only(bottom: 10),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyle(
            color: Theme.of(context).errorColor,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        obscureText: obscureText ?? false,
        keyboardType: isNumericKeyBoard
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        enabled: enabled,
        style: AppTheme.appTheme.textTheme.bodyMedium,
        validator: validator,
        onChanged: onChanged,
        onTap: onPressed,
        onFieldSubmitted: onSubmitted,
      ),
    );
  }
}
