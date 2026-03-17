import 'package:flutter/material.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../auth/presentation/screens/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushEnabled = true;
  bool _soundEnabled = true;
  bool _autoUpload = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionHeader(title: l10n.notificationsSection),
          const SizedBox(height: 12),
          _SwitchTile(
            title: l10n.notificationToggle,
            subtitle: l10n.notificationSubtitle,
            value: _pushEnabled,
            onChanged: (value) => setState(() => _pushEnabled = value),
          ),
          const SizedBox(height: 12),
          _SwitchTile(
            title: l10n.soundToggle,
            subtitle: l10n.soundSubtitle,
            value: _soundEnabled,
            onChanged: (value) => setState(() => _soundEnabled = value),
          ),
          const SizedBox(height: 24),
          _SectionHeader(title: l10n.dataSection),
          const SizedBox(height: 12),
          _SwitchTile(
            title: l10n.autoUploadToggle,
            subtitle: l10n.autoUploadSubtitle,
            value: _autoUpload,
            onChanged: (value) => setState(() => _autoUpload = value),
          ),
          const SizedBox(height: 24),
          _SectionHeader(title: l10n.accountSection),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE7ECFF),
                child: Icon(Icons.person_outline, color: Color(0xFF2B59FF)),
              ),
              title: const Text('Nguyễn Minh Anh'),
              subtitle: const Text('minhanh@company.vn'),
              trailing: TextButton(
                onPressed: () {},
                child: Text(l10n.editProfile),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: Text(l10n.signOut),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: const Color(0xFF5B6788),
            letterSpacing: 1.4,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Switch.adaptive(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
