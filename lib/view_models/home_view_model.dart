import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aqua_task/constant/color_constant.dart';
import 'package:aqua_task/helpers/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aqua_task/helpers/database_helper.dart';
import 'package:aqua_task/helpers/leave_type_helper.dart';
import 'package:aqua_task/models/leave_model.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeViewModel extends GetxController {
  Rxn<String> username = Rxn<String>();
  Rxn<String> usernameErrorText = Rxn<String>();
  Rx<bool> isUsernameValid = Rx<bool>(false);
  Rx<bool> isFormValid = Rx<bool>(false);
  Rx<bool> isLoading = Rx<bool>(false);
  RxString profilePicturePath = ''.obs;
  Rxn<File> imageFile = Rxn<File>();
  final TextEditingController usernameController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();

  final ImagePicker _picker = ImagePicker();

  final Rxn<String> reason = Rxn<String>();
  final Rxn<String> reasonErrorText = Rxn<String>();
  final Rx<bool> isReasonValid = Rx<bool>(false);
  final Rx<FocusNode> reasonFocusNode = FocusNode().obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final RxList<LeaveModel> leaves = <LeaveModel>[].obs;
  final Rx<TextEditingController> reasonController =
      TextEditingController().obs;
  final Rx<DateTime?> startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> endDate = Rx<DateTime?>(null);
  final Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  final Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);
  final Rx<RangeSelectionMode> rangeSelectionMode =
      RangeSelectionMode.toggledOn.obs;
  final Rx<LeaveTypeHelper> selectedLeaveType = LeaveTypeHelper.annual.obs;
  final Rx<int> remainingLeaveDays = 12.obs;
  Rx<bool> isLeaveValid = Rx<bool>(false);

  @override
  void onInit() {
    usernameController.addListener(validateForm);
    usernameFocusNode.addListener(() => update());
    loadProfileData();
    fetchLeaves();

    super.onInit();
  }

  void validateUsername(String value) {
    if (value.isEmpty) {
      usernameErrorText.value = 'Nama tidak boleh kosong';
      isUsernameValid.value = false;
    } else if (value.length < 3) {
      usernameErrorText.value = 'Nama harus minimal 3 karakter';
      isUsernameValid.value = false;
    } else if (RegExp(r'[^a-zA-Z0-9\s]').hasMatch(value)) {
      usernameErrorText.value = 'Nama tidak boleh mengandung karakter spesial';
      isUsernameValid.value = false;
    } else {
      usernameErrorText.value = null;
      isUsernameValid.value = true;
    }
    validateForm();
  }

  void validateForm() {
    if (isUsernameValid.value) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  Future<void> loadProfileData() async {
    final savedUsername = await SharedPrefHelper.getUsername();
    final savedProfilePicturePath =
        await SharedPrefHelper.getProfilePicturePath();

    username.value = savedUsername;
    usernameController.text = savedUsername;

    if (savedProfilePicturePath != null && savedProfilePicturePath.isNotEmpty) {
      profilePicturePath.value = savedProfilePicturePath;
      imageFile.value = File(savedProfilePicturePath);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilePicturePath.value = pickedFile.path;
      imageFile.value = File(pickedFile.path);
      SharedPrefHelper.saveProfilePicturePath(pickedFile.path);
    }
  }

  Future<void> saveChanges() async {
    isLoading.value = true;
    await Future.delayed(
      const Duration(seconds: 1),
      () async {
        isLoading.value = false;
        if (usernameController.text.isNotEmpty) {
          await SharedPrefHelper.saveUsername(usernameController.text);
          username.value = usernameController.text;
          if (imageFile.value != null) {
            await SharedPrefHelper.saveProfilePicturePath(
                imageFile.value!.path);
          }
        }
      },
    );
  }

  Future<void> clearUserData() async {
    await SharedPrefHelper.clearUserData();
    username.value = null;
    profilePicturePath.value = '';
    imageFile.value = null;
    usernameController.clear();
    _dbHelper.removeAllLeaves();
  }

  Future<void> fetchLeaves() async {
    final fetchedLeaves = await _dbHelper.getLeaves();
    leaves.assignAll(fetchedLeaves);
  }

  Future<void> addLeave() async {
    final newLeave = LeaveModel(
      employeeName: usernameController.value.text,
      reason: reasonController.value.text,
      startDate: startDate.value ?? DateTime.now(),
      endDate: endDate.value ?? DateTime.now(),
      leaveType: selectedLeaveType.value,
    );

    isLoading.value = true;
    isLeaveValid.value = false;

    await Future.delayed(const Duration(seconds: 1), () async {
      isLoading.value = false;
      Get.back();

      int leaveDays =
          endDate.value!.difference(startDate.value ?? DateTime.now()).inDays +
              1;

      if (isLeaveDaysValid(leaveDays)) {
        reduceLeaveDays(leaveDays);

        await _dbHelper.insertLeave(newLeave);
        reasonController.value.clear();
        startDate.value = null;
        endDate.value = null;
        fetchLeaves();
        fetchRemainingLeaveDays();
      } else {
        Get.snackbar(
          'Kuota tidak mencukupi',
          'Jumlah hari cuti melebihi sisa cuti yang tersedia',
          backgroundColor: ColorConstant.primary,
          colorText: ColorConstant.backgroundColor,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 16,
          margin: const EdgeInsets.all(16),
          borderWidth: 2,
          borderColor: ColorConstant.backgroundColor,
          isDismissible: true,
          duration: const Duration(seconds: 2),
          animationDuration: const Duration(milliseconds: 400),
          forwardAnimationCurve: Curves.fastOutSlowIn,
          reverseAnimationCurve: Curves.easeOut,
          icon: const Icon(
            Icons.info_outline,
            color: ColorConstant.backgroundColor,
          ),
          shouldIconPulse: true,
        );
      }
    });
  }

  Future<void> deleteLeave(int id) async {
    await _dbHelper.deleteLeave(id);
    fetchLeaves();
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy', 'id_ID').format(date);
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    if (start != null) {
      startDate.value = start;
      selectedStartDate.value = start;
      if (end != null) {
        endDate.value = end;
        selectedEndDate.value = end;
      } else {
        endDate.value = start;
        selectedEndDate.value = start;
      }
    }
  }

  void validateReason(String value) {
    int wordCount = value.trim().split(' ').length;
    int remainingWords = 10 - wordCount;

    if (value.isEmpty) {
      reasonErrorText.value = 'Keterangan tidak boleh kosong';
      isReasonValid.value = false;
    } else if (wordCount < 10) {
      reasonErrorText.value =
          'Keterangan harus minimal 10 kata, kurang $remainingWords kata lagi';
      isReasonValid.value = false;
    } else {
      reasonErrorText.value = null;
      isReasonValid.value = true;
    }
    validateLeave();
  }

  void reduceLeaveDays(int days) {
    remainingLeaveDays.value -= days;
    _dbHelper.updateRemainingLeaveDays(remainingLeaveDays.value);
    if (kDebugMode) {
      print('Nilai sisa cuti setelah pengurangan: ${remainingLeaveDays.value}');
    }
  }

  bool isLeaveDaysValid(int days) {
    return days <= remainingLeaveDays.value;
  }

  Future<void> init() async {
    remainingLeaveDays.value = await _dbHelper.loadRemainingLeaveDays();
  }

  void fetchRemainingLeaveDays() async {
    final dbHelper = DatabaseHelper();
    remainingLeaveDays.value = await dbHelper.getRemainingLeaveDays();
  }

  void validateLeave() {
    if (isReasonValid.value && startDate.value != null) {
      isLeaveValid.value = true;
    } else {
      isLeaveValid.value = false;
    }
  }
}
