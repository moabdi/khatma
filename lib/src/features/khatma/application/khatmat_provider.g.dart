// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatmat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$khatmaListHash() => r'e5642ecc71b02c311d3ccfc3c6170ec2ad6e84fa';

/// See also [KhatmaList].
@ProviderFor(KhatmaList)
final khatmaListProvider =
    AutoDisposeAsyncNotifierProvider<KhatmaList, List<Khatma>>.internal(
  KhatmaList.new,
  name: r'khatmaListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$khatmaListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$KhatmaList = AutoDisposeAsyncNotifier<List<Khatma>>;
String _$currentKhatmaHash() => r'58233dfa327489a1e9032b85c9c0159d9d9971af';

/// See also [CurrentKhatma].
@ProviderFor(CurrentKhatma)
final currentKhatmaProvider = NotifierProvider<CurrentKhatma, Khatma?>.internal(
  CurrentKhatma.new,
  name: r'currentKhatmaProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentKhatmaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentKhatma = Notifier<Khatma?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
