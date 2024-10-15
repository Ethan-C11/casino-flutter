import 'dart:math';
import 'enum_jackpot.dart';

class CasinoIndex {
  static List<int> playCasino() {
    return [Random().nextInt(7)+1, Random().nextInt(7)+1, Random().nextInt(7)+1];
  }

  static jackpotType isJackpot(List<int> casinoResult) {
    int slot1 = casinoResult[0];
    int slot2 = casinoResult[1];
    int slot3 = casinoResult[2];

    if (slot1 == 7 && slot2 == 7 && slot3 == 7) {
      return jackpotType.tripleSeven;
    } else if(slot1 == slot2 && slot1 == slot3 && slot3 == slot2)  {
      return jackpotType.jackpot; // pas de jackpot
    } else {
      return jackpotType.notJackpot;
    }
  }
}
