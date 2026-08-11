import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';
import '../repositories/mock_places_repository.dart';

// ── Repository provider ────────────────────────────────────────────────────

final placesRepositoryProvider = Provider<MockPlacesRepository>(
  (ref) => MockPlacesRepository(),
);

// ── Feed tab enum ──────────────────────────────────────────────────────────

enum FeedTab { newSpots, happyHours, socialDeals }

// ── Active tab ─────────────────────────────────────────────────────────────

final activeFeedTabProvider = StateProvider<FeedTab>(
  (ref) => FeedTab.newSpots,
);

// ── Per-tab data providers ─────────────────────────────────────────────────

final newSpotsProvider = FutureProvider<List<Restaurant>>((ref) {
  return ref.watch(placesRepositoryProvider).getNewSpots();
});

final happyHoursProvider = FutureProvider<List<Restaurant>>((ref) {
  return ref.watch(placesRepositoryProvider).getHappyHours();
});

final socialDealsProvider = FutureProvider<List<Restaurant>>((ref) {
  return ref.watch(placesRepositoryProvider).getSocialDeals();
});

/// Returns the correct data provider for the active tab.
final activeFeedProvider = Provider<AsyncValue<List<Restaurant>>>((ref) {
  final tab = ref.watch(activeFeedTabProvider);
  return switch (tab) {
    FeedTab.newSpots => ref.watch(newSpotsProvider),
    FeedTab.happyHours => ref.watch(happyHoursProvider),
    FeedTab.socialDeals => ref.watch(socialDealsProvider),
  };
});

// ── Detail provider ────────────────────────────────────────────────────────

final restaurantDetailProvider = FutureProviderFamily<Restaurant?, String>(
  (ref, id) => ref.watch(placesRepositoryProvider).getById(id),
);
