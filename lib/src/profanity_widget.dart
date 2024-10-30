import 'package:ai_profanity_textfield/profanity.dart';
import 'package:ai_profanity_textfield/src/validation_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ProfanityTextFormField extends StatefulWidget {
  final GeminiService geminiService;
  final bool checkWhileTyping;
  final Duration debounceDuration;
  final Function(String text)? onProfanityDetected;
  final Function(String text)? onCleanText;
  final Function(String error)? onError;
  final InputDecoration? decoration;
  final TextStyle? style;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool autofocus;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final InputDecoration? profanityDecoration;
  final bool clearOnProfanity;
  final Color? progressIndicatorColor;
  final double progressIndicatorSize;
  final List<FormFieldValidator<String>>? validators;
  final InputDecoration? successDecoration;
  final int? minLength;
  final Duration validationMessageDuration;
  final Function(ValidationState state)? onValidationStateChanged;
  final bool showValidIcon;
  final String profanityMessage;

  const ProfanityTextFormField({
    super.key,
    required this.geminiService,
    this.checkWhileTyping = true,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.onProfanityDetected,
    this.onCleanText,
    this.onError,
    this.decoration,
    this.style,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.profanityDecoration,
    this.clearOnProfanity = false,
    this.progressIndicatorColor,
    this.progressIndicatorSize = 20,
    this.validators,
    this.successDecoration,
    this.minLength,
    this.validationMessageDuration = const Duration(seconds: 3),
    this.onValidationStateChanged,
    this.showValidIcon = true,
    this.profanityMessage = 'Oops! Try a friendlier username.',
  });

  @override
  State<ProfanityTextFormField> createState() => _ProfanityTextFormFieldState();
}

class _ProfanityTextFormFieldState extends State<ProfanityTextFormField> {
  late TextEditingController _controller;
  Timer? _debounceTimer;
  bool _isChecking = false;
  bool _hasProfanity = false;
  String? _lastCheckedText;
  ValidationState _validationState = ValidationState.initial;
  String? _validationMessage;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String text) {
    if (text.isEmpty) {
      setState(() {
        _hasProfanity = false;
        _isChecking = false;
        _lastCheckedText = null;
        _validationState = ValidationState.invalid;
        _validationMessage = 'This field is required';
      });
      return;
    }

    if (!widget.checkWhileTyping) return;

    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      _validateText(text);
    });
  }

  Future<void> _validateText(String text) async {
    if (!mounted) return;

    // Handle empty text case immediately
    if (text.isEmpty) {
      setState(() {
        _hasProfanity = false;
        _isChecking = false;
        _validationState = ValidationState.invalid;
        _validationMessage = 'This field is required';
      });
      return;
    }

    setState(() {
      _isChecking = true;
      _validationState = ValidationState.loading;
      _validationMessage = null;
    });

    try {
      if (widget.validators != null && widget.validators!.isNotEmpty) {
        for (final validator in widget.validators!) {
          final error = validator(text);
          if (error != null) {
            setState(() {
              _isChecking = false;
              _validationState = ValidationState.invalid;
              _validationMessage = error;
            });
            return;
          }
        }
      }

      // Validasyonlar başarılı ise Gemini profanity kontrolü yap
      final hasProfanity = await widget.geminiService.checkProfanity(text);

      if (!mounted || text != _controller.text) return;

      if (hasProfanity) {
        setState(() {
          _hasProfanity = true;
          _isChecking = false;
          _validationState = ValidationState.invalid;
          _validationMessage = widget.profanityMessage;
        });

        widget.onProfanityDetected?.call(text);

        if (widget.clearOnProfanity) {
          _controller.clear();
          setState(() {
            _hasProfanity = false;
            _validationState = ValidationState.invalid;
            _validationMessage = 'This field is required';
          });
        }
        return;
      }

      setState(() {
        _hasProfanity = false;
        _isChecking = false;
        _validationState = ValidationState.valid;
        _validationMessage = null;
      });
      widget.onCleanText?.call(text);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isChecking = false;
        _validationState = ValidationState.invalid;
        _validationMessage = e.toString();
      });
      widget.onError?.call(e.toString());
    }
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: widget.progressIndicatorSize,
      height: widget.progressIndicatorSize,
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: widget.progressIndicatorColor ??
                    Theme.of(context).colorScheme.primary,
              ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
                width: widget.progressIndicatorSize,
                height: widget.progressIndicatorSize,
                child: const CircularProgressIndicator.adaptive()),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: const Color(0xffCEFE38),
      controller: _controller,
      focusNode: widget.focusNode,
      decoration: _getDecoration(),
      style: widget.style,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: _onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onFieldSubmitted: (text) {
        if (!widget.checkWhileTyping) {
          _validateText(text);
        }
        widget.onFieldSubmitted?.call(text);
      },
    );
  }

  InputDecoration _getDecoration() {
    Color borderColor;
    Widget? suffixIcon;

    switch (_validationState) {
      case ValidationState.loading:
        borderColor = Colors.grey;
        suffixIcon = _buildLoadingIndicator();
        break;
      case ValidationState.invalid:
        borderColor = Colors.red;
        suffixIcon = widget.showValidIcon
            ? const Icon(Icons.error, color: Colors.red)
            : null;
        break;
      case ValidationState.valid:
        borderColor = Colors.green;
        suffixIcon = widget.showValidIcon
            ? const Icon(Icons.check_circle, color: Colors.green)
            : null;
        break;
      case ValidationState.initial:
      default:
        borderColor = const Color(0xffCEFE38);
        suffixIcon = null;
        break;
    }

    return (widget.decoration ?? const InputDecoration()).copyWith(
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(18),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 0.8),
        borderRadius: BorderRadius.circular(18),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(18),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(18),
      ),
      suffixIcon: suffixIcon,
      errorText: _validationState == ValidationState.invalid
          ? _validationMessage
          : null,
      helperText:
          _validationState == ValidationState.valid ? _validationMessage : null,
      helperStyle: const TextStyle(color: Colors.green),
      errorStyle: const TextStyle(color: Colors.red),
    );
  }
}
