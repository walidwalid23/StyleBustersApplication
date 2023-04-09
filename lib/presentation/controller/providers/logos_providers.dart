import '../notifiers/logos_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final getSimilarLogosProvider = StateNotifierProvider.autoDispose<GetSimilarLogosStateNotifier,
    AsyncValue<dynamic>>((ref) => GetSimilarLogosStateNotifier());