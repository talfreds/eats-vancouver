import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/bouncy_button.dart';
import '../../discovery/models/restaurant.dart';
import '../../discovery/providers/discovery_provider.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.restaurantId});

  final String restaurantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(
      restaurantDetailProvider(restaurantId),
    );

    return detailAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $err')),
      ),
      data: (restaurant) {
        if (restaurant == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Not found')),
            body: const Center(child: Text('Restaurant not found 😕')),
          );
        }
        return _DetailContent(restaurant: restaurant);
      },
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.restaurant});

  final Restaurant restaurant;

  void _share(BuildContext context) {
    SharePlus.instance.share(
      ShareParams(
        text:
            'Check out ${restaurant.name} in ${restaurant.neighbourhood}, '
            'Vancouver! Rated ${restaurant.rating} ⭐️\n\n'
            '${restaurant.sentimentSummary}',
        subject: restaurant.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = restaurant;
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, r),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, r),
                  const SizedBox(height: 24),
                  _buildPhotosSection(r),
                  const SizedBox(height: 28),
                  _buildVibeCheckCard(context, r),
                  if (r.happyHour != null) ...[
                    const SizedBox(height: 24),
                    _buildHappyHourCard(context, r),
                  ],
                  if (r.deal != null) ...[
                    const SizedBox(height: 24),
                    _buildDealCard(context, r),
                  ],
                  const SizedBox(height: 36),
                  _buildActionButtons(context, r),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Restaurant r) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppTheme.cream,
      foregroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Colors.black.withAlpha(100),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: r.photoUrls.isNotEmpty
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    r.photoUrls.first.url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: AppTheme.softGrey),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(160),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Text(
                      r.name,
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            color: Colors.black.withAlpha(100),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                color: AppTheme.coral.withAlpha(30),
                child: Center(
                  child: Text(
                    r.name[0],
                    style: GoogleFonts.nunito(
                      fontSize: 80,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.coral,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Restaurant r) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                r.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${r.neighbourhood} · ${r.cuisine} · ${r.priceRange}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.mutedText,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 18,
                    color: AppTheme.sunny,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    r.rating.toStringAsFixed(1),
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _PlatformBadge(platform: r.ratingPlatform),
                ],
              ),
            ],
          ),
        ),
        if (r.isNew)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.coral,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              '✨ New',
              style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPhotosSection(Restaurant r) {
    if (r.photoUrls.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Photos',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: r.photoUrls.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) {
              final photo = r.photoUrls[i];
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.network(
                      photo.url,
                      width: 260,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 260,
                        height: 200,
                        color: AppTheme.softGrey,
                        child: const Center(child: Icon(Icons.image_rounded)),
                      ),
                    ),
                    if (photo.caption != null)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(150),
                              ],
                            ),
                          ),
                          child: Text(
                            photo.caption!,
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVibeCheckCard(BuildContext context, Restaurant r) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.coral.withAlpha(80),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('✌️', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Text(
                'Vibe Check',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'AI Summary',
                  style: GoogleFonts.nunito(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            r.sentimentSummary,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: Colors.white.withAlpha(230),
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHappyHourCard(BuildContext context, Restaurant r) {
    final hh = r.happyHour!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: cardShadow,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🍻', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Text(
                'Happy Hour',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _InfoChip(icon: Icons.calendar_today_rounded, label: hh.daysLabel),
              const SizedBox(width: 8),
              _InfoChip(icon: Icons.access_time_rounded, label: hh.timeRange),
            ],
          ),
          const SizedBox(height: 14),
          ...hh.highlights.map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppTheme.coral,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    h,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealCard(BuildContext context, Restaurant r) {
    final deal = r.deal!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: cardShadow,
        border: Border.all(color: AppTheme.teal.withAlpha(80), width: 1.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                deal.badgeEmoji ?? '🎁',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  deal.title,
                  style: GoogleFonts.nunito(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            deal.description,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: AppTheme.mutedText,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _InfoChip(
                icon: Icons.phone_iphone_rounded,
                label: deal.platform,
              ),
              if (deal.expiresLabel != null) ...[
                const SizedBox(width: 8),
                _InfoChip(
                  icon: Icons.timer_outlined,
                  label: deal.expiresLabel!,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Restaurant r) {
    return Row(
      children: [
        Expanded(
          child: BouncyButton(
            onPressed: () => _share(context),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: AppTheme.coral,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.coral.withAlpha(80),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.share_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Share',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        BouncyButton(
          onPressed: () {},
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: cardShadow,
            ),
            child: const Icon(
              Icons.map_rounded,
              color: AppTheme.teal,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Helper widgets ─────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.softGrey,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.mutedText),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformBadge extends StatelessWidget {
  const _PlatformBadge({required this.platform});

  final RatingPlatform platform;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (platform) {
      RatingPlatform.google => ('Google', const Color(0xFF4285F4)),
      RatingPlatform.yelp => ('Yelp', const Color(0xFFD32323)),
      RatingPlatform.mixed => ('Google + Yelp', AppTheme.teal),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
