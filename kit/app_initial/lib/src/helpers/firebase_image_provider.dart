import 'dart:async';
import 'dart:ui' as ui;

import 'package:app_initial/src/datasources/storage/storage.dart';
import 'package:app_initial/src/repositories/storage/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class FirebaseImageProvider extends ImageProvider<Uri> {
  const FirebaseImageProvider(this.path);

  final String path;

  static final StorageRepository _storageRepository =
      StorageRepositoryImpl(storageDatasource: StorageFirebaseDatasource());

  @override
  Future<Uri> obtainKey(ImageConfiguration configuration) {
    final result = Uri.parse(path).replace(
      queryParameters: <String, String>{
        'dpr': '${configuration.devicePixelRatio}',
        'locale': '${configuration.locale?.toLanguageTag()}',
        'platform': '${configuration.platform?.name}',
        'width': '${configuration.size?.width}',
        'height': '${configuration.size?.height}',
        'bidi': '${configuration.textDirection?.name}',
      },
    );
    return SynchronousFuture<Uri>(result);
  }

  @override
  ImageStreamCompleter loadImage(
    Uri key,
    ImageDecoderCallback decode,
  ) {
    final chunkEvents = StreamController<ImageChunkEvent>()
      ..add(
        // add this event to start the loadingBuilder
        const ImageChunkEvent(
          cumulativeBytesLoaded: 0,
          expectedTotalBytes: null,
        ),
      );

    final futureBytes = _storageRepository
        .read(filename: path)
        .then<Uint8List>((Uint8List? data) async {
      if (data == null) {
        throw Exception('Failed to fetch image from Firebase: $path');
      }

      chunkEvents.add(
        ImageChunkEvent(
          cumulativeBytesLoaded: data.length,
          expectedTotalBytes: data.length,
        ),
      );
      return data;
    }).catchError((Object error, StackTrace stack) {
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      return Future<Uint8List>.error(error, stack);
    }).whenComplete(chunkEvents.close);

    final codecFuture = futureBytes
        .then<ui.ImmutableBuffer>(ui.ImmutableBuffer.fromUint8List)
        .then<ui.Codec>(decode);

    return MultiFrameImageStreamCompleter(
      codec: codecFuture,
      chunkEvents: chunkEvents.stream,
      scale: 1,
      debugLabel: 'FirebaseImage("$key")',
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<ImageProvider>('Image provider', this),
        DiagnosticsProperty<Uri>('URL', key),
      ],
    );
  }

  @override
  String toString() => '${objectRuntimeType(this, 'FirebaseImage')}("$path")';
}
