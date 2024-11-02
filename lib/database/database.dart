import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'userd.dart'; // 引入 UserHome 模型
import 'User.dart';  // 引入 User 模型

class UserDatabase {
  // 单例模式，确保数据库类只有一个实例
  static final UserDatabase _instance = UserDatabase._internal();
  factory UserDatabase() => _instance;
  UserDatabase._internal();

  static Database? _database; // 存储数据库实例

  // 获取数据库实例
  Future<Database> get database async {
    if (_database != null) return _database!; // 如果实例已存在，直接返回
    _database = await _initDatabase(); // 初始化数据库
    return _database!; // 返回数据库实例
  }

  // 初始化数据库
  Future<Database> _initDatabase() async {
    // 获取应用文档目录
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // 拼接数据库文件路径
    String path = join(documentsDirectory.path, 'merged_database.db');

    // 打开或创建数据库
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // 创建 user_home 表
        await db.execute('''CREATE TABLE user_home (
          id INTEGER PRIMARY KEY AUTOINCREMENT,  -- 用户唯一ID
          username TEXT NOT NULL UNIQUE,         -- 用户名，不能为空且唯一
          password TEXT NOT NULL,                -- 密码，不能为空
          imagePath TEXT,                        -- 用户头像路径
          signature TEXT,                        -- 用户签名
          name TEXT                              -- 用户姓名
        );''');

        // 创建 users 表
        await db.execute('''CREATE TABLE users (
          username TEXT PRIMARY KEY,  -- 用户名，主键
          password TEXT NOT NULL       -- 密码，不能为空
        );''');
      },
    );
  }

  // 插入 UserHome 信息
  Future<void> insertUserHome(UserHome user) async {
    final db = await database; // 获取数据库实例
    await db.insert(
      'user_home', // 表名
      user.toMap(), // 转换为 Map 格式
      conflictAlgorithm: ConflictAlgorithm.replace, // 如果有冲突则替换
    );
  }

  // 根据用户名获取用户信息
  Future<UserHome?> getUserHomeByUsername(String username) async {
    final db = await database; // 获取数据库实例
    final List<Map<String, dynamic>> maps = await db.query(
      'user_home',
      where: 'username = ?', // 条件：用户名
      whereArgs: [username], // 条件参数
    );

    return maps.isNotEmpty ? UserHome.fromMap(maps.first) : null; // 返回用户信息
  }

  // 更新用户信息
  Future<int> updateUserHome(UserHome user) async {
    final db = await database; // 获取数据库实例
    return await db.update(
      'user_home',
      user.toMap(), // 转换为 Map 格式
      where: 'username = ?', // 条件：用户名
      whereArgs: [user.username], // 条件参数
    );
  }

  // 删除用户
  Future<int> deleteUserByUsername(String username) async {
    final db = await database; // 获取数据库实例
    return await db.delete(
      'user_home',
      where: 'username = ?', // 条件：用户名
      whereArgs: [username], // 条件参数
    );
  }

  // 验证旧密码
  Future<bool> validateOldPassword(String username, String oldPassword) async {
    final db = await database; // 获取数据库实例
    final List<Map<String, dynamic>> maps = await db.query(
      'user_home',
      where: 'username = ? AND password = ?', // 条件：用户名和密码
      whereArgs: [username, oldPassword], // 条件参数
    );
    return maps.isNotEmpty; // 返回是否验证成功
  }

  // 更新用户密码
  Future<void> updateUserPassword(String username, String newPassword) async {
    final db = await database; // 获取数据库实例
    await db.update(
      'user_home',
      {'password': newPassword}, // 更新的字段
      where: 'username = ?', // 条件：用户名
      whereArgs: [username], // 条件参数
    );
  }

  // 插入 User 信息
  Future<int> insertUser(User user) async {
    final db = await database; // 获取数据库实例
    try {
      return await db.insert('users', user.toMap()); // 插入用户数据
    } catch (e) {
      print('插入用户时出错: $e'); // 错误处理
      return -1; // 返回错误标识
    }
  }

  // 获取所有 User 信息
  Future<List<User>> getAllUsers() async {
    final db = await database; // 获取数据库实例
    final List<Map<String, dynamic>> maps = await db.query('users'); // 查询所有用户
    return List.generate(maps.length, (i) => User.fromMap(maps[i])); // 返回用户列表
  }

  // 通过用户名获取 User
  Future<User?> getUserByUsername(String username) async {
    final db = await database; // 获取数据库实例
    try {
      List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'username = ?', // 条件：用户名
        whereArgs: [username], // 条件参数
      );
      return result.isNotEmpty ? User.fromMap(result.first) : null; // 返回用户信息
    } catch (e) {
      print('查询用户时出错: $e'); // 错误处理
      return null; // 返回空
    }
  }
}
