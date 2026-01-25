// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curriculo_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$curriculoRepositoryHash() =>
    r'fe1477180d89106bce37fb3006c3f54a57c2311b';

/// See also [curriculoRepository].
@ProviderFor(curriculoRepository)
final curriculoRepositoryProvider =
    AutoDisposeProvider<CurriculoRepository>.internal(
  curriculoRepository,
  name: r'curriculoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$curriculoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurriculoRepositoryRef = AutoDisposeProviderRef<CurriculoRepository>;
String _$curriculoListServiceHash() =>
    r'aa385e2d70ec30dafc8f2c525a3c66c8540e851d';

/// See also [CurriculoListService].
@ProviderFor(CurriculoListService)
final curriculoListServiceProvider = AutoDisposeAsyncNotifierProvider<
    CurriculoListService, List<Resume>>.internal(
  CurriculoListService.new,
  name: r'curriculoListServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$curriculoListServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurriculoListService = AutoDisposeAsyncNotifier<List<Resume>>;
String _$currentCurriculoServiceHash() =>
    r'aa1eb7ebede24f9b0b5939f14bb6e9863420c3dd';

/// See also [CurrentCurriculoService].
@ProviderFor(CurrentCurriculoService)
final currentCurriculoServiceProvider =
    AutoDisposeNotifierProvider<CurrentCurriculoService, Resume?>.internal(
  CurrentCurriculoService.new,
  name: r'currentCurriculoServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentCurriculoServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentCurriculoService = AutoDisposeNotifier<Resume?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
