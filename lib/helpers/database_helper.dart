import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:aqua_task/models/leave_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'leave_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE leaves(id INTEGER PRIMARY KEY AUTOINCREMENT, employeeName TEXT, reason TEXT, startDate TEXT, endDate TEXT, leaveType TEXT)',
        );
        await db.execute(
          'CREATE TABLE remaining_leave_days(id INTEGER PRIMARY KEY, days INTEGER)',
        );
        await db.insert(
            'remaining_leave_days', {'id': 1, 'days': LeaveModel.maxLeaveDays});
      },
    );
  }

  Future<void> insertLeave(LeaveModel leave) async {
    final db = await database;
    await db.insert(
      'leaves',
      leave.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    int leaveDays = leave.leaveDays;
    final remainingLeaveDays = LeaveModel.maxLeaveDays - leaveDays;

    await db.rawUpdate('UPDATE remaining_leave_days SET days = ? WHERE id = 1',
        [remainingLeaveDays]);
  }

  Future<List<LeaveModel>> getLeaves() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('leaves');

    return List.generate(maps.length, (i) {
      return LeaveModel.fromMap(maps[i]);
    });
  }

  Future<void> updateLeave(LeaveModel leave) async {
    final db = await database;
    await db.update(
      'leaves',
      leave.toMap(),
      where: 'id = ?',
      whereArgs: [leave.id],
    );
  }

  Future<void> deleteLeave(int id) async {
    final db = await database;
    await db.delete(
      'leaves',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateRemainingLeaveDays(int remainingDays) async {
    final db = await database;
    await db.rawUpdate('UPDATE remaining_leave_days SET days = ? WHERE id = 1',
        [remainingDays]);
  }

  Future<int> getRemainingLeaveDays() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('remaining_leave_days');
    if (result.isNotEmpty) {
      return result.first['days'];
    } else {
      return 0;
    }
  }

  Future<void> saveRemainingLeaveDays() async {
    final remainingDays = await getRemainingLeaveDays();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remaining_leave_days', remainingDays);
  }

  Future<int> loadRemainingLeaveDays() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('remaining_leave_days') ?? 0;
  }

  Future<void> resetRemainingLeaveDays() async {
    final db = await database;
    await db.rawUpdate('UPDATE remaining_leave_days SET days = ? WHERE id = 1',
        [LeaveModel.maxLeaveDays]);
  }

  Future<void> removeAllLeaves() async {
    final db = await database;
    await db.delete('leaves');
    await resetRemainingLeaveDays();
  }
}
