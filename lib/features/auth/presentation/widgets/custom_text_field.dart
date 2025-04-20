import 'package:flutter/material.dart';

class CustomTextFormFieldd extends StatefulWidget {
  final String hintText;
  final IconData suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextFormFieldd({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    required this.controller,
    this.obscureText = false,
  });

  @override
  State<CustomTextFormFieldd> createState() => _CustomTextFormFielddState();
}

class _CustomTextFormFielddState extends State<CustomTextFormFieldd> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك ادخل ${widget.hintText}';
    }

    if (widget.hintText.contains('البريد')) {
      final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );
      if (!emailRegex.hasMatch(value)) {
        return 'من فضلك ادخل بريد إلكتروني صحيح';
      }
    }

    if (widget.hintText.contains('كلمة')) {
      if (value.length < 6) {
        return 'كلمة السر يجب أن تكون 6 أحرف على الأقل';
      }
      final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
      final hasNumber = RegExp(r'\d').hasMatch(value);
      final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

      if (!hasLowercase || !hasNumber || !hasSpecialChar) {
        return 'كلمة السر يجب أن تحتوي على حرف صغير، رقم، ورمز خاص';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        textDirection: TextDirection.rtl,
        validator: _validateInput,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF3F3F3),
          hintText: widget.hintText,
          hintTextDirection: TextDirection.rtl,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(widget.suffixIcon, color: Colors.grey),
          suffixIcon:
              widget.obscureText
                  ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                  : null,
          isDense: true,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      ),
    );
  }
}
