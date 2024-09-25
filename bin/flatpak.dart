import 'package:flatpak/libflatpak.dart';

void main() {
  Flatpak flatpak = Flatpak();
  print("Flatpak version: ${flatpak.version()}");
  print("Supported arches: ${flatpak.getSupportedArches()}");
}
