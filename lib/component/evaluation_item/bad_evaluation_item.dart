import 'package:mannergamer/utilites/index/index.dart';

class CustomBadEvaluationItem extends StatelessWidget {
  final int element;
  final String title;

  const CustomBadEvaluationItem({
    required this.element,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    //동일 항목이 2개 이상인 경우에만 표시
    return element >= 2
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
