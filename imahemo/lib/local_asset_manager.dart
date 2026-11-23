import 'package:flutter/material.dart';

import 'app_theme.dart';

class LocalAssetManagerPage extends StatefulWidget {
  const LocalAssetManagerPage({super.key});

  @override
  State<LocalAssetManagerPage> createState() => _LocalAssetManagerPageState();
}

class _LocalAssetManagerPageState extends State<LocalAssetManagerPage> {
  final List<Map<String, dynamic>> _assets = [
    {
      'name': 'Aether Quest',
      'status': 'Download',
      'downloaded': false,
    },
    {
      'name': 'Shadow Chaser',
      'status': 'Download',
      'downloaded': false,
    },
    {
      'name': 'Mystic Realms',
      'status': 'Download',
      'downloaded': false,
    },
    {
      'name': 'Crystal Odyssey',
      'status': 'Download',
      'downloaded': false,
    },
  ];

  void _downloadAsset(int index) {
    setState(() {
      _assets[index]['downloaded'] = !_assets[index]['downloaded'];

      _assets[index]['status'] = _assets[index]['downloaded']
          ? 'Available Offline'
          : 'Download';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _assets[index]['downloaded']
              ? '${_assets[index]['name']} marked as downloaded.'
              : '${_assets[index]['name']} removed from downloads.',
        ),
        backgroundColor: context.palette.surface,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteAsset(int index) async {
    final palette = context.palette;
    final assetName = _assets[index]['name'];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: palette.surface,
        title: Text(
          'Delete Asset?',
          style: TextStyle(color: palette.textPrimary),
        ),
        content: Text(
          'Are you sure you want to remove $assetName?',
          style: TextStyle(color: palette.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete', style: TextStyle(color: palette.danger)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() {
        _assets.removeAt(index);
      });
    }
  }

  void _showLearnMore() {
    final palette = context.palette;
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Community Expansion Packs',
              style: TextStyle(
                color: palette.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Discover additional community-created content '
              'and expansion packs for your application.',
              style: TextStyle(
                color: palette.textMuted,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 8),
              child: IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: palette.textMuted,
                  size: 23,
                ),
              ),
            ),

            // Page Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page Title
                    Text(
                      'Local Asset Manager',
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Community Expansion Card
                    _buildCommunityCard(palette),

                    const SizedBox(height: 25),

                    // Offline Warning
                    _buildOfflineWarning(palette),

                    const SizedBox(height: 26),

                    // Asset Management Heading
                    Text(
                      'Asset Management',
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Asset List
                    if (_assets.isEmpty)
                      _buildEmptyState(palette)
                    else
                      ...List.generate(
                        _assets.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 11),
                          child: _buildAssetCard(palette, index),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Community Expansion Card
  Widget _buildCommunityCard(AppPalette palette) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 17),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Community Expansion Packs',
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: palette.textMuted,
                size: 23,
              ),
            ],
          ),

          const SizedBox(height: 7),

          Text(
            'Community expansion packs and '
            'community expansion packs.',
            style: TextStyle(
              color: palette.textMuted,
              fontSize: 15,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 17),

          GestureDetector(
            onTap: _showLearnMore,
            child: Text(
              'Learn More',
              style: TextStyle(
                color: palette.accent,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Offline Warning Panel
  Widget _buildOfflineWarning(AppPalette palette) {
    final isLight = palette.isLight;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      decoration: BoxDecoration(
        color: isLight ? const Color(0xFFFBE7E8) : const Color(0xFF342328),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isLight ? const Color(0xFFE3A7AB) : const Color(0xFF98565B),
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: palette.danger, size: 27),

          const SizedBox(width: 19),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Device Connection Offline - '
                  'Showing Stored Data',
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Showing assets · showing stored data',
                  style: TextStyle(
                    color: isLight
                        ? const Color(0xFF9A5A5F)
                        : const Color(0xFFB7A0A5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Individual Asset Card
  Widget _buildAssetCard(AppPalette palette, int index) {
    final asset = _assets[index];
    final isDownloaded = asset['downloaded'] as bool;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          // File Icon Container
          Container(
            width: 60,
            height: 64,
            decoration: BoxDecoration(
              color: palette.surfaceVariant,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              Icons.insert_drive_file_outlined,
              color: palette.textMuted,
              size: 23,
            ),
          ),

          const SizedBox(width: 15),

          // Asset Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  asset['status'],
                  style: TextStyle(
                    color: palette.textMuted,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Download Button
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () => _downloadAsset(index),
            icon: Icon(
              isDownloaded
                  ? Icons.check_circle_outline
                  : Icons.download_outlined,
              color: palette.accent,
              size: 23,
            ),
          ),

          // Delete Button
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () => _deleteAsset(index),
            icon: Icon(
              Icons.delete_outline,
              color: palette.danger,
              size: 23,
            ),
          ),
        ],
      ),
    );
  }

  // Empty State
  Widget _buildEmptyState(AppPalette palette) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          Icon(
            Icons.folder_open_outlined,
            color: palette.textMuted,
            size: 35,
          ),
          const SizedBox(height: 12),
          Text(
            'No local assets available',
            style: TextStyle(color: palette.textPrimary, fontSize: 15),
          ),
          const SizedBox(height: 5),
          Text(
            'Your downloaded assets will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.textMuted, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
