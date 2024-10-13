import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/api/api.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/repositories/repositories.dart';
import 'package:manga_notes/ui/const.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadingMenu extends StatefulWidget {
  final MangaData mangaData;
  const ReadingMenu({super.key, required this.mangaData});

  @override
  State<ReadingMenu> createState() => _ReadingMenuState();
}

class _ReadingMenuState extends State<ReadingMenu> {
  final _controller = TextEditingController();
  late String mangaUrl;
  bool _isSettingsOpen = false;

  @override
  void initState() {
    mangaUrl = widget.mangaData.clientUrl ?? "???";
    _controller.text = mangaUrl;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isSettingsOpen
        ? _ReadingSettings(
            updateUrl: _updateUrl,
            closeSettings: _closeSettings,
            controller: _controller,
          )
        : _ReadingButton(
            openUrl: _openUrl,
            openSettings: _openSettings,
          );
  }

  void _openSettings() {
    if (widget.mangaData.section == MangaNotesConst.notReadSection) {
      showInfoSnackBar(
        context: context,
        text: "Сначала добавь мангу в один из разделов!",
      );
      return;
    }
    setState(() {
      _isSettingsOpen = true;
      _controller.text = mangaUrl;
    });
  }

  void _closeSettings() => setState(() => _isSettingsOpen = false);

  Future<void> _updateUrl() async {
    if (_controller.text.isNotEmpty) {
      await GetIt.I<DataBase>().updateMangaData(
        uuid: widget.mangaData.uuid,
        column: "clientUrl",
        data: _controller.text,
      );
      if (mounted) {
        showInfoSnackBar(
          context: context,
          text: "Ссылка была успешно обновлена!",
        );
        BlocProvider.of<MangaListBloc>(context).add(LoadMangaListEvent());
      }
    }
    _closeSettings();
  }

  Future<void> _openUrl() async {
    final uri = Uri.parse(mangaUrl);
    if (await canLaunchUrl(uri)) {
      // TODO: launch url in system browser
      await launchUrl(uri);
    }
  }
}

class _ReadingButton extends StatelessWidget {
  final VoidCallback openUrl;
  final VoidCallback openSettings;

  const _ReadingButton({required this.openUrl, required this.openSettings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: theme.primaryColor.withOpacity(0.9),
                overlayColor: Colors.orange,
              ),
              onPressed: () => openUrl.call(),
              child: Text("Читать", style: theme.textTheme.titleMedium),
            ),
          ),
        ),
        const SizedBox(width: 10),
        _IconButton(
          icon: Icons.settings_outlined,
          onTap: () => openSettings.call(),
        ),
      ],
    );
  }
}

class _ReadingSettings extends StatelessWidget {
  final VoidCallback updateUrl;
  final VoidCallback closeSettings;
  final TextEditingController controller;

  const _ReadingSettings({
    required this.updateUrl,
    required this.closeSettings,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              fillColor: theme.hintColor.withOpacity(0.2),
              filled: true,
            ),
          ),
        ),
        const SizedBox(width: 10),
        _IconButton(icon: Icons.check, onTap: () => updateUrl.call()),
        const SizedBox(width: 5),
        _IconButton(icon: Icons.close, onTap: () => closeSettings.call()),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onTap.call(),
      icon: Icon(
        icon,
        size: 30,
      ),
    );
  }
}
