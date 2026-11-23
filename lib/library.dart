import 'package:flutter/material.dart';

import 'app_theme.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final List<Map<String, dynamic>> books = [
    {
      'title': 'Aether Quest',
      'chapters': '5 of 12 chapters compiled',
      'progress': 5 / 12,
      'storage': '330 MiB',
      'image': 'assets/aether1.jpg',
    },
    {
      'title': 'Shadow Chaser',
      'chapters': '5 of 79 chapters compiled',
      'progress': 5 / 12,
      'storage': '220 MiB',
      'image': 'assets/shadow1.jpg',
    },
    {
      'title': 'Aether Quest',
      'chapters': '5 of 12 chapters compiled',
      'progress': 5 / 12,
      'storage': '335 MiB',
      'image': 'assets/aether2.jpg',
    },
    {
      'title': 'Shadow Chaser',
      'chapters': '5 of 79 chapters compiled',
      'progress': 5 / 12,
      'storage': '220 MiB',
      'image': 'assets/shadow2.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top toolbar
            _buildToolbar(palette),

            // Page title
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 25, 17, 17),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Offline Book Catalog',
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),

            // Book list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(17, 0, 17, 12),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return _buildBookCard(palette, books[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TOP TOOLBAR
  Widget _buildToolbar(AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 12, 22, 0),
      child: SizedBox(
        height: 39,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu, color: palette.textMuted, size: 25),
            Row(
              children: [
                Icon(Icons.search, color: palette.textMuted, size: 25),
                const SizedBox(width: 23),
                Icon(
                  Icons.view_column_outlined,
                  color: palette.textMuted,
                  size: 26,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // BOOK CARD
  Widget _buildBookCard(AppPalette palette, Map<String, dynamic> book) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book cover
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              book['image'],
              width: 89,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildCoverPlaceholder(book['title']);
              },
            ),
          ),

          const SizedBox(width: 16),

          // Book information
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and menu
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        book['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: palette.textPrimary,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showBookMenu(palette, book['title']);
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: palette.textMuted,
                        size: 23,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // Chapter information
                Text(
                  book['chapters'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: palette.textMuted, fontSize: 13),
                ),

                const SizedBox(height: 9),

                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: book['progress'],
                    minHeight: 6,
                    backgroundColor: palette.border,
                    valueColor: AlwaysStoppedAnimation<Color>(palette.accent),
                  ),
                ),

                const SizedBox(height: 11),

                // Compiled chapters
                Text(
                  '5 of 12 chapters compiled',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: palette.textSecondary, fontSize: 14),
                ),

                const SizedBox(height: 13),

                // Storage specification
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Storage Spec:  ',
                        style: TextStyle(color: palette.textMuted, fontSize: 14),
                      ),
                      TextSpan(
                        text: book['storage'],
                        style: TextStyle(
                          color: palette.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PLACEHOLDER FOR MISSING BOOK COVER
  Widget _buildCoverPlaceholder(String title) {
    return Container(
      width: 89,
      height: 130,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF172D45), Color(0xFF47677C), Color(0xFF101725)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Icon(Icons.auto_stories, color: Colors.white70, size: 36),
    );
  }

  // THREE DOT MENU
  void _showBookMenu(AppPalette palette, String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: palette.textPrimary,
                  ),
                  title: Text(
                    'Book Information',
                    style: TextStyle(color: palette.textPrimary),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete_outline,
                    color: palette.danger,
                  ),
                  title: Text(
                    'Remove Download',
                    style: TextStyle(color: palette.textPrimary),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
