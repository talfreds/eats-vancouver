import 'package:flutter/foundation.dart';

/// Rating source for a restaurant listing.
enum RatingPlatform { yelp, google, mixed }

/// A single photo entry (URL + optional caption).
@immutable
class PhotoEntry {
  const PhotoEntry({required this.url, this.caption});

  final String url;
  final String? caption;
}

/// Core restaurant / venue data model.
@immutable
class Restaurant {
  const Restaurant({
    required this.id,
    required this.name,
    required this.neighbourhood,
    required this.address,
    required this.cuisine,
    required this.priceRange,
    required this.rating,
    required this.ratingPlatform,
    required this.sentimentSummary,
    required this.photoUrls,
    this.happyHour,
    this.deal,
    this.isNew = false,
    this.tags = const [],
    this.latitude,
    this.longitude,
  });

  final String id;
  final String name;
  final String neighbourhood;
  final String address;
  final String cuisine;

  /// Price range as dollar signs, e.g. '\$\$'.
  final String priceRange;

  /// Aggregate rating (0–5).
  final double rating;

  /// Indicates which platform the rating data leans on.
  final RatingPlatform ratingPlatform;

  /// Short aggregated sentiment text from reviews.
  final String sentimentSummary;

  /// Photos pulled from reviews / social media.
  final List<PhotoEntry> photoUrls;

  final HappyHour? happyHour;
  final SocialDeal? deal;

  final bool isNew;
  final List<String> tags;

  final double? latitude;
  final double? longitude;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Restaurant && other.id == id);

  @override
  int get hashCode => id.hashCode;
}

/// Happy hour details.
@immutable
class HappyHour {
  const HappyHour({
    required this.daysLabel,
    required this.timeRange,
    required this.highlights,
  });

  final String daysLabel;
  final String timeRange;
  final List<String> highlights;
}

/// A social-media–style deal or promotion.
@immutable
class SocialDeal {
  const SocialDeal({
    required this.title,
    required this.description,
    required this.platform,
    this.expiresLabel,
    this.badgeEmoji,
  });

  final String title;
  final String description;

  /// e.g. 'Instagram', 'TikTok', 'In-Person'
  final String platform;
  final String? expiresLabel;
  final String? badgeEmoji;
}
