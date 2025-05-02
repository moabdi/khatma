// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$partsHash() => r'2502b1f034e6f30b146643b71d6d89871e02ab0b';

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

/// See also [parts].
@ProviderFor(parts)
const partsProvider = PartsFamily();

/// See also [parts].
class PartsFamily extends Family {
  /// See also [parts].
  const PartsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'partsProvider';

  /// See also [parts].
  PartsProvider call(
    String unit,
  ) {
    return PartsProvider(
      unit,
    );
  }

  @visibleForOverriding
  @override
  PartsProvider getProviderOverride(
    covariant PartsProvider provider,
  ) {
    return call(
      provider.unit,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(FutureOr<List<Part>> Function(PartsRef ref) create) {
    return _$PartsFamilyOverride(this, create);
  }
}

class _$PartsFamilyOverride implements FamilyOverride {
  _$PartsFamilyOverride(this.overriddenFamily, this.create);

  final FutureOr<List<Part>> Function(PartsRef ref) create;

  @override
  final PartsFamily overriddenFamily;

  @override
  PartsProvider getProviderOverride(
    covariant PartsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [parts].
class PartsProvider extends AutoDisposeFutureProvider<List<Part>> {
  /// See also [parts].
  PartsProvider(
    String unit,
  ) : this._internal(
          (ref) => parts(
            ref as PartsRef,
            unit,
          ),
          from: partsProvider,
          name: r'partsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$partsHash,
          dependencies: PartsFamily._dependencies,
          allTransitiveDependencies: PartsFamily._allTransitiveDependencies,
          unit: unit,
        );

  PartsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.unit,
  }) : super.internal();

  final String unit;

  @override
  Override overrideWith(
    FutureOr<List<Part>> Function(PartsRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PartsProvider._internal(
        (ref) => create(ref as PartsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        unit: unit,
      ),
    );
  }

  @override
  (String,) get argument {
    return (unit,);
  }

  @override
  AutoDisposeFutureProviderElement<List<Part>> createElement() {
    return _PartsProviderElement(this);
  }

  PartsProvider _copyWith(
    FutureOr<List<Part>> Function(PartsRef ref) create,
  ) {
    return PartsProvider._internal(
      (ref) => create(ref as PartsRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      unit: unit,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PartsProvider && other.unit == unit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, unit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PartsRef on AutoDisposeFutureProviderRef<List<Part>> {
  /// The parameter `unit` of this provider.
  String get unit;
}

class _PartsProviderElement extends AutoDisposeFutureProviderElement<List<Part>>
    with PartsRef {
  _PartsProviderElement(super.provider);

  @override
  String get unit => (origin as PartsProvider).unit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
