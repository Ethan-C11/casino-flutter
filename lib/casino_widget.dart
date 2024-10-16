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
  late List<int> _casinoResult = [0, 0, 0];
  late List<String> _casinoImages;
  jackpotType? _isJackpot = null;

  @override
  void initState() {
    List<int> casinoResult = CasinoIndex.playCasino();
    setCasinoResult(casinoResult[0], casinoResult[1], casinoResult[2]);
    _casinoImages = [CasinoIndex.imageSelector(_casinoResult[0]), CasinoIndex.imageSelector(_casinoResult[1]), CasinoIndex.imageSelector(_casinoResult[2])];
    super.initState();
  }

  void setCasinoResult(int slot1, int slot2, int slot3) {
    setState(() {
      _casinoResult = [slot1, slot2, slot3];
    });
  }

  void setCasinoImages(int slot1, int slot2, int slot3) {
    setState(() {
      _casinoImages = [CasinoIndex.imageSelector(slot1), CasinoIndex.imageSelector(slot2), CasinoIndex.imageSelector(slot3)];
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
    setCasinoImages(casinoResult[0], casinoResult[1], casinoResult[2]);
    setIsJackpot(CasinoIndex.isJackpot(casinoResult));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle winningSentenceStyle() {
      return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    }

    Widget casinoDisplay() {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Image(
              image: AssetImage("images/${_casinoImages[0]}"),
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Image(
              image: AssetImage("images/${_casinoImages[1]}"),
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Image(
              image: AssetImage("images/${_casinoImages[2]}"),
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
          ),
        ),
      ]);
    }

    Widget cleanBuild() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          casinoDisplay(),
          Builder(
            builder: (context) {
              switch (_isJackpot) {
                case jackpotType.notJackpot:
                  return Text('You lost, try again !',
                      style: winningSentenceStyle());
                case jackpotType.jackpot:
                  return Text('Jackpot', style: winningSentenceStyle());
                case jackpotType.tripleSeven:
                  return Text('SUPER JACKPOT !!!',
                      style: winningSentenceStyle());
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
