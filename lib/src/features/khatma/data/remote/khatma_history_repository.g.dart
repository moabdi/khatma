// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatma_history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$khatmaHistoryRepositoryHash() =>
    r'dedf9b328360d44bda6f132167ff0ffa83f4924a';

/// See also [khatmaHistoryRepository].
@ProviderFor(khatmaHistoryRepository)
final khatmaHistoryRepositoryProvider =
    Provider<KhatmaHistoryRepository>.internal(
  khatmaHistoryRepository,
  name: r'khatmaHistoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$khatmaHistoryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KhatmaHistoryRepositoryRef = ProviderRef<KhatmaHistoryRepository>;
String _$khatmaHistoryRepositoryStreamHash() =>
    r'ac93d7b839ad9337dea17008f565223f8b088382';

/// See also [khatmaHistoryRepositoryStream].
@ProviderFor(khatmaHistoryRepositoryStream)
final khatmaHistoryRepositoryStreamProvider =
    AutoDisposeStreamProvider<List<KhatmaHistory>>.internal(
  khatmaHistoryRepositoryStream,
  name: r'khatmaHistoryRepositoryStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$khatmaHistoryRepositoryStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KhatmaHistoryRepositoryStreamRef
    = AutoDisposeStreamProviderRef<List<KhatmaHistory>>;
String _$khatmaHistoryRepositoryFutureHash() =>
    r'5c65d323df15edb07e5213f2ae3642de32f9aa93';

/// See also [khatmaHistoryRepositoryFuture].
@ProviderFor(khatmaHistoryRepositoryFuture)
final khatmaHistoryRepositoryFutureProvider =
    AutoDisposeFutureProvider<List<KhatmaHistory>>.internal(
  khatmaHistoryRepositoryFuture,
  name: r'khatmaHistoryRepositoryFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$khatmaHistoryRepositoryFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KhatmaHistoryRepositoryFutureRef
    = AutoDisposeFutureProviderRef<List<KhatmaHistory>>;
String _$khatmaHistoryStreamHash() =>
    r'6a9620972a1821a3c48fe8e66b01012ac531192f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [khatmaHistoryStream].
@ProviderFor(khatmaHistoryStream)
const khatmaHistoryStreamProvider = KhatmaHistoryStreamFamily();

/// See also [khatmaHistoryStream].
class KhatmaHistoryStreamFamily extends Family {
  /// See also [khatmaHistoryStream].
  const KhatmaHistoryStreamFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'khatmaHistoryStreamProvider';

  /// See also [khatmaHistoryStream].
  KhatmaHistoryStreamProvider call(
    KhatmaID id,
  ) {
    return KhatmaHistoryStreamProvider(
      id,
    );
  }

  @visibleForOverriding
  @override
  KhatmaHistoryStreamProvider getProviderOverride(
    covariant KhatmaHistoryStreamProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      Stream<KhatmaHistory?> Function(KhatmaHistoryStreamRef ref) create) {
    return _$KhatmaHistoryStreamFamilyOverride(this, create);
  }
}

class _$KhatmaHistoryStreamFamilyOverride implements FamilyOverride {
  _$KhatmaHistoryStreamFamilyOverride(this.overriddenFamily, this.create);

  final Stream<KhatmaHistory?> Function(KhatmaHistoryStreamRef ref) create;

  @override
  final KhatmaHistoryStreamFamily overriddenFamily;

  @override
  KhatmaHistoryStreamProvider getProviderOverride(
    covariant KhatmaHistoryStreamProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [khatmaHistoryStream].
class KhatmaHistoryStreamProvider
    extends AutoDisposeStreamProvider<KhatmaHistory?> {
  /// See also [khatmaHistoryStream].
  KhatmaHistoryStreamProvider(
    KhatmaID id,
  ) : this._internal(
          (ref) => khatmaHistoryStream(
            ref as KhatmaHistoryStreamRef,
            id,
          ),
          from: khatmaHistoryStreamProvider,
          name: r'khatmaHistoryStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$khatmaHistoryStreamHash,
          dependencies: KhatmaHistoryStreamFamily._dependencies,
          allTransitiveDependencies:
              KhatmaHistoryStreamFamily._allTransitiveDependencies,
          id: id,
        );

  KhatmaHistoryStreamProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final KhatmaID id;

  @override
  Override overrideWith(
    Stream<KhatmaHistory?> Function(KhatmaHistoryStreamRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: KhatmaHistoryStreamProvider._internal(
        (ref) => create(ref as KhatmaHistoryStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  (KhatmaID,) get argument {
    return (id,);
  }

  @override
  AutoDisposeStreamProviderElement<KhatmaHistory?> createElement() {
    return _KhatmaHistoryStreamProviderElement(this);
  }

  KhatmaHistoryStreamProvider _copyWith(
    Stream<KhatmaHistory?> Function(KhatmaHistoryStreamRef ref) create,
  ) {
    return KhatmaHistoryStreamProvider._internal(
      (ref) => create(ref as KhatmaHistoryStreamRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      id: id,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is KhatmaHistoryStreamProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin KhatmaHistoryStreamRef on AutoDisposeStreamProviderRef<KhatmaHistory?> {
  /// The parameter `id` of this provider.
  KhatmaID get id;
}

class _KhatmaHistoryStreamProviderElement
    extends AutoDisposeStreamProviderElement<KhatmaHistory?>
    with KhatmaHistoryStreamRef {
  _KhatmaHistoryStreamProviderElement(super.provider);

  @override
  KhatmaID get id => (origin as KhatmaHistoryStreamProvider).id;
}

String _$khatmaHistoryFutureHash() =>
    r'a8c51a36a20557c7d5588fb4340bd07cbb1b28c6';

/// See also [khatmaHistoryFuture].
@ProviderFor(khatmaHistoryFuture)
const khatmaHistoryFutureProvider = KhatmaHistoryFutureFamily();

/// See also [khatmaHistoryFuture].
class KhatmaHistoryFutureFamily extends Family {
  /// See also [khatmaHistoryFuture].
  const KhatmaHistoryFutureFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'khatmaHistoryFutureProvider';

  /// See also [khatmaHistoryFuture].
  KhatmaHistoryFutureProvider call(
    KhatmaID id,
  ) {
    return KhatmaHistoryFutureProvider(
      id,
    );
  }

  @visibleForOverriding
  @override
  KhatmaHistoryFutureProvider getProviderOverride(
    covariant KhatmaHistoryFutureProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<KhatmaHistory?> Function(KhatmaHistoryFutureRef ref) create) {
    return _$KhatmaHistoryFutureFamilyOverride(this, create);
  }
}

class _$KhatmaHistoryFutureFamilyOverride implements FamilyOverride {
  _$KhatmaHistoryFutureFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<KhatmaHistory?> Function(KhatmaHistoryFutureRef ref) create;

  @override
  final KhatmaHistoryFutureFamily overriddenFamily;

  @override
  KhatmaHistoryFutureProvider getProviderOverride(
    covariant KhatmaHistoryFutureProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [khatmaHistoryFuture].
class KhatmaHistoryFutureProvider
    extends AutoDisposeFutureProvider<KhatmaHistory?> {
  /// See also [khatmaHistoryFuture].
  KhatmaHistoryFutureProvider(
    KhatmaID id,
  ) : this._internal(
          (ref) => khatmaHistoryFuture(
            ref as KhatmaHistoryFutureRef,
            id,
          ),
          from: khatmaHistoryFutureProvider,
          name: r'khatmaHistoryFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$khatmaHistoryFutureHash,
          dependencies: KhatmaHistoryFutureFamily._dependencies,
          allTransitiveDependencies:
              KhatmaHistoryFutureFamily._allTransitiveDependencies,
          id: id,
        );

  KhatmaHistoryFutureProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final KhatmaID id;

  @override
  Override overrideWith(
    FutureOr<KhatmaHistory?> Function(KhatmaHistoryFutureRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: KhatmaHistoryFutureProvider._internal(
        (ref) => create(ref as KhatmaHistoryFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  (KhatmaID,) get argument {
    return (id,);
  }

  @override
  AutoDisposeFutureProviderElement<KhatmaHistory?> createElement() {
    return _KhatmaHistoryFutureProviderElement(this);
  }

  KhatmaHistoryFutureProvider _copyWith(
    FutureOr<KhatmaHistory?> Function(KhatmaHistoryFutureRef ref) create,
  ) {
    return KhatmaHistoryFutureProvider._internal(
      (ref) => create(ref as KhatmaHistoryFutureRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      id: id,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is KhatmaHistoryFutureProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin KhatmaHistoryFutureRef on AutoDisposeFutureProviderRef<KhatmaHistory?> {
  /// The parameter `id` of this provider.
  KhatmaID get id;
}

class _KhatmaHistoryFutureProviderElement
    extends AutoDisposeFutureProviderElement<KhatmaHistory?>
    with KhatmaHistoryFutureRef {
  _KhatmaHistoryFutureProviderElement(super.provider);

  @override
  KhatmaID get id => (origin as KhatmaHistoryFutureProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
