import '../notifiers/clothes_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final getSimilarStyleClothesProvider = StateNotifierProvider<GetSimilarStyleClothesStateNotifier,
    AsyncValue<dynamic>>((ref) => GetSimilarStyleClothesStateNotifier());