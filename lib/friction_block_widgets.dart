import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FrictionBlockWidgets extends StatefulWidget {
  const FrictionBlockWidgets({super.key});

  @override
  State<FrictionBlockWidgets> createState() => _FrictionBlockWidgetsState();
}

class _FrictionBlockWidgetsState extends State<FrictionBlockWidgets>
    with TickerProviderStateMixin {
  late AnimationController blockAnimataionController;

  @override
  void initState() {
    blockAnimataionController = AnimationController.unbounded(vsync: this);
    super.initState();
  }

  void _nundgeBlock() {
    FrictionSimulation movingSimulation = FrictionSimulation(
        tolerance: Tolerance.defaultTolerance, drag, postion, velocity);
    blockAnimataionController.animateWith(movingSimulation);
  }

  void _resetBlock() {
    FrictionSimulation nonMovingSimulation =
        FrictionSimulation(tolerance: Tolerance.defaultTolerance, 0, 0, 0);
    blockAnimataionController.animateWith(nonMovingSimulation);
  }

  double drag = 1;
  double postion = 1;
  double velocity = 100;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Drag"),
        Slider(
            divisions: 5,
            activeColor: Colors.green,
            inactiveColor: Colors.green.withOpacity(0.2),
            value: 1.0,
            min: 0.0,
            max: 10.0,
            onChanged: (value) {
              setState(() {
                value = drag;
              });
            }),
        const Text("Position"),
        Slider(
            activeColor: Colors.green,
            inactiveColor: Colors.green.withOpacity(0.2),
            value: 1.0,
            min: 0.0,
            max: 10.0,
            onChanged: (value) {
              setState(() {
                value = postion;
              });
            }),
        const Text("Velocity"),
        Slider(
            activeColor: Colors.green,
            inactiveColor: Colors.green.withOpacity(0.2),
            value: 1.0,
            min: 0.0,
            max: 10.0,
            onChanged: (value) {
              setState(() {
                value = velocity;
              });
            }),
        Expanded(
          flex: 3,
          child: SizedBox(
            width: width,
            child: Stack(
              children: [
                AnimatedBuilder(
                    animation: blockAnimataionController,
                    builder: (context, snapshot) {
                      return Positioned(
                        left: width / 20 + blockAnimataionController.value,
                        bottom: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            // color: Colors.red,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/man.png"),
                            ),
                          ),
                          height: 70,
                          width: 100,
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: Colors.green,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                  ),
                  onPressed: _nundgeBlock,
                  child: const Text("Nudge"),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                  ),
                  onPressed: _resetBlock,
                  child: const Text("Reset"),
                ),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
