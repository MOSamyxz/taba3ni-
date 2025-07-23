import 'package:flutter/material.dart';
import 'package:taba3ni/core/constants/app_colors.dart';
import 'package:taba3ni/core/constants/app_size.dart';

class GradientDropdownField extends StatefulWidget {
  const GradientDropdownField({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.labelText,
  });

  final List<DropdownMenuItem<String>> items;
  final String? value;
  final void Function(String?) onChanged;
  final String labelText;

  @override
  State<GradientDropdownField> createState() => _GradientDropdownFieldState();
}

class _GradientDropdownFieldState extends State<GradientDropdownField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.borderRadius + 2),
        gradient: _isFocused
            ? const LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [AppColors.primary, AppColors.primaryLight],
              )
            : LinearGradient(
                colors: [Colors.grey.shade300, Colors.grey.shade300],
              ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightBackground,
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
        child: DropdownButtonFormField<String>(
          focusNode: _focusNode,
          value: widget.value,
          decoration: InputDecoration(
            contentPadding: AppSize.symmetricPadding,
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: AppColors.textSecondary),
            border: InputBorder.none,
          ),
          items: widget.items,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
