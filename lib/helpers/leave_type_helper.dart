enum LeaveTypeHelper {
  sick,
  annual,
  special,
}

String leaveTypeToString(LeaveTypeHelper type) {
  switch (type) {
    case LeaveTypeHelper.sick:
      return 'Sakit';
    case LeaveTypeHelper.annual:
      return 'Tahunan';

    case LeaveTypeHelper.special:
      return 'Lainnya';
  }
}

LeaveTypeHelper stringToLeaveType(String type) {
  switch (type) {
    case 'Sakit':
      return LeaveTypeHelper.sick;
    case 'Tahunan':
      return LeaveTypeHelper.annual;
    case 'Lainnya':
      return LeaveTypeHelper.special;
    default:
      return LeaveTypeHelper.annual;
  }
}
