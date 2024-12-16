import 'dart:typed_data';

import 'package:app_initial/src/datasources/storage/storage.dart';
import 'package:app_initial/src/repositories/storage/storage.dart';

class StorageRepositoryImpl implements StorageRepository {
  StorageRepositoryImpl({required this.storageDatasource});

  final StorageDatasource storageDatasource;

  @override
  Future<Uint8List> read({required String filename}) {
    return storageDatasource.read(
      filename: filename,
    );
  }

  @override
  Future<void> write({
    required String filename,
    required Uint8List bytes,
  }) {
    return storageDatasource.write(
      filename: filename,
      bytes: bytes,
    );
  }

  @override
  Future<void> delete({required String filename}) {
    return storageDatasource.delete(
      filename: filename,
    );
  }

  @override
  Future<void> deleteAll({required String path}) {
    return storageDatasource.deleteAll(path: path);
  }
}
