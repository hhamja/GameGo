import 'package:mannergamer/utilites/index.dart';

class MannerAgePage extends StatefulWidget {
  const MannerAgePage({Key? key}) : super(key: key);

  @override
  State<MannerAgePage> createState() => _MannerAgePageState();
}

class _MannerAgePageState extends State<MannerAgePage> {
  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      orientation: LinearGaugeOrientation.horizontal,
      minimum: 0,
      maximum: 100,
      interval: 0,
      labelPosition: LinearLabelPosition.inside,
      axisTrackStyle: LinearAxisTrackStyle(
        thickness: 20,
        edgeStyle: LinearEdgeStyle.bothCurve,
      ),
      barPointers: [
        LinearBarPointer(
          value: currentAgeValue,
          color: Colors.blue,
          thickness: 20,
          edgeStyle: LinearEdgeStyle.bothCurve,
        )
      ],
    );
  }
}
