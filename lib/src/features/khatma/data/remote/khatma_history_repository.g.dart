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
    r'e358b31d598f2d3eee627e16c03462345cbeef7d';

/// See also [khatmaHistoryRepositoryStream].
@ProviderFor(khatmaHistoryRepositoryStream)
final khatmaHistoryRepositoryStreamProvider =
    AutoDisposeStreamProvider<List<CompletionHistory>>.internal(
  khatmaHistoryRepositoryStream,
  name: r'khatmaHistoryRepositoryStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$khatmaHistoryRepositoryStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KhatmaHistoryRepositoryStreamRef
    = AutoDisposeStreamProviderRef<List<CompletionHistory>>;
String _$khatmaHistoryRepositoryFutureHash() =>
    r'2e2439a3f606ba6a421e7cf0487eea2d12584423';

/// See also [khatmaHistoryRepositoryFuture].
@ProviderFor(khatmaHistoryRepositoryFuture)
final khatmaHistoryRepositoryFutureProvider =
    AutoDisposeFutureProvider<List<CompletionHistory>>.internal(
  khatmaHistoryRepositoryFuture,
  name: r'khatmaHistoryRepositoryFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$khatmaHistoryRepositoryFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KhatmaHistoryRepositoryFutureRef
    = AutoDisposeFutureProviderRef<List<CompletionHistory>>;
String _$khatmaHistoryStreamHash() =>
    r'e764563e9beaf03d24bc5c26c90565922a844ffc';

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
      Stream<CompletionHistory?> Function(KhatmaHistoryStreamRef ref) create) {
    return _$KhatmaHistoryStreamFamilyOverride(this, create);
  }
}

class _$KhatmaHistoryStreamFamilyOverride implements FamilyOverride {
  _$KhatmaHistoryStreamFamilyOverride(this.overriddenFamily, this.create);

  final Stream<CompletionHistory?> Function(KhatmaHistoryStreamRef ref) create;

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
    extends AutoDisposeStreamProvider<CompletionHistory?> {
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
    Stream<CompletionHistory?> Function(KhatmaHistoryStreamRef ref) create,
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
  AutoDisposeStreamProviderElement<CompletionHistory?> createElement() {
    return _KhatmaHistoryStreamProviderElement(this);
  }

  KhatmaHistoryStreamProvider _copyWith(
    Stream<CompletionHistory?> Function(KhatmaHistoryStreamRef ref) create,
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

mixin KhatmaHistoryStreamRef
    on AutoDisposeStreamProviderRef<CompletionHistory?> {
  /// The parameter `id` of this provider.
  KhatmaID get id;
}

class _KhatmaHistoryStreamProviderElement
    extends AutoDisposeStreamProviderElement<CompletionHistory?>
    with KhatmaHistoryStreamRef {
  _KhatmaHistoryStreamProviderElement(super.provider);

  @override
  KhatmaID get id => (origin as KhatmaHistoryStreamProvider).id;
}

String _$khatmaHistoryFutureHash() =>
    r'b55ea97af3d9789d9f856eb3c5eb77edbfb0bf96';

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
      FutureOr<CompletionHistory?> Function(KhatmaHistoryFutureRef ref)
          create) {
    return _$KhatmaHistoryFutureFamilyOverride(this, create);
  }
}

class _$KhatmaHistoryFutureFamilyOverride implements FamilyOverride {
  _$KhatmaHistoryFutureFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<CompletionHistory?> Function(KhatmaHistoryFutureRef ref)
      create;

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
    extends AutoDisposeFutureProvider<CompletionHistory?> {
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
    FutureOr<CompletionHistory?> Function(KhatmaHistoryFutureRef ref) create,
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
  AutoDisposeFutureProviderElement<CompletionHistory?> createElement() {
    return _KhatmaHistoryFutureProviderElement(this);
  }

  KhatmaHistoryFutureProvider _copyWith(
    FutureOr<CompletionHistory?> Function(KhatmaHistoryFutureRef ref) create,
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

mixin KhatmaHistoryFutureRef
    on AutoDisposeFutureProviderRef<CompletionHistory?> {
  /// The parameter `id` of this provider.
  KhatmaID get id;
}

class _KhatmaHistoryFutureProviderElement
    extends AutoDisposeFutureProviderElement<CompletionHistory?>
    with KhatmaHistoryFutureRef {
  _KhatmaHistoryFutureProviderElement(super.provider);

  @override
  KhatmaID get id => (origin as KhatmaHistoryFutureProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
