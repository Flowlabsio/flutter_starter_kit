import 'dart:typed_data';

abstract class StorageDatasource {
  Future<void> write({
    required String filename,
    required Uint8List bytes,
  });

  Future<Uint8List> read({
    required String filename,
  });

  Future<void> delete({required String filename});

  Future<void> deleteAll({required String path});
}
