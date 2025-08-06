import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class NeuraWidget extends StatefulWidget {
  final double width;
  final double height;
  const NeuraWidget({this.width = 200, this.height = 200, Key? key}) : super(key: key);

  @override
  _NeuraWidgetState createState() => _NeuraWidgetState();
}

class _NeuraWidgetState extends State<NeuraWidget> {
  Artboard? _artboard;
  late StateMachineController _controller;
  final Map<String, SMIInput<bool>> _boolInputs = {};
  final Map<String, SMIInput<double>> _numberInputs = {};
  final Map<String, SMIInput<bool>> _triggerInputs = {};

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final data = await rootBundle.load('assets/animations/neura_states.riv');
    final file = RiveFile.import(data);
    final artboard = file.mainArtboard;
    final controller = StateMachineController.fromArtboard(artboard, 'NeuraStates')!;
    artboard.addController(controller);
    for (var input in controller.inputs) {
      if (input is SMIBool) _boolInputs[input.name] = input;
      if (input is SMITrigger) _triggerInputs[input.name] = input;
      if (input is SMIInput<double>) _numberInputs[input.name] = input;
    }
    setState(() {
      _artboard = artboard;
      _controller = controller;
    });
  }

  void setMood(String mood, {double? blend}) {
    // reset booleans
    _boolInputs.forEach((_, input) => input.value = false);
    // boolean or trigger
    if (_boolInputs.containsKey(mood)) {
      _boolInputs[mood]!.value = true;
    } else if (_triggerInputs.containsKey(mood)) {
      _triggerInputs[mood]!.fire();
    }
    // number blend
    if (blend != null && _numberInputs.containsKey('blend')) {
      _numberInputs['blend']!.value = blend;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _artboard == null
        ? SizedBox(width: widget.width, height: widget.height)
        : SizedBox(
            width: widget.width,
            height: widget.height,
            child: Rive(artboard: _artboard!),
          );
  }
}
