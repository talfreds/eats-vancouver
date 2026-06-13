import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../models/restaurant.dart';
import '../providers/discovery_provider.dart';

class DiscoveryScreen extends ConsumerStatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  ConsumerState<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends ConsumerState<DiscoveryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  static const _tabs = [
    (tab: FeedTab.newSpots, label: 'New Spots', emoji: '✨'),
    (tab: FeedTab.happyHours, label: 'Happy Hours', emoji: '🍻'),
    (tab: FeedTab.socialDeals, label: 'Social Deals', emoji: '📱'),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _tabs.length, vsync: this);
    _tabCtrl.addListener(() {
      if (!_tabCtrl.indexIsChanging) {
        ref.read(activeFeedTabProvider.notifier).state =
            _tabs[_tabCtrl.index].tab;
      }
    });
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedAsync = ref.watch(activeFeedProvider);

    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerScrolled) => [
          _buildAppBar(context),
          _buildTabBar(context),
        ],
        body: feedAsync.when(
          loading: () => const _LoadingGrid(),
          error: (err, _) => _ErrorView(message: err.toString()),
          data: (items) => _FeedGrid(items: items),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: AppTheme.cream,
      elevation: 0,
      scrolledUnderElevation: 2,
      shadowColor: AppTheme.coral.withAlpha(30),
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
        title: Row(
          children: [
            Text(
              '🍜',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(width: 8),
            Text(
              'Eats Vancouver',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppTheme.charcoal,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded),
          color: AppTheme.charcoal,
          onPressed: () {},
          tooltip: 'Search',
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TabBarDelegate(
        TabBar(
          controller: _tabCtrl,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          tabs: _tabs
              .map(
                (t) => Tab(
                  child: Row(
                    children: [
                      Text(t.emoji, style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(t.label),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// ── Tab bar delegate ──────────────────────────────────────────────────────

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  _TabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 60;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppTheme.cream,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) =>
      tabBar != oldDelegate.tabBar;
}

// ── Feed Grid ─────────────────────────────────────────────────────────────

class _FeedGrid extends StatelessWidget {
  const _FeedGrid({required this.items});

  final List<Restaurant> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text('Nothing here yet – check back soon! 🍽️'),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossCount = width > 900
            ? 3
            : width > 600
                ? 2
                : 1;

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: crossCount == 1 ? 1.6 : 0.82,
          ),
          itemCount: items.length,
          itemBuilder: (context, i) => _RestaurantCard(restaurant: items[i]),
        );
      },
    );
  }
}

// ── Restaurant Card ────────────────────────────────────────────────────────

class _RestaurantCard extends StatefulWidget {
  const _RestaurantCard({required this.restaurant});

  final Restaurant restaurant;

  @override
  State<_RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<_RestaurantCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.93,
      upperBound: 1.0,
      value: 1.0,
    );
    _scale = _ctrl;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onSaveTap() {
    setState(() => _saved = !_saved);
    _ctrl.reverse().then((_) => _ctrl.forward());
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.restaurant;
    final photo = r.photoUrls.isNotEmpty ? r.photoUrls.first.url : null;

    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTap: () => context.push('/restaurant/${r.id}'),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: cardShadow,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    photo != null
                        ? Image.network(
                            photo,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _PlaceholderImage(name: r.name),
                          )
                        : _PlaceholderImage(name: r.name),

                    // Gradient overlay
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(120),
                            ],
                            stops: const [0.55, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Badges
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Wrap(
                        spacing: 6,
                        children: [
                          if (r.isNew) _Badge(label: '✨ New', coral: true),
                          if (r.happyHour != null)
                            _Badge(label: '🍻 HH', coral: false),
                          if (r.deal != null)
                            _Badge(label: '${r.deal!.badgeEmoji ?? '🎁'} Deal',
                                coral: false),
                        ],
                      ),
                    ),

                    // Save button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: _onSaveTap,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _saved
                                ? AppTheme.coral
                                : Colors.white.withAlpha(220),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                            size: 18,
                            color: _saved ? Colors.white : AppTheme.charcoal,
                          ),
                        ),
                      ),
                    ),

                    // Bottom text overlay
                    Positioned(
                      left: 14,
                      right: 14,
                      bottom: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.name,
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${r.neighbourhood} · ${r.cuisine}',
                            style: GoogleFonts.nunito(
                              color: Colors.white.withAlpha(210),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Info bar
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 15,
                                  color: AppTheme.sunny,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  r.rating.toStringAsFixed(1),
                                  style: GoogleFonts.nunito(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.charcoal,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                _PlatformDot(platform: r.ratingPlatform),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              r.priceRange,
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                color: AppTheme.mutedText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppTheme.mutedText,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.coral});

  final String label;
  final bool coral;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: coral ? AppTheme.coral : Colors.white.withAlpha(220),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: coral ? Colors.white : AppTheme.charcoal,
        ),
      ),
    );
  }
}

class _PlatformDot extends StatelessWidget {
  const _PlatformDot({required this.platform});

  final RatingPlatform platform;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (platform) {
      RatingPlatform.google => ('G', const Color(0xFF4285F4)),
      RatingPlatform.yelp => ('Y', const Color(0xFFD32323)),
      RatingPlatform.mixed => ('M', AppTheme.teal),
    };
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  const _PlaceholderImage({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.softGrey,
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: GoogleFonts.nunito(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: AppTheme.coral,
          ),
        ),
      ),
    );
  }
}

// ── Loading & Error states ─────────────────────────────────────────────────

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth > 600 ? 2 : 1;
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: crossCount == 1 ? 1.6 : 0.82,
          ),
          itemCount: 4,
          itemBuilder: (_, __) => const _SkeletonCard(),
        );
      },
    );
  }
}

class _SkeletonCard extends StatefulWidget {
  const _SkeletonCard();

  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final opacity = 0.4 + _ctrl.value * 0.35;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppTheme.softGrey.withAlpha((opacity * 255).toInt()),
          ),
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('😕', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
