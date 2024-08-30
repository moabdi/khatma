// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatmas_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$khatmasRepositoryHash() => r'5d916065a777eb961097d15fa5d4a5fe0230a22a';

/// See also [khatmasRepository].
@ProviderFor(khatmasRepository)
final khatmasRepositoryProvider = Provider<KhatmasRepository>.internal(
  khatmasRepository,
  name: r'khatmasRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$khatmasRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KhatmasRepositoryRef = ProviderRef<KhatmasRepository>;
String _$khatmasListStreamHash() => r'43f909e4631062ec720cd9892d00491ff7f624b6';

/// See also [khatmasListStream].
@ProviderFor(khatmasListStream)
final khatmasListStreamProvider =
    AutoDisposeStreamProvider<List<Khatma>>.internal(
  khatmasListStream,
  name: r'khatmasListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$khatmasListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KhatmasListStreamRef = AutoDisposeStreamProviderRef<List<Khatma>>;
String _$khatmasListFutureHash() => r'b2110c508d7fd3b8d9129d761e1d4e289f0bbc14';

/// See also [khatmasListFuture].
@ProviderFor(khatmasListFuture)
final khatmasListFutureProvider =
    AutoDisposeFutureProvider<List<Khatma>>.internal(
  khatmasListFuture,
  name: r'khatmasListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$khatmasListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KhatmasListFutureRef = AutoDisposeFutureProviderRef<List<Khatma>>;
String _$khatmaStreamHash() => r'c068d7a1add846be36c84995e35295495a4bf207';

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

/// See also [khatmaStream].
@ProviderFor(khatmaStream)
const khatmaStreamProvider = KhatmaStreamFamily();

/// See also [khatmaStream].
class KhatmaStreamFamily extends Family {
  /// See also [khatmaStream].
  const KhatmaStreamFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'khatmaStreamProvider';

  /// See also [khatmaStream].
  KhatmaStreamProvider call(
    KhatmaID id,
  ) {
    return KhatmaStreamProvider(
      id,
    );
  }

  @visibleForOverriding
  @override
  KhatmaStreamProvider getProviderOverride(
    covariant KhatmaStreamProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(Stream<Khatma?> Function(KhatmaStreamRef ref) create) {
    return _$KhatmaStreamFamilyOverride(this, create);
  }
}

class _$KhatmaStreamFamilyOverride implements FamilyOverride {
  _$KhatmaStreamFamilyOverride(this.overriddenFamily, this.create);

  final Stream<Khatma?> Function(KhatmaStreamRef ref) create;

  @override
  final KhatmaStreamFamily overriddenFamily;

  @override
  KhatmaStreamProvider getProviderOverride(
    covariant KhatmaStreamProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [khatmaStream].
class KhatmaStreamProvider extends AutoDisposeStreamProvider<Khatma?> {
  /// See also [khatmaStream].
  KhatmaStreamProvider(
    KhatmaID id,
  ) : this._internal(
          (ref) => khatmaStream(
            ref as KhatmaStreamRef,
            id,
          ),
          from: khatmaStreamProvider,
          name: r'khatmaStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$khatmaStreamHash,
          dependencies: KhatmaStreamFamily._dependencies,
          allTransitiveDependencies:
              KhatmaStreamFamily._allTransitiveDependencies,
          id: id,
        );

  KhatmaStreamProvider._internal(
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
    Stream<Khatma?> Function(KhatmaStreamRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: KhatmaStreamProvider._internal(
        (ref) => create(ref as KhatmaStreamRef),
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
  AutoDisposeStreamProviderElement<Khatma?> createElement() {
    return _KhatmaStreamProviderElement(this);
  }

  KhatmaStreamProvider _copyWith(
    Stream<Khatma?> Function(KhatmaStreamRef ref) create,
  ) {
    return KhatmaStreamProvider._internal(
      (ref) => create(ref as KhatmaStreamRef),
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
    return other is KhatmaStreamProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin KhatmaStreamRef on AutoDisposeStreamProviderRef<Khatma?> {
  /// The parameter `id` of this provider.
  KhatmaID get id;
}

class _KhatmaStreamProviderElement
    extends AutoDisposeStreamProviderElement<Khatma?> with KhatmaStreamRef {
  _KhatmaStreamProviderElement(super.provider);

  @override
  KhatmaID get id => (origin as KhatmaStreamProvider).id;
}

String _$khatmaFutureHash() => r'6d1917eb5f9a407b890ec9223c91cd0a77e98acf';

/// See also [khatmaFuture].
@ProviderFor(khatmaFuture)
const khatmaFutureProvider = KhatmaFutureFamily();

/// See also [khatmaFuture].
class KhatmaFutureFamily extends Family {
  /// See also [khatmaFuture].
  const KhatmaFutureFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'khatmaFutureProvider';

  /// See also [khatmaFuture].
  KhatmaFutureProvider call(
    KhatmaID id,
  ) {
    return KhatmaFutureProvider(
      id,
    );
  }

  @visibleForOverriding
  @override
  KhatmaFutureProvider getProviderOverride(
    covariant KhatmaFutureProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      FutureOr<Khatma?> Function(KhatmaFutureRef ref) create) {
    return _$KhatmaFutureFamilyOverride(this, create);
  }
}

class _$KhatmaFutureFamilyOverride implements FamilyOverride {
  _$KhatmaFutureFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<Khatma?> Function(KhatmaFutureRef ref) create;

  @override
  final KhatmaFutureFamily overriddenFamily;

  @override
  KhatmaFutureProvider getProviderOverride(
    covariant KhatmaFutureProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [khatmaFuture].
class KhatmaFutureProvider extends AutoDisposeFutureProvider<Khatma?> {
  /// See also [khatmaFuture].
  KhatmaFutureProvider(
    KhatmaID id,
  ) : this._internal(
          (ref) => khatmaFuture(
            ref as KhatmaFutureRef,
            id,
          ),
          from: khatmaFutureProvider,
          name: r'khatmaFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$khatmaFutureHash,
          dependencies: KhatmaFutureFamily._dependencies,
          allTransitiveDependencies:
              KhatmaFutureFamily._allTransitiveDependencies,
          id: id,
        );

  KhatmaFutureProvider._internal(
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
    FutureOr<Khatma?> Function(KhatmaFutureRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: KhatmaFutureProvider._internal(
        (ref) => create(ref as KhatmaFutureRef),
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
  AutoDisposeFutureProviderElement<Khatma?> createElement() {
    return _KhatmaFutureProviderElement(this);
  }

  KhatmaFutureProvider _copyWith(
    FutureOr<Khatma?> Function(KhatmaFutureRef ref) create,
  ) {
    return KhatmaFutureProvider._internal(
      (ref) => create(ref as KhatmaFutureRef),
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
    return other is KhatmaFutureProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin KhatmaFutureRef on AutoDisposeFutureProviderRef<Khatma?> {
  /// The parameter `id` of this provider.
  KhatmaID get id;
}

class _KhatmaFutureProviderElement
    extends AutoDisposeFutureProviderElement<Khatma?> with KhatmaFutureRef {
  _KhatmaFutureProviderElement(super.provider);

  @override
  KhatmaID get id => (origin as KhatmaFutureProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
