import 'package:aqua_task/helpers/leave_type_helper.dart';

class LeaveModel {
  int? id;
  String employeeName;
  String reason;
  DateTime startDate;
  DateTime endDate;
  LeaveTypeHelper leaveType;
  static const int maxLeaveDays = 12;
  LeaveModel({
    this.id,
    required this.employeeName,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.leaveType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeName': employeeName,
      'reason': reason,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'leaveType': leaveTypeToString(leaveType),
    };
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(
      id: map['id'],
      employeeName: map['employeeName'],
      reason: map['reason'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      leaveType: stringToLeaveType(map['leaveType']),
    );
  }

  int get leaveDays => endDate.difference(startDate).inDays + 1;
  int get remainingLeaveDays => maxLeaveDays - leaveDays;
}
