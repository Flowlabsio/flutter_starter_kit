import 'dart:typed_data';

import 'package:app_initial/src/datasources/storage/storage.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageFirebaseDatasource extends StorageDatasource {
  @override
  Future<void> write({
    required String filename,
    required Uint8List bytes,
  }) async {
    final ref = FirebaseStorage.instance.ref().child(filename);

    await ref.putData(bytes);
  }

  @override
  Future<Uint8List> read({required String filename}) async {
    final ref = FirebaseStorage.instance.ref().child(filename);

    final data = await ref.getData(10485760 * 2);

    if (data == null) {
      throw Exception('Image not found');
    }

    return data;
  }

  @override
  Future<void> delete({required String filename}) async {
    final ref = FirebaseStorage.instance.ref().child(filename);

    await ref.delete();
  }

  @override
  Future<void> deleteAll({required String path}) async {
    final ref = FirebaseStorage.instance.ref().child(path);

    final listResult = await ref.listAll();

    await Future.wait(listResult.items.map((fileRef) => fileRef.delete()));

    await Future.wait(
      listResult.prefixes.map((dirRef) => deleteAll(path: dirRef.fullPath)),
    );
  }
}
