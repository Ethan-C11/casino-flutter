import 'package:flutter/material.dart';
import './casino_index.dart';
import 'enum_jackpot.dart';

class CasinoWidget extends StatefulWidget {
  const CasinoWidget({super.key, required this.title});

  final String title;

  @override
  State<CasinoWidget> createState() => _CasinoWidgetState();
}

class _CasinoWidgetState extends State<CasinoWidget> {
  List<int> _casinoResult = [0, 0, 0];
  jackpotType? _isJackpot = null;

  void setCasinoResult(int slot1, int slot2, int slot3) {
    setState(() {
      _casinoResult = [slot1, slot2, slot3];
    });
  }

  void setIsJackpot(jackpotType type) {
    setState(() {
      _isJackpot = type;
    });
  }

  void _onButtonPressed() {
    List<int> casinoResult = CasinoIndex.playCasino();
    setCasinoResult(casinoResult[0], casinoResult[1], casinoResult[2]);
    setIsJackpot(CasinoIndex.isJackpot(casinoResult));
  }

  @override
  Widget build(BuildContext context) {

    TextStyle winningSentenceStyle() {
      return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    }

    Widget cleanBuild() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_casinoResult.toString()),
          Builder(
            builder: (context) {
              switch (_isJackpot) {
                case jackpotType.notJackpot:
                  return Text('You lost, try again !', style: winningSentenceStyle());
                case jackpotType.jackpot:
                  return Text('Jackpot', style: winningSentenceStyle());
                case jackpotType.tripleSeven:
                  return Text('SUPER JACKPOT !!!', style: winningSentenceStyle());
                default:
                  return const Text('');
              }
            },
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: cleanBuild()),
      floatingActionButton: FloatingActionButton(
          onPressed: _onButtonPressed,
          tooltip: 'Play',
          child: const Icon(Icons.loop)),
    );
  }
}
