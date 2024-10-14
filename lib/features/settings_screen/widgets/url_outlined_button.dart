import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlOutlinedButton extends StatelessWidget {
  final String iconAsset;
  final String? url;

  const UrlOutlinedButton({super.key, required this.iconAsset, this.url});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 80,
      height: 35,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.6)),
        ),
        onPressed: () => _openUrl(),
        child: SvgPicture.asset(
          iconAsset,
          colorFilter: ColorFilter.mode(
            theme.primaryColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Future<void> _openUrl() async {
    final uri = Uri.parse(url ?? "");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
