import '../notifiers/clothes_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylebusters/domain/entities/clothes_entity.dart';

final getSimilarStyleClothesProvider = StateNotifierProvider<GetSimilarStyleClothesStateNotifier,
    AsyncValue<dynamic>>((ref) => GetSimilarStyleClothesStateNotifier(AsyncData(ClothesPagination(fetchingLoading: false,
    retrievedClothes: []))));