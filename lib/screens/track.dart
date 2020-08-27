import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Track extends StatefulWidget {
  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
  int current_step = 0;
  List<Step> steps = [
    Step(
      title: Text('Delivery'),
      content: Text('Delivery'),
      isActive: true,
    ),
    Step(
      title: Text('OUT OF Delivery'),
      isActive: true,
      content: Text('OUT OF Delivery'),
    ),
    Step(
      title: Text("Order Shipping"),
      state: StepState.complete,
      content:  Text("Order Shipping"),
      isActive: true,
    ),
    Step(
      title: Text("Delivered"),
      state: StepState.complete,
      content: Text("Delivered"),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Track Order",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
        ),
      ),
body:  Container(
  child: Stepper(
    currentStep: this.current_step,
    steps: steps,
    type: StepperType.vertical,
    onStepTapped: (step) {
      setState(() {
        current_step = step;
      });
    },
    onStepContinue: () {
      setState(() {
        if (current_step < steps.length - 1) {
          current_step = current_step + 1;
        } else {
          current_step = 0;
        }
      });
    },
    onStepCancel: () {
      setState(() {
        if (current_step > 0) {
          current_step = current_step - 1;
        } else {
          current_step = 0;
        }
      });
    },
  ),
),
      //here
    );
  }
}
