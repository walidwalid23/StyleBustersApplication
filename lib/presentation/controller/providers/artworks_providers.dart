import '../notifiers/artworks_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final getSimilarStyleArtworksProvider = StateNotifierProvider.autoDispose<GetSimilarStyleArtworksStateNotifier,
    AsyncValue<dynamic>>((ref) => GetSimilarStyleArtworksStateNotifier());