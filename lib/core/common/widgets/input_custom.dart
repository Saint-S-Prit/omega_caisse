import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/toggle_obscure_text/toggle_obscure_text_bloc.dart';
import '../../services/toggle_obscure_text/toggle_obscure_text_event.dart';
import '../../utils/styles/color.dart';
import '../../utils/styles/typo.dart';

class InputCustom extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final bool obscureText;
  final Function? validator;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool autofocus;
  final FocusNode? focusNode; // Add FocusNode parameter

  const InputCustom({
    Key? key,
    this.controller,
    this.initialValue,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.autofocus = false,
    this.focusNode, // Provide a default value
  }) : super(key: key);

  @override
  _InputCustomState createState() => _InputCustomState();
}

class _InputCustomState extends State<InputCustom> {
  late FocusNode _focusNode; // Declare a FocusNode

  @override
  void initState() {
    super.initState();
    // Initialize the FocusNode and apply the autofocus if required
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.autofocus) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  @override
  void dispose() {
    // Dispose the FocusNode when the widget is disposed
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller ?? TextEditingController(text: widget.initialValue),
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              focusNode: _focusNode, // Assign the FocusNode to the text field
              decoration: InputDecoration(
                hintText: widget.hintText,
                labelText: widget.labelText,
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: appPrincipalColor) : null,
                suffixIcon: widget.suffixIcon != null ? GestureDetector(
                  onTap: () {
                    if (widget.suffixIcon == Icons.lock) {
                      context.read<ToggleObscureTextBloc>().add(ToggleEvent());
                    }
                  },
                  child: Icon(widget.obscureText ? Icons.visibility : Icons.visibility_off),
                ) : null,
                errorStyle: const TextStyle(
                  color: appColorError,
                ),
                errorBorder: TextStyles(myColor: appColorError).outlineInputBorder,
                focusedErrorBorder: TextStyles(myColor: appColorError).outlineInputBorder,
                enabledBorder: TextStyles().outlineInputBorder,
                focusedBorder: TextStyles().outlineInputBorder,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
              ),
              validator: (value) {
                final errorMessage = widget.validator!(value);
                if (errorMessage != null) {
                  // Handle the error here if necessary
                }
                return errorMessage;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
        ],
      ),
    );
  }
}



