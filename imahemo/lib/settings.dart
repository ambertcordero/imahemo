import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'local_asset_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool lowMemoryMode = false;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SETTINGS HEADER
                    Center(
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          color: palette.textPrimary,
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // HARDWARE DIAGNOSTICS TITLE
                    Text(
                      'Hardware Diagnostics',
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4,
                      ),
                    ),

                    const SizedBox(height: 17),

                    // HARDWARE DIAGNOSTICS CARD
                    _buildHardwareCard(palette),

                    const SizedBox(height: 15),

                    // LOCAL ASSET MANAGER
                    _buildAssetManagerCard(palette),

                    const SizedBox(height: 15),

                    // LOW MEMORY MODE CARD
                    _buildMemoryModeCard(palette),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HARDWARE DIAGNOSTICS CARD
  Widget _buildHardwareCard(AppPalette palette) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HARDWARE INFORMATION
          _buildInfoRow(palette, 'Hardware', '32GB'),
          _buildDivider(palette),

          _buildInfoRow(palette, 'Memory Usage', '5.20B'),
          _buildDivider(palette),

          _buildInfoRow(palette, 'Memory Ratio', '4.2GB'),
          _buildDivider(palette),

          _buildInfoRow(palette, 'Critical Rating Interment', '2.1GB'),

          const SizedBox(height: 19),

          // STORAGE USAGE TITLE
          Text(
            'Storage Usage',
            style: TextStyle(
              color: palette.textPrimary,
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 16),

          // STORAGE BAR
          _buildStorageBar(palette),

          const SizedBox(height: 21),

          // STORAGE LEGEND
          _buildLegend(
            palette,
            color: palette.accent,
            title: 'Local Model Weights',
            value: '6.2GB',
          ),

          const SizedBox(height: 7),

          _buildLegend(
            palette,
            color: const Color(0xFFF5A34D),
            title: 'Local Model Weights',
          ),

          const SizedBox(height: 26),

          _buildLegend(
            palette,
            color: const Color(0xFFA58AD9),
            title: 'Generated Asset Cache',
            value: '2.1GB',
          ),
        ],
      ),
    );
  }

  // HARDWARE INFORMATION ROW
  Widget _buildInfoRow(AppPalette palette, String title, String value) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: palette.textSecondary, fontSize: 16),
            ),
          ),
          Text(
            value,
            style: TextStyle(color: palette.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ROW DIVIDER
  Widget _buildDivider(AppPalette palette) {
    return Divider(height: 1, thickness: 0.5, color: palette.border);
  }

  // STORAGE BAR
  Widget _buildStorageBar(AppPalette palette) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Expanded(flex: 65, child: Container(color: palette.accent)),
            Expanded(
              flex: 18,
              child: Container(color: const Color(0xFFF5A34D)),
            ),
            Expanded(
              flex: 11,
              child: Container(color: const Color(0xFFA58AD9)),
            ),
            Expanded(
              flex: 4,
              child: Container(color: palette.border),
            ),
          ],
        ),
      ),
    );
  }

  // STORAGE LEGEND ITEM
  Widget _buildLegend(
    AppPalette palette, {
    required Color color,
    required String title,
    String? value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 4),
          color: color,
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: palette.textSecondary, fontSize: 16),
              ),

              if (value != null)
                Text(
                  value,
                  style: TextStyle(color: palette.textSecondary, fontSize: 16),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // LOCAL ASSET MANAGER CARD
  Widget _buildAssetManagerCard(AppPalette palette) {
    return Material(
      color: palette.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const LocalAssetManagerPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
          child: Row(
            children: [
              Icon(Icons.folder_outlined, color: palette.accent, size: 24),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Local Asset Manager',
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage downloaded models and assets',
                      style: TextStyle(color: palette.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),

              Icon(Icons.chevron_right, color: palette.textMuted, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  // LOW MEMORY MODE CARD
  Widget _buildMemoryModeCard(AppPalette palette) {
    final isLight = palette.isLight;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Low-Memory Footprint Mode',
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Low-Memory Footprint Mode to\n'
                  'memory topic changes.',
                  style: TextStyle(
                    color: palette.textMuted,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // TOGGLE SWITCH
          Switch(
            value: lowMemoryMode,
            onChanged: (value) {
              setState(() {
                lowMemoryMode = value;
              });
            },
            activeThumbColor: palette.accent,
            activeTrackColor: isLight
                ? const Color(0xFF9AD9E3)
                : const Color(0xFF236B79),
            inactiveThumbColor: isLight
                ? const Color(0xFFFFFFFF)
                : const Color(0xFFEAF0F5),
            inactiveTrackColor: isLight
                ? const Color(0xFFC9D6DE)
                : const Color(0xFF384657),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }
}
