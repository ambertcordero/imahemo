import 'package:flutter/material.dart';

import 'app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBanner = 0;

  final PageController _bannerController = PageController(
    viewportFraction: 0.94,
  );

  final List<_BannerData> _banners = const [
    _BannerData(
      title: 'Transform Scripts\ninto Panels Locally',
      description:
          'Transform Scripts into Panels Locally\nnow to limitless chances.',
      colors: [Color(0xFF8650D3), Color(0xFF4C9EE6), Color(0xFF22CAD1)],
    ),
    _BannerData(
      title: 'Shape Every Scene\nYour Way',
      description:
          'Build, arrange, and preview your story\nwithout leaving your device.',
      colors: [Color(0xFFFB9D76), Color(0xFFE6638A), Color(0xFF874DD6)],
    ),
    _BannerData(
      title: 'Create Faster\nStay in Flow',
      description:
          'Keep your ideas moving with a private,\nlocal-first creative workspace.',
      colors: [Color(0xFF0D766E), Color(0xFF28B57E), Color(0xFFB3D75E)],
    ),
  ];

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    final palette = context.palette;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(color: palette.textPrimary)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: palette.surfaceVariant,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: palette.border),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Scaffold(
      backgroundColor: palette.background,
      appBar: _buildHeader(palette),
      body: _buildHome(palette),
    );
  }

  PreferredSizeWidget _buildHeader(AppPalette palette) {
    final isLight = palette.isLight;

    return AppBar(
      toolbarHeight: 62,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: palette.background,
      titleSpacing: 15,
      title: Text(
        'IMAHEMO',
        style: TextStyle(
          color: palette.accent,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            context.themeController.toggle();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 68,
            height: 34,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isLight ? palette.surface : const Color(0xFF173345),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: palette.border),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(
                      Icons.light_mode_outlined,
                      size: 18,
                      color: palette.textMuted,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.dark_mode_outlined,
                      size: 18,
                      color: Color(0xFF0B101A),
                    ),
                  ),
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 180),
                  alignment: isLight
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: Color(0xFF37D2E7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isLight ? Icons.light_mode : Icons.dark_mode,
                      size: 18,
                      color: const Color(0xFF0B101A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        IconButton(
          onPressed: () {
            _showMessage('You’re all caught up');
          },
          icon: const Icon(Icons.notifications_none_rounded),
          iconSize: 28,
          color: palette.textMuted,
          tooltip: 'Notifications',
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget _buildHome(AppPalette palette) {
    return SingleChildScrollView(
      key: const ValueKey('home'),
      padding: const EdgeInsets.only(bottom: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEngineStatus(palette),
          const SizedBox(height: 20),
          _buildBannerCarousel(palette),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Recent Creation Sessions',
                    style: TextStyle(
                      color: palette.textPrimary,
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showMessage('Opening recent sessions');
                  },
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.chevron_right),
                  color: palette.textMuted,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _buildProjects(palette),
        ],
      ),
    );
  }

  Widget _buildEngineStatus(AppPalette palette) {
    final isLight = palette.isLight;

    return Container(
      height: 39,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(left: 29, right: 13),
      decoration: BoxDecoration(
        color: isLight ? const Color(0xFFD9F0F4) : const Color(0xFF123C47),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              color: Color(0xFF28D6ED),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              'Local Engine Status',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isLight
                    ? const Color(0xFF0C5560)
                    : const Color(0xFFBCEAF1),
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Container(
            height: 29,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isLight
                  ? const Color(0xFFBFE6EC)
                  : const Color(0xFF164650),
              border: Border.all(
                color: isLight
                    ? const Color(0xFF6FC4D0)
                    : const Color(0xFF48A2AD),
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'Active',
              style: TextStyle(
                color: isLight
                    ? const Color(0xFF0A6C78)
                    : const Color(0xFF65D9E8),
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel(AppPalette palette) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final isLight = palette.isLight;

    return Column(
      children: [
        SizedBox(
          height: 205 * textScale,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: _banners.length,
            onPageChanged: (index) {
              setState(() {
                _selectedBanner = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = _banners[index];

              return Container(
                margin: EdgeInsets.only(left: index == 0 ? 16 : 6, right: 6),
                padding: const EdgeInsets.fromLTRB(19, 18, 19, 17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: banner.colors,
                    stops: const [0.12, 0.46, 0.82],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      banner.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      banner.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFFE3E9FF),
                        fontSize: 15,
                        height: 1.2,
                      ),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: () {
                        _showMessage(
                          'Local-first creation keeps your work private and fast',
                        );
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(132, 39),
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        backgroundColor: const Color(0xFF142533),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      child: const Text('Learn More'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (index) {
            return GestureDetector(
              onTap: () {
                _bannerController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 12,
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 3.5),
                decoration: BoxDecoration(
                  color: _selectedBanner == index
                      ? (isLight ? palette.accent : const Color(0xFFF9FCFF))
                      : (isLight ? const Color(0xFFB9C6D0) : const Color(0xFF384254)),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildProjects(AppPalette palette) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    const projects = [
      _ProjectData(
        name: 'Project 1',
        background: Color(0xFF143B4D),
        border: Color(0xFF1D4C5C),
        accent: Color(0xFF32CCE7),
      ),
      _ProjectData(
        name: 'Project 2',
        background: Color(0xFF794511),
        border: Color(0xFF935A23),
        accent: Color(0xFFE9A933),
      ),
      _ProjectData(
        name: 'Project 3',
        background: Color(0xFF16603D),
        border: Color(0xFF1E7450),
        accent: Color(0xFF43D58B),
      ),
    ];

    return SizedBox(
      height: 260 * textScale,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        separatorBuilder: (_, _) {
          return const SizedBox(width: 18);
        },
        itemBuilder: (context, index) {
          final project = projects[index];

          return InkWell(
            onTap: () {
              _showMessage('Opening ${project.name}');
            },
            borderRadius: BorderRadius.circular(13),
            child: SizedBox(
              width: 152,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 152,
                    height: 180,
                    decoration: BoxDecoration(
                      color: project.background,
                      border: Border.all(color: project.border),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      Icons.folder_outlined,
                      size: 40,
                      color: project.accent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project.name,
                    style: TextStyle(
                      color: palette.textPrimary,
                      fontSize: 19,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Project',
                    style: TextStyle(
                      color: palette.textMuted,
                      fontSize: 14,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BannerData {
  const _BannerData({
    required this.title,
    required this.description,
    required this.colors,
  });

  final String title;
  final String description;
  final List<Color> colors;
}

class _ProjectData {
  const _ProjectData({
    required this.name,
    required this.background,
    required this.border,
    required this.accent,
  });

  final String name;
  final Color background;
  final Color border;
  final Color accent;
}
