import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'libflatpak.g.dart';

class Flatpak {
  late FlatpakLibrary libFlatpak;

  static final Flatpak _instance = Flatpak._internal();

  Flatpak._internal() {
    final libFlatpakLib = DynamicLibrary.open('libflatpak.so');
    libFlatpak = FlatpakLibrary(libFlatpakLib);
  }

  factory Flatpak() => _instance;

  /// Get the version of the Flatpak library
  ///
  String version() {
    return '$FLATPAK_MAJOR_VERSION.$FLATPAK_MINOR_VERSION.$FLATPAK_MICRO_VERSION';
  }

  /// Get a list of supported architectures
  ///
  List<String> getSupportedArches() {
    Pointer<Pointer<Char>> supportedArches = libFlatpak.flatpak_get_supported_arches();

    List<String> supportedArchesList = [];
    int index = 0;

    while (true) {
      Pointer<Char> archPtr = (supportedArches + index).value;
      if (archPtr == nullptr) break;
      String arch = archPtr.cast<Utf8>().toDartString();
      supportedArchesList.add(arch);
      index++;
    }

    malloc.free(supportedArches);

    return supportedArchesList;
  }
}
