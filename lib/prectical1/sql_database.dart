import 'package:prectical/prectical1/profile_model.dart';
import 'package:sqflite/sqflite.dart';

class SqlDataBase {
  static final SqlDataBase sqlDataBase = SqlDataBase._();

  SqlDataBase._();

  static Database? database;
  String databaseName='profile.db';
  String profileTable='profile';

  Future<Database?> profileDatabase() async {
    if (database != null) {
      return database;
    }
    database =await initDataBase();
    return database;
  }

  Future<Database> initDataBase() async {
    final dataBasePath=await getDatabasesPath();
    final profileDataBasePath='$dataBasePath/$databaseName';
    return await openDatabase(profileDataBasePath,version: 1,onCreate: createDatabase);
  }

  Future<void> createDatabase(Database db, int version) async {
    return await db.execute('CREATE TABLE $profileTable(id INTEGER PRIMARY KEY, name TEXT, email TEXT, mobileNo INTEGER, date TEXT, day TEXT)');
  }

  void insertProfile(ProfileModel data) async {
    final db = await profileDatabase();
    int res=await db!.insert(profileTable, data.toJson());
    print('insert=-=-=${res}');
  }

  Future<List<ProfileModel>> read() async {
    final db = await profileDatabase();
    List data = await db!.rawQuery('SELECT * FROM $profileTable');
    List<ProfileModel> profileList=[];
    profileList=data.map((e) => ProfileModel  .fromJson(e)).toList();
    return profileList;
  }

  Future<List<ProfileModel>> readFilter(String day) async {
    final db = await profileDatabase();
    List data = await db!.rawQuery('SELECT * FROM $profileTable WHERE day=?', [day]);
    List<ProfileModel> profileList=[];
    profileList=data.map((e) => ProfileModel  .fromJson(e)).toList();
    return profileList;
  }

  Future<void> update(ProfileModel data) async {
    final db = await profileDatabase();
    int res=await db!.update(
      profileTable,
      data.toJson(),
      where: 'id = ?',
      whereArgs: [data.profileId],
    );
    print('${data.mobileNo}=-=-=-');
    print('${data.email}=-=-=-');
    print('${data.date}=-=-=-');
    print('${data.profileId}=-=-=-');
    print('upadet=-=-=${res}');
  }

  Future<void> delete(String id) async {
    final db = await profileDatabase();
    await db!.delete(
      profileTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}