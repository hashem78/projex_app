import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_status.freezed.dart';
part 'task_status.g.dart';

@freezed
class PTaskStatus with _$PTaskStatus {
  const PTaskStatus._();
  const factory PTaskStatus.complete({
    @Default('taskStatus.complete') String name,
    @JsonKey(ignore: true) @Default(Colors.lightGreen) Color color,
  }) = _Complete;
  const factory PTaskStatus.incomplete({
    @Default('taskStatus.incomplete') String name,
    @JsonKey(ignore: true) @Default(Colors.red) Color color,
  }) = _UnComplete;
  const factory PTaskStatus.beingWorkedOn({
    @Default('taskStatus.beingWorkedOn') String name,
    @JsonKey(ignore: true) @Default(Colors.lightBlue) Color color,
  }) = _BeingWorkedOn;
  static const List<PTaskStatus> values = [
    PTaskStatus.complete(),
    PTaskStatus.incomplete(),
    PTaskStatus.beingWorkedOn(),
  ];
  factory PTaskStatus.fromJson(Map<String, dynamic> json) => _$PTaskStatusFromJson(json);
}
