import '../notifiers/logo_notifiers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/logo_entity.dart';

final userSignUpProvider = StateNotifierProvider.autoDispose<GetSimilarLogosStateNotifier,
    AsyncValue<dynamic>>((ref) => GetSimilarLogosStateNotifier());