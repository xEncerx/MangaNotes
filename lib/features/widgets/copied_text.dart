import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopiedText extends StatefulWidget {
  final String text;
  final String? copyText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextStyle? style;
  final double iconSize;

  const CopiedText({
    super.key,
    required this.text,
    required this.copyText,
    this.iconSize = 16,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<CopiedText> createState() => _CopiedTextState();
}

class _CopiedTextState extends State<CopiedText> {
  bool _isCopied = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _copyText(),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.prefixIcon != null) ...[
              _HintIcon(
                _isCopied ? Icons.check : widget.prefixIcon!,
                widget.iconSize,
              ),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Transform.translate(
                offset: const Offset(0, -2),
                child: Text(
                  widget.text,
                  style: widget.style ??
                      theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            if (widget.suffixIcon != null) ...[
              const SizedBox(width: 10),
              _HintIcon(
                _isCopied ? Icons.check : widget.suffixIcon!,
                widget.iconSize,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _copyText() async {
    setState(() => _isCopied = true);
    if (widget.copyText != null) {
      await Clipboard.setData(ClipboardData(text: widget.copyText!));
    }
    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() => _isCopied = false),
    );
  }
}

class _HintIcon extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  const _HintIcon(this.icon, this.iconSize);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Icon(
      icon,
      color: theme.hintColor,
      size: iconSize,
    );
  }
}
