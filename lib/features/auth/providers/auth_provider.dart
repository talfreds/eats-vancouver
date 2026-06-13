import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Auth state ─────────────────────────────────────────────────────────────

/// Simple mock user model.
class MockUser {
  const MockUser({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;
}

/// Holds the current signed-in user (null = signed out).
class AuthNotifier extends Notifier<MockUser?> {
  @override
  MockUser? build() => null;

  /// Simulates a successful Google Sign-In.
  Future<void> signInWithGoogle() async {
    // Simulate network latency.
    await Future.delayed(const Duration(milliseconds: 800));
    state = const MockUser(
      uid: 'mock-uid-12345',
      displayName: 'Alex Chen',
      email: 'alex.chen@example.com',
      photoUrl: 'https://i.pravatar.cc/150?img=47',
    );
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    state = null;
  }
}

final authProvider = NotifierProvider<AuthNotifier, MockUser?>(
  AuthNotifier.new,
);

/// Convenience bool – is the user currently signed in?
final isSignedInProvider = Provider<bool>(
  (ref) => ref.watch(authProvider) != null,
);
