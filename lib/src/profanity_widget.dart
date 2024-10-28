import 'package:ai_profanity_textfield/profanity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ProfanityTextField extends StatefulWidget {
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
  final Function(String)? onSubmitted;
  final InputDecoration? profanityDecoration;
  final bool clearOnProfanity;
  final Color? progressIndicatorColor;
  final double progressIndicatorSize;

  const ProfanityTextField({
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
    this.onSubmitted,
    this.profanityDecoration,
    this.clearOnProfanity = false,
    this.progressIndicatorColor,
    this.progressIndicatorSize = 20,
  });

  @override
  State<ProfanityTextField> createState() => _ProfanityTextFieldState();
}

class _ProfanityTextFieldState extends State<ProfanityTextField> {
  late TextEditingController _controller;
  Timer? _debounceTimer;
  bool _isChecking = false;
  bool _hasProfanity = false;
  String? _lastCheckedText;

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

  Future<void> _checkProfanity(String text) async {
    // Return early if text is empty or same as last checked
    if (text.isEmpty) {
      setState(() {
        _hasProfanity = false;
        _isChecking = false;
      });
      return;
    }

    if (text == _lastCheckedText) return;

    try {
      setState(() {
        _isChecking = true;
        _lastCheckedText = text;
      });

      final hasProfanity = await widget.geminiService.checkProfanity(text);

      // Only update state if the text hasn't changed while checking
      if (mounted && text == _controller.text) {
        setState(() {
          _hasProfanity = hasProfanity;
          _isChecking = false;
        });

        if (hasProfanity) {
          widget.onProfanityDetected?.call(text);
          if (widget.clearOnProfanity) {
            _controller.clear();
            setState(() {
              _hasProfanity = false;
            });
          }
        } else {
          widget.onCleanText?.call(text);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isChecking = false);
        widget.onError?.call(e.toString());
      }
    }
  }

  void _onChanged(String text) {
    // Reset profanity state on any text change
    setState(() {
      _hasProfanity = false;
      if (text.isEmpty) {
        _isChecking = false;
        _lastCheckedText = null;
      }
    });

    if (!widget.checkWhileTyping) return;

    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      _checkProfanity(text);
    });
  }

  void _onSubmitted(String text) {
    if (!widget.checkWhileTyping) {
      _checkProfanity(text);
    }
    widget.onSubmitted?.call(text);
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
            child: AdaptiveProgressIndicator(
              size: widget.progressIndicatorSize,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: widget.focusNode,
      decoration: _hasProfanity
          ? (widget.profanityDecoration ??
              const InputDecoration(
                  errorText: 'Inappropriate content detected',
                  errorStyle: TextStyle(color: Colors.red)))
          : widget.decoration?.copyWith(
              suffixIcon: _isChecking ? _buildLoadingIndicator() : null,
            ),
      style: widget.style,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: _onChanged,
      onSubmitted: _onSubmitted,
    );
  }
}

class AdaptiveProgressIndicator extends StatelessWidget {
  final double size;
  final Color? color;

  const AdaptiveProgressIndicator({
    super.key,
    this.size = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
      return CupertinoActivityIndicator(
        radius: size / 2,
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor:
            color != null ? AlwaysStoppedAnimation<Color>(color!) : null,
      ),
    );
  }
}
