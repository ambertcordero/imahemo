import 'package:flutter/material.dart';

import 'app_theme.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController promptController = TextEditingController();

  int selectedStyle = -1;

  final List<Map<String, String>> artStyles = [
    {
      'name': 'Manga',
      'image': 'assets/manga.jpg',
    },
    {
      'name': 'Western',
      'image': 'assets/western.jpg',
    },
    {
      'name': 'Anime',
      'image': 'assets/anime.jpg',
    },
    {
      'name': 'Fantasy',
      'image': 'assets/fantasy.jpg',
    },
  ];

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BACK BUTTON
                    GestureDetector(
                      onTap: () {
                        Navigator.maybePop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: palette.textMuted,
                        size: 25,
                      ),
                    ),

                    const SizedBox(height: 35),

                    // PAGE TITLE
                    Text(
                      'AI Generation Workspace',
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4,
                      ),
                    ),

                    const SizedBox(height: 17),

                    // PROMPT INPUT
                    Container(
                      height: 138,
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: palette.border, width: 1),
                      ),
                      child: Stack(
                        children: [
                          TextField(
                            controller: promptController,
                            maxLength: 90,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            style: TextStyle(
                              color: palette.textPrimary,
                              fontSize: 17,
                            ),
                            cursorColor: palette.accent,
                            decoration: InputDecoration(
                              hintText:
                                  'Text prompt to create recreation\n'
                                  'your comic name.',
                              hintStyle: TextStyle(
                                color: palette.textMuted,
                                fontSize: 17,
                                height: 1.3,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.fromLTRB(
                                15,
                                17,
                                15,
                                30,
                              ),
                              counterText: '',
                            ),
                          ),

                          // CHARACTER COUNTER
                          Positioned(
                            bottom: 9,
                            right: 16,
                            child: ValueListenableBuilder<TextEditingValue>(
                              valueListenable: promptController,
                              builder: (context, value, child) {
                                return Text(
                                  '${value.text.length}/90',
                                  style: TextStyle(
                                    color: palette.textMuted,
                                    fontSize: 13,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    // ART STYLE TITLE
                    Text(
                      'Art Style',
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ART STYLE GRID
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: artStyles.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 13,
                            childAspectRatio: 1.08,
                          ),
                      itemBuilder: (context, index) {
                        return _buildArtStyle(palette, index);
                      },
                    ),

                    const SizedBox(height: 16),

                    // GENERATE BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _generateComic,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: palette.accent,
                          foregroundColor: const Color(0xFF07131D),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        child: const Text(
                          'GENERATE COMIC',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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

  // ART STYLE CARD
  Widget _buildArtStyle(AppPalette palette, int index) {
    final bool isSelected = selectedStyle == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStyle = index;
        });
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: isSelected ? palette.accent : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.asset(
                  artStyles[index]['image']!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: palette.surfaceVariant,
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: palette.textMuted,
                          size: 35,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            artStyles[index]['name']!,
            style: TextStyle(
              color: isSelected ? palette.accent : palette.textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // GENERATE COMIC ACTION
  void _generateComic() {
    if (promptController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a comic prompt.')),
      );
      return;
    }

    if (selectedStyle == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an art style.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Generating ${artStyles[selectedStyle]['name']} comic...',
        ),
      ),
    );

    // Connect your AI comic generation API here.
  }
}
