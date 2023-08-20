// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class RoomEntity extends Equatable {
  final int id;
  final String hostUuid;
  final String? opponentUuid;

  const RoomEntity({
    required this.id,
    required this.hostUuid,
    this.opponentUuid,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, hostUuid, opponentUuid];
}
