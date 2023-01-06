import 'package:mannergamer/utilites/index/index.dart';

class CustomGoodEvaluationItem extends StatelessWidget {
  final int element;
  final String title;

  const CustomGoodEvaluationItem({
    required this.element,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return element.toInt() != 0
        ? ListTile(
            title: Text(title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.people_alt_outlined),
                SizedBox(width: 5),
                Text('$element'),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
