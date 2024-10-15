import 'dart:math';

class CasinoIndex {

  static List<int> playCasino() {
     return [Random().nextInt(8), Random().nextInt(8), Random().nextInt(8)];
  }
}