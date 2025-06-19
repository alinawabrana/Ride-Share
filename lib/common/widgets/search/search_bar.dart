import 'package:flutter/material.dart';

import '../../../data/services/shared_preferences_service.dart';

class ASearchBarTextField extends StatelessWidget {
  const ASearchBarTextField({
    super.key,
    required this.searchController,
    this.contentPadding = 20.0,
    this.borderRadius = 30.0,
    this.onChange = false,
    this.keepHistory = false,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    required this.hintText,
  });

  final TextEditingController searchController;
  final double borderRadius;
  final double contentPadding;
  final bool onChange;
  final bool keepHistory;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1, color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1, color: Colors.transparent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1, color: Colors.transparent),
        ),
        contentPadding: EdgeInsets.all(contentPadding),
        suffixIcon: suffixIcon,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffix: suffix,
        prefix: prefix,
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: onChange ? null : null,
      onSubmitted:
          onChange
              ? null
              : (value) {
                if (keepHistory) {
                  SharedPreferencesService().addSearchQuery(value);
                }
              },
    );
  }
}
