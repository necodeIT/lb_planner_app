// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanban_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KanbanBoardImpl _$$KanbanBoardImplFromJson(Map<String, dynamic> json) =>
    _$KanbanBoardImpl(
      backlog: (json['backlog'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      todo: (json['todo'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      inProgress: (json['inprogress'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      done: (json['done'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$KanbanBoardImplToJson(_$KanbanBoardImpl instance) =>
    <String, dynamic>{
      'backlog': instance.backlog,
      'todo': instance.todo,
      'inprogress': instance.inProgress,
      'done': instance.done,
    };
