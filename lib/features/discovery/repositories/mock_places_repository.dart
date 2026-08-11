import '../models/restaurant.dart';

/// Contract for fetching restaurant/deal data.
abstract class PlacesRepository {
  Future<List<Restaurant>> getNewSpots();
  Future<List<Restaurant>> getHappyHours();
  Future<List<Restaurant>> getSocialDeals();
  Future<Restaurant?> getById(String id);
}

/// Realistic Vancouver dummy data – no API keys required.
class MockPlacesRepository implements PlacesRepository {
  static final List<Restaurant> _all = [
    // ── New Spots ─────────────────────────────────────────────────────────
    Restaurant(
      id: 'noodle-box-gastown',
      name: 'Noodle Box Gastown',
      neighbourhood: 'Gastown',
      address: '123 Water St, Vancouver',
      cuisine: 'Pan-Asian Noodles',
      priceRange: '\$\$',
      rating: 4.5,
      ratingPlatform: RatingPlatform.google,
      isNew: true,
      sentimentSummary:
          'Loved for its bold broth and generous portions. '
          'The spicy tantanmen is a crowd favourite. '
          'Service can be slow on weekends but the vibe makes up for it.',
      tags: ['noodles', 'late-night', 'vegetarian-options'],
      photoUrls: const [
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800',
          caption: 'Tantanmen special',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1555126634-323283e090fa?w=800',
          caption: 'Chef at work',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=800',
          caption: 'Interior vibes',
        ),
      ],
      latitude: 49.2842,
      longitude: -123.1073,
    ),
    Restaurant(
      id: 'salt-spring-tavern',
      name: 'Salt Spring Tavern',
      neighbourhood: 'Mount Pleasant',
      address: '234 Main St, Vancouver',
      cuisine: 'Pacific Northwest',
      priceRange: '\$\$\$',
      rating: 4.7,
      ratingPlatform: RatingPlatform.mixed,
      isNew: true,
      sentimentSummary:
          'Outstanding farm-to-table menu with rotating BC ingredients. '
          'The dungeness crab toast is unmissable. '
          'Wine list curated with local BC VQA bottles.',
      tags: ['farm-to-table', 'brunch', 'date-night'],
      photoUrls: const [
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800',
          caption: 'Crab toast',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
          caption: 'Seasonal plate',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1559847844-5315695dadae?w=800',
          caption: 'Cozy interior',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=800',
          caption: 'Chef special',
        ),
      ],
      latitude: 49.2658,
      longitude: -123.1012,
    ),
    Restaurant(
      id: 'bao-down-chinatown',
      name: 'Bao Down',
      neighbourhood: 'Chinatown',
      address: '392 Hastings St W, Vancouver',
      cuisine: 'Modern Asian Street Food',
      priceRange: '\$\$',
      rating: 4.3,
      ratingPlatform: RatingPlatform.yelp,
      isNew: true,
      sentimentSummary:
          'Creative bao fillings with a heavy Pacific Northwest twist. '
          'The pulled duck bao is Instagram-worthy. '
          'Small space, expect a short queue during lunch.',
      tags: ['bao', 'street-food', 'instagram-worthy'],
      photoUrls: const [
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=800',
          caption: 'Pulled duck bao',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800',
          caption: 'Snack board',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
          caption: 'Chili oil fries',
        ),
      ],
      latitude: 49.2812,
      longitude: -123.1009,
    ),
    Restaurant(
      id: 'westpender-pizza-co',
      name: 'West Pender Pizza Co.',
      neighbourhood: 'Downtown',
      address: '788 W Pender St, Vancouver',
      cuisine: 'Neapolitan Pizza',
      priceRange: '\$\$',
      rating: 4.6,
      ratingPlatform: RatingPlatform.google,
      isNew: true,
      sentimentSummary:
          'Blazing hot wood-fired oven produces perfectly charred pies. '
          'The n\'duja + honey combo is addictive. '
          'Friendly staff and great natural wine selection.',
      tags: ['pizza', 'wood-fired', 'natural-wine'],
      photoUrls: const [
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800',
          caption: 'Margherita charred edge',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=800',
          caption: 'Wood-fired oven',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800',
          caption: 'N\'duja special',
        ),
      ],
      latitude: 49.2855,
      longitude: -123.1207,
    ),

    // ── Happy Hours ────────────────────────────────────────────────────────
    Restaurant(
      id: 'gastown-tap-room',
      name: 'Gastown Tap Room',
      neighbourhood: 'Gastown',
      address: '27 Blood Alley, Vancouver',
      cuisine: 'Gastropub',
      priceRange: '\$\$',
      rating: 4.2,
      ratingPlatform: RatingPlatform.mixed,
      sentimentSummary:
          'Loved for its late-night vibe and cheap highballs. '
          'Rotating craft taps feature local BC breweries. '
          'Some complaints about noise levels on Fridays.',
      tags: ['craft-beer', 'late-night', 'live-music'],
      photoUrls: const [
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=800',
          caption: 'Tap wall',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1559526324-593bc073d938?w=800',
          caption: 'Happy hour crowd',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1567696911980-2eed69a46042?w=800',
          caption: 'Nachos platter',
        ),
      ],
      happyHour: const HappyHour(
        daysLabel: 'Mon – Fri',
        timeRange: '3 PM – 6 PM',
        highlights: [
          '\$6 pints (rotating BC craft)',
          '\$7 house highballs',
          '\$5 nachos',
          'Half-price oysters',
        ],
      ),
      latitude: 49.2844,
      longitude: -123.1068,
    ),
    Restaurant(
      id: 'rooftop-yaletown',
      name: 'Rooftop Bar & Kitchen',
      neighbourhood: 'Yaletown',
      address: '1055 Mainland St, Vancouver',
      cuisine: 'Modern Cocktail Bar',
      priceRange: '\$\$\$',
      rating: 4.4,
      ratingPlatform: RatingPlatform.google,
      sentimentSummary:
          'Stunning rooftop views of False Creek. '
          'The espresso martini is exceptional. '
          'Pricey but worth it for the sunset hour; '
          'reservations strongly recommended.',
      tags: ['rooftop', 'cocktails', 'views', 'date-night'],
      photoUrls: const [
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1527529482837-4698179dc6ce?w=800',
          caption: 'Rooftop sunset',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=800',
          caption: 'Cocktail selection',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1566417713940-fe7c737a9ef2?w=800',
          caption: 'Small plates',
        ),
      ],
      happyHour: const HappyHour(
        daysLabel: 'Tue – Sun',
        timeRange: '4 PM – 7 PM',
        highlights: [
          '\$10 signature cocktails',
          '\$9 wine by the glass',
          '\$12 charcuterie board',
          'Half-price bar bites',
        ],
      ),
      latitude: 49.2739,
      longitude: -123.1205,
    ),
    Restaurant(
      id: 'mount-pleasant-bistro',
      name: 'Mt. Pleasant Bistro',
      neighbourhood: 'Mount Pleasant',
      address: '2458 Main St, Vancouver',
      cuisine: 'French-Canadian',
      priceRange: '\$\$',
      rating: 4.5,
      ratingPlatform: RatingPlatform.yelp,
      sentimentSummary:
          'Charming neighbourhood bistro with impeccable poutine. '
          'The duck confit is the star of the menu. '
          'Portions are generous and the staff remember regulars.',
      tags: ['french', 'poutine', 'brunch', 'neighbourhood-gem'],
      photoUrls: const [
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?w=800',
          caption: 'Poutine close-up',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800',
          caption: 'Duck confit',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=800',
          caption: 'Sunday brunch spread',
        ),
      ],
      happyHour: const HappyHour(
        daysLabel: 'Wed – Sat',
        timeRange: '5 PM – 7 PM',
        highlights: [
          '\$8 Quebec craft beer',
          '\$9 house wine',
          '\$12 mini poutine',
          '\$5 off mussels',
        ],
      ),
      latitude: 49.2625,
      longitude: -123.1002,
    ),

    // ── Social Deals ───────────────────────────────────────────────────────
    Restaurant(
      id: 'juniper-coffee-kitsilano',
      name: 'Juniper Coffee',
      neighbourhood: 'Kitsilano',
      address: '1926 W 4th Ave, Vancouver',
      cuisine: 'Specialty Coffee & Brunch',
      priceRange: '\$',
      rating: 4.8,
      ratingPlatform: RatingPlatform.google,
      sentimentSummary:
          'Best flat white in Kits, full stop. '
          'Their seasonal lattes (hello, cardamom rose!) are stunning. '
          'Gets packed by 9 AM on weekends – arrive early or order ahead.',
      tags: ['coffee', 'brunch', 'specialty', 'plants'],
      photoUrls: const [
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800',
          caption: 'Flat white art',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800',
          caption: 'Morning vibes',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800',
          caption: 'Brunch table',
        ),
      ],
      deal: const SocialDeal(
        title: 'Free oat milk upgrade',
        description:
            'Show your Instagram story repost to get a free oat milk '
            'upgrade on any espresso drink. Valid until end of June.',
        platform: 'Instagram',
        expiresLabel: 'Jun 30',
        badgeEmoji: '🥛',
      ),
      latitude: 49.2679,
      longitude: -123.1526,
    ),
    Restaurant(
      id: 'smoky-bbq-eastvan',
      name: 'Smoky\'s BBQ Shack',
      neighbourhood: 'East Vancouver',
      address: '1888 Commercial Dr, Vancouver',
      cuisine: 'Texas-Style BBQ',
      priceRange: '\$\$',
      rating: 4.6,
      ratingPlatform: RatingPlatform.yelp,
      sentimentSummary:
          'The brisket is smoked low and slow for 16 hours – it shows. '
          'Massive portions that demand a to-go box. '
          'Sauce trio (original, spicy, vinegar) is iconic.',
      tags: ['bbq', 'brisket', 'comfort-food', 'smoke'],
      photoUrls: const [
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1544025162-d76694265947?w=800',
          caption: 'Brisket plate',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1529193591184-b1d58069ecdd?w=800',
          caption: 'Smoker pit',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=800',
          caption: 'Sauce trio',
        ),
      ],
      deal: const SocialDeal(
        title: '\$5 off with TikTok check-in',
        description:
            'Post a TikTok from inside Smoky\'s, tag us '
            '@smokysvancouver, and show the staff your post for '
            '\$5 off your bill. New posts only.',
        platform: 'TikTok',
        expiresLabel: 'Ongoing',
        badgeEmoji: '🎵',
      ),
      latitude: 49.2622,
      longitude: -123.0694,
    ),
    Restaurant(
      id: 'sakura-ramen-downtown',
      name: 'Sakura Ramen',
      neighbourhood: 'Downtown',
      address: '575 Robson St, Vancouver',
      cuisine: 'Japanese Ramen',
      priceRange: '\$\$',
      rating: 4.4,
      ratingPlatform: RatingPlatform.mixed,
      isNew: true,
      sentimentSummary:
          'Rich tonkotsu broth that warms the soul. '
          'The chashu pork melts in your mouth and the soft-boiled egg '
          'is perfectly marinated. A solid go-to for ramen in the core.',
      tags: ['ramen', 'tonkotsu', 'japanese', 'late-night'],
      photoUrls: const [
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800',
          caption: 'Tonkotsu bowl',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1591814468924-caf88d1232e1?w=800',
          caption: 'Chashu close-up',
        ),
        PhotoEntry(
          url:
              'https://images.unsplash.com/photo-1557872943-16a5ac26437e?w=800',
          caption: 'Gyoza side',
        ),
      ],
      deal: const SocialDeal(
        title: 'Free gyoza on first visit',
        description:
            'New customers get a complimentary plate of pan-fried '
            'gyoza. Just mention you found us on Google Maps.',
        platform: 'Google Maps',
        expiresLabel: 'New customers only',
        badgeEmoji: '🥟',
      ),
      latitude: 49.2821,
      longitude: -123.1207,
    ),
  ];

  @override
  Future<List<Restaurant>> getNewSpots() async {
    await _simulateDelay();
    return _all.where((r) => r.isNew).toList();
  }

  @override
  Future<List<Restaurant>> getHappyHours() async {
    await _simulateDelay();
    return _all.where((r) => r.happyHour != null).toList();
  }

  @override
  Future<List<Restaurant>> getSocialDeals() async {
    await _simulateDelay();
    return _all.where((r) => r.deal != null).toList();
  }

  @override
  Future<Restaurant?> getById(String id) async {
    await _simulateDelay();
    try {
      return _all.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> _simulateDelay() =>
      Future.delayed(const Duration(milliseconds: 600));
}
