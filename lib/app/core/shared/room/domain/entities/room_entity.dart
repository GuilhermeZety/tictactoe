// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class RoomEntity extends Equatable {
  int id;
  String hostUuid;
  String? opponentUuid;

  RoomEntity({
    required this.id,
    required this.hostUuid,
    this.opponentUuid,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, hostUuid, opponentUuid];
}
