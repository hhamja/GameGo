import 'package:mannergamer/utilites/index/index.dart';

class MannerAgePage extends StatefulWidget {
  final mannerAge; //현재유저 매너나이
  const MannerAgePage({Key? key, required this.mannerAge}) : super(key: key);

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
          value: double.parse(widget.mannerAge),
          color: Colors.blue,
          thickness: 20,
          edgeStyle: LinearEdgeStyle.bothCurve,
        )
      ],
    );
  }
}
