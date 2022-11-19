// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_repos_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchReposResponse _$SearchReposResponseFromJson(Map<String, dynamic> json) {
  return _SearchReposResponse.fromJson(json);
}

/// @nodoc
mixin _$SearchReposResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get incompleteResults => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<Repo> get repos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchReposResponseCopyWith<SearchReposResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchReposResponseCopyWith<$Res> {
  factory $SearchReposResponseCopyWith(
          SearchReposResponse value, $Res Function(SearchReposResponse) then) =
      _$SearchReposResponseCopyWithImpl<$Res, SearchReposResponse>;
  @useResult
  $Res call(
      {bool success,
      String message,
      int totalCount,
      bool incompleteResults,
      @JsonKey(name: 'items') List<Repo> repos});
}

/// @nodoc
class _$SearchReposResponseCopyWithImpl<$Res, $Val extends SearchReposResponse>
    implements $SearchReposResponseCopyWith<$Res> {
  _$SearchReposResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? totalCount = null,
    Object? incompleteResults = null,
    Object? repos = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      incompleteResults: null == incompleteResults
          ? _value.incompleteResults
          : incompleteResults // ignore: cast_nullable_to_non_nullable
              as bool,
      repos: null == repos
          ? _value.repos
          : repos // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SearchReposResponseCopyWith<$Res>
    implements $SearchReposResponseCopyWith<$Res> {
  factory _$$_SearchReposResponseCopyWith(_$_SearchReposResponse value,
          $Res Function(_$_SearchReposResponse) then) =
      __$$_SearchReposResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      int totalCount,
      bool incompleteResults,
      @JsonKey(name: 'items') List<Repo> repos});
}

/// @nodoc
class __$$_SearchReposResponseCopyWithImpl<$Res>
    extends _$SearchReposResponseCopyWithImpl<$Res, _$_SearchReposResponse>
    implements _$$_SearchReposResponseCopyWith<$Res> {
  __$$_SearchReposResponseCopyWithImpl(_$_SearchReposResponse _value,
      $Res Function(_$_SearchReposResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? totalCount = null,
    Object? incompleteResults = null,
    Object? repos = null,
  }) {
    return _then(_$_SearchReposResponse(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      incompleteResults: null == incompleteResults
          ? _value.incompleteResults
          : incompleteResults // ignore: cast_nullable_to_non_nullable
              as bool,
      repos: null == repos
          ? _value._repos
          : repos // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SearchReposResponse implements _SearchReposResponse {
  const _$_SearchReposResponse(
      {this.success = true,
      this.message = '',
      this.totalCount = 0,
      this.incompleteResults = false,
      @JsonKey(name: 'items') final List<Repo> repos = const <Repo>[]})
      : _repos = repos;

  factory _$_SearchReposResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SearchReposResponseFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final bool incompleteResults;
  final List<Repo> _repos;
  @override
  @JsonKey(name: 'items')
  List<Repo> get repos {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_repos);
  }

  @override
  String toString() {
    return 'SearchReposResponse(success: $success, message: $message, totalCount: $totalCount, incompleteResults: $incompleteResults, repos: $repos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchReposResponse &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.incompleteResults, incompleteResults) ||
                other.incompleteResults == incompleteResults) &&
            const DeepCollectionEquality().equals(other._repos, _repos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, totalCount,
      incompleteResults, const DeepCollectionEquality().hash(_repos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchReposResponseCopyWith<_$_SearchReposResponse> get copyWith =>
      __$$_SearchReposResponseCopyWithImpl<_$_SearchReposResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchReposResponseToJson(
      this,
    );
  }
}

abstract class _SearchReposResponse implements SearchReposResponse {
  const factory _SearchReposResponse(
      {final bool success,
      final String message,
      final int totalCount,
      final bool incompleteResults,
      @JsonKey(name: 'items') final List<Repo> repos}) = _$_SearchReposResponse;

  factory _SearchReposResponse.fromJson(Map<String, dynamic> json) =
      _$_SearchReposResponse.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  int get totalCount;
  @override
  bool get incompleteResults;
  @override
  @JsonKey(name: 'items')
  List<Repo> get repos;
  @override
  @JsonKey(ignore: true)
  _$$_SearchReposResponseCopyWith<_$_SearchReposResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
