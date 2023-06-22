import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';
import 'package:sync_note/util/refresh.dart';

List<Name> names = [];

class Name {
  final int id;
  final String name;

  Name({required this.id, required this.name});

  Map<String, dynamic> toJson(Name x) {
    return {"name": x.name};
  }

  static Name fromJson(Map<String, dynamic> json) {
    return Name(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }
}

class NameDataBase {
  final String dbName;
  Database? _db;

  NameDataBase({required this.dbName});

  Future<List<Name>> _fetchNames() async {
    if (_db == null) {
      return [];
    }

    try {
      final x = await _db!.query("NAMES", columns: ["id", "name"]);
      names = x.map((e) => Name.fromJson(e)).toList();
      return names;
    } catch (e) {
      log.e("FETCHING NAMES $e");
      return [];
    }
  }

  Future<bool> close() async {
    if (_db == null) {
      return false;
    }
    await _db!.close();
    return true;
  }

  Future<bool> open() async {
    if (_db != null) {
      return true;
    }

    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, dbName);

    try {
      final db = await openDatabase(path);
      _db = db;

      // create table

      await db.execute('''
  CREATE TABLE IF NOT EXISTS NAMES (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
  );
      ''');

      names = await _fetchNames();
      return true;
    } catch (e) {
      log.e("OPEN $e");
      return false;
    }
  }

  Future<bool> create(String namePar) async {
    if (_db == null) {
      return false;
    } else {
      try {
        final id = await _db!.insert("NAMES", {"name": namePar});
        final name = Name(id: id, name: namePar);
        names.insert(0, name);
        return true;
      } catch (e) {
        log.e("Insert $e");
        return false;
      }
    }
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late NameDataBase db;
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    db = NameDataBase(dbName: "name.db");
   getdata();
  }
 Future getdata()async{
  bool x = await  db.open();
  if (x) {
    names = await db._fetchNames();
    log.i("there is data ${names.length}");
  }else{
    print("no ========================");
  }
 }
  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: controller,
        ),
        leading: IconButton(
          onPressed: () async {
            await db.create(controller.text);
            Provider.of<Refresh>(context, listen: false).refresh();
          },
          icon: const Icon(Icons.plus_one),
        ),
      ),
      body: Consumer<Refresh>(
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text("${names[index].id}"),
              title: Text(names[index].name),
            );
          },
          itemCount: names.length,
        ),
      ),
    );
  }
}
