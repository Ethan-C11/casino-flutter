import 'package:flutter/material.dart';
import './casino_index.dart';


class CasinoWidget extends StatefulWidget {
  const CasinoWidget({super.key, required this.title});
  final String title;

  @override
  State<CasinoWidget> createState() => _CasinoWidgetState();
}

class _CasinoWidgetState extends State<CasinoWidget> {
  List<int> _casinoResult = [0,0,0];

  void setCasinoResult(int slot1, int slot2, int slot3) {
    setState(() {
      _casinoResult = [slot1, slot2, slot3];
    });
  }

  void _onButtonPressed() {
    List<int> casinoResult = CasinoIndex.playCasino();
    setCasinoResult(casinoResult[0], casinoResult[1], casinoResult[2]);
  }

  @override
  Widget build(BuildContext context) {

    Widget cleanBuild() {
      return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_casinoResult.toString())
          ],
        );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center( child: cleanBuild()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onButtonPressed,
        tooltip: 'Play',
        child: const Icon(Icons.loop)
      ),
    );
  }
}
