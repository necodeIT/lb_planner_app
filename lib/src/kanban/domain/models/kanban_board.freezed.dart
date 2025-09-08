// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kanban_board.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KanbanBoard _$KanbanBoardFromJson(Map<String, dynamic> json) {
  return _KanbanBoard.fromJson(json);
}

/// @nodoc
mixin _$KanbanBoard {
  List<int> get backlog => throw _privateConstructorUsedError;
  List<int> get todo => throw _privateConstructorUsedError;
  @JsonKey(name: 'inprogress')
  List<int> get inProgress => throw _privateConstructorUsedError;
  List<int> get done => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KanbanBoardCopyWith<KanbanBoard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KanbanBoardCopyWith<$Res> {
  factory $KanbanBoardCopyWith(
          KanbanBoard value, $Res Function(KanbanBoard) then) =
      _$KanbanBoardCopyWithImpl<$Res, KanbanBoard>;
  @useResult
  $Res call(
      {List<int> backlog,
      List<int> todo,
      @JsonKey(name: 'inprogress') List<int> inProgress,
      List<int> done});
}

/// @nodoc
class _$KanbanBoardCopyWithImpl<$Res, $Val extends KanbanBoard>
    implements $KanbanBoardCopyWith<$Res> {
  _$KanbanBoardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backlog = null,
    Object? todo = null,
    Object? inProgress = null,
    Object? done = null,
  }) {
    return _then(_value.copyWith(
      backlog: null == backlog
          ? _value.backlog
          : backlog // ignore: cast_nullable_to_non_nullable
              as List<int>,
      todo: null == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as List<int>,
      inProgress: null == inProgress
          ? _value.inProgress
          : inProgress // ignore: cast_nullable_to_non_nullable
              as List<int>,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KanbanBoardImplCopyWith<$Res>
    implements $KanbanBoardCopyWith<$Res> {
  factory _$$KanbanBoardImplCopyWith(
          _$KanbanBoardImpl value, $Res Function(_$KanbanBoardImpl) then) =
      __$$KanbanBoardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<int> backlog,
      List<int> todo,
      @JsonKey(name: 'inprogress') List<int> inProgress,
      List<int> done});
}

/// @nodoc
class __$$KanbanBoardImplCopyWithImpl<$Res>
    extends _$KanbanBoardCopyWithImpl<$Res, _$KanbanBoardImpl>
    implements _$$KanbanBoardImplCopyWith<$Res> {
  __$$KanbanBoardImplCopyWithImpl(
      _$KanbanBoardImpl _value, $Res Function(_$KanbanBoardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backlog = null,
    Object? todo = null,
    Object? inProgress = null,
    Object? done = null,
  }) {
    return _then(_$KanbanBoardImpl(
      backlog: null == backlog
          ? _value._backlog
          : backlog // ignore: cast_nullable_to_non_nullable
              as List<int>,
      todo: null == todo
          ? _value._todo
          : todo // ignore: cast_nullable_to_non_nullable
              as List<int>,
      inProgress: null == inProgress
          ? _value._inProgress
          : inProgress // ignore: cast_nullable_to_non_nullable
              as List<int>,
      done: null == done
          ? _value._done
          : done // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KanbanBoardImpl extends _KanbanBoard {
  const _$KanbanBoardImpl(
      {final List<int> backlog = const [],
      required final List<int> todo,
      @JsonKey(name: 'inprogress') required final List<int> inProgress,
      required final List<int> done})
      : _backlog = backlog,
        _todo = todo,
        _inProgress = inProgress,
        _done = done,
        super._();

  factory _$KanbanBoardImpl.fromJson(Map<String, dynamic> json) =>
      _$$KanbanBoardImplFromJson(json);

  final List<int> _backlog;
  @override
  @JsonKey()
  List<int> get backlog {
    if (_backlog is EqualUnmodifiableListView) return _backlog;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_backlog);
  }

  final List<int> _todo;
  @override
  List<int> get todo {
    if (_todo is EqualUnmodifiableListView) return _todo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todo);
  }

  final List<int> _inProgress;
  @override
  @JsonKey(name: 'inprogress')
  List<int> get inProgress {
    if (_inProgress is EqualUnmodifiableListView) return _inProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inProgress);
  }

  final List<int> _done;
  @override
  List<int> get done {
    if (_done is EqualUnmodifiableListView) return _done;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_done);
  }

  @override
  String toString() {
    return 'KanbanBoard(backlog: $backlog, todo: $todo, inProgress: $inProgress, done: $done)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KanbanBoardImpl &&
            const DeepCollectionEquality().equals(other._backlog, _backlog) &&
            const DeepCollectionEquality().equals(other._todo, _todo) &&
            const DeepCollectionEquality()
                .equals(other._inProgress, _inProgress) &&
            const DeepCollectionEquality().equals(other._done, _done));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_backlog),
      const DeepCollectionEquality().hash(_todo),
      const DeepCollectionEquality().hash(_inProgress),
      const DeepCollectionEquality().hash(_done));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KanbanBoardImplCopyWith<_$KanbanBoardImpl> get copyWith =>
      __$$KanbanBoardImplCopyWithImpl<_$KanbanBoardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KanbanBoardImplToJson(
      this,
    );
  }
}

abstract class _KanbanBoard extends KanbanBoard {
  const factory _KanbanBoard(
      {final List<int> backlog,
      required final List<int> todo,
      @JsonKey(name: 'inprogress') required final List<int> inProgress,
      required final List<int> done}) = _$KanbanBoardImpl;
  const _KanbanBoard._() : super._();

  factory _KanbanBoard.fromJson(Map<String, dynamic> json) =
      _$KanbanBoardImpl.fromJson;

  @override
  List<int> get backlog;
  @override
  List<int> get todo;
  @override
  @JsonKey(name: 'inprogress')
  List<int> get inProgress;
  @override
  List<int> get done;
  @override
  @JsonKey(ignore: true)
  _$$KanbanBoardImplCopyWith<_$KanbanBoardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
