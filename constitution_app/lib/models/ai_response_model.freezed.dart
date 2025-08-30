// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AiResponseModel _$AiResponseModelFromJson(Map<String, dynamic> json) {
  return _AiResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AiResponseModel {
  String get answer => throw _privateConstructorUsedError;
  List<int> get page_nos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AiResponseModelCopyWith<AiResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiResponseModelCopyWith<$Res> {
  factory $AiResponseModelCopyWith(
          AiResponseModel value, $Res Function(AiResponseModel) then) =
      _$AiResponseModelCopyWithImpl<$Res, AiResponseModel>;
  @useResult
  $Res call({String answer, List<int> page_nos});
}

/// @nodoc
class _$AiResponseModelCopyWithImpl<$Res, $Val extends AiResponseModel>
    implements $AiResponseModelCopyWith<$Res> {
  _$AiResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answer = null,
    Object? page_nos = null,
  }) {
    return _then(_value.copyWith(
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      page_nos: null == page_nos
          ? _value.page_nos
          : page_nos // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiResponseModelImplCopyWith<$Res>
    implements $AiResponseModelCopyWith<$Res> {
  factory _$$AiResponseModelImplCopyWith(_$AiResponseModelImpl value,
          $Res Function(_$AiResponseModelImpl) then) =
      __$$AiResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String answer, List<int> page_nos});
}

/// @nodoc
class __$$AiResponseModelImplCopyWithImpl<$Res>
    extends _$AiResponseModelCopyWithImpl<$Res, _$AiResponseModelImpl>
    implements _$$AiResponseModelImplCopyWith<$Res> {
  __$$AiResponseModelImplCopyWithImpl(
      _$AiResponseModelImpl _value, $Res Function(_$AiResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answer = null,
    Object? page_nos = null,
  }) {
    return _then(_$AiResponseModelImpl(
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      page_nos: null == page_nos
          ? _value._page_nos
          : page_nos // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AiResponseModelImpl implements _AiResponseModel {
  const _$AiResponseModelImpl(
      {required this.answer, required final List<int> page_nos})
      : _page_nos = page_nos;

  factory _$AiResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiResponseModelImplFromJson(json);

  @override
  final String answer;
  final List<int> _page_nos;
  @override
  List<int> get page_nos {
    if (_page_nos is EqualUnmodifiableListView) return _page_nos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_page_nos);
  }

  @override
  String toString() {
    return 'AiResponseModel(answer: $answer, page_nos: $page_nos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiResponseModelImpl &&
            (identical(other.answer, answer) || other.answer == answer) &&
            const DeepCollectionEquality().equals(other._page_nos, _page_nos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, answer, const DeepCollectionEquality().hash(_page_nos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AiResponseModelImplCopyWith<_$AiResponseModelImpl> get copyWith =>
      __$$AiResponseModelImplCopyWithImpl<_$AiResponseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiResponseModelImplToJson(
      this,
    );
  }
}

abstract class _AiResponseModel implements AiResponseModel {
  const factory _AiResponseModel(
      {required final String answer,
      required final List<int> page_nos}) = _$AiResponseModelImpl;

  factory _AiResponseModel.fromJson(Map<String, dynamic> json) =
      _$AiResponseModelImpl.fromJson;

  @override
  String get answer;
  @override
  List<int> get page_nos;
  @override
  @JsonKey(ignore: true)
  _$$AiResponseModelImplCopyWith<_$AiResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
