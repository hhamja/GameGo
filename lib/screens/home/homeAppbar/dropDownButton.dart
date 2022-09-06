import 'package:mannergamer/utilites/index.dart';

class HomeDropDownButton extends StatefulWidget {
  const HomeDropDownButton({Key? key}) : super(key: key);

  @override
  State<HomeDropDownButton> createState() => _HomeDropDownButtonState();
}

class _HomeDropDownButtonState extends State<HomeDropDownButton> {
  bool _showPosition = false;
  bool _showTear = false;

  var selectedModeValue;
  var selectedPositionValue;
  var selectedTearValue;

  _showPositonAndTear() {
    if (selectedModeValue == '솔로랭크' || selectedModeValue == '자유랭크') {
      _showPosition = true;
      _showTear = true;
    } else if (selectedModeValue == '일반게임') {
      _showPosition = true;
      _showTear = false;
    } else {
      _showPosition = false;
      _showTear = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //게임모드
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            buttonWidth: selectedModeValue == '무작위 총력전' ? 125 : 85,
            dropdownWidth: 130,
            isExpanded: true,
            hint: Text('게임모드'),
            items: gameModes
                .map(
                  (item) => DropdownMenuItem<String>(
                    onTap: () {}, // 솔로,자유 -> 포지션과 티어 표시, 일반게임 -> 포지션만 나오게
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            value: selectedModeValue,
            onChanged: (value) {
              setState(() {
                selectedModeValue = value as String;
                _showPositonAndTear();
              });
            },
          ),
        ),
        SizedBox(width: 10),

        //포지션
        Visibility(
          visible: _showPosition,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              buttonWidth: 70,
              dropdownWidth: 100,
              isExpanded: true,
              hint: Text('포지션'),
              items: postions
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              value: selectedPositionValue,
              onChanged: (value) {
                setState(() {
                  selectedPositionValue = value as String;
                  _showPositonAndTear();
                });
              },
            ),
          ),
        ),
        SizedBox(width: 10),

        //티어
        Visibility(
          visible: _showTear,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              buttonWidth: 70,
              dropdownWidth: 110,
              isExpanded: true,
              hint: Text('티어'),
              items: tears
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              value: selectedTearValue,
              onChanged: (value) {
                setState(() {
                  selectedTearValue = value as String;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
