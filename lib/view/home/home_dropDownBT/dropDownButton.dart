import 'package:gamegoapp/utilites/index/index.dart';

class HomeDropDownButton extends StatefulWidget {
  const HomeDropDownButton({Key? key}) : super(key: key);

  @override
  State<HomeDropDownButton> createState() => _HomeDropDownButtonState();
}

class _HomeDropDownButtonState extends State<HomeDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePostController>(
      builder: (controller) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 게임모드 드랍다운 버튼
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              style: Theme.of(context).textTheme.bodyMedium,
              buttonWidth:
                  controller.selectedModeValue == '무작위 총력전' ? 150 : 100,
              dropdownWidth: 150,
              isExpanded: true,
              items: homeGameModeList.map(
                (item) {
                  return DropdownMenuItem<String>(
                    // 솔로,자유 -> 포지션과 티어 표시
                    // 일반게임 -> 포지션만 나오게
                    onTap: () {},
                    value: item,
                    child: Text(item),
                  );
                },
              ).toList(),
              value: controller.selectedModeValue,
              onChanged: controller.changeGamemode,
            ),
          ),

          SizedBox(width: 5),
          // 포지션 드랍다운 버튼
          Visibility(
            visible: controller.showPosition,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                style: Theme.of(context).textTheme.bodyMedium,
                buttonWidth: 85,
                dropdownWidth: 100,
                isExpanded: true,
                items: homePostionList.map(
                  (item) {
                    return DropdownMenuItem<String>(
                      onTap: () {},
                      // 솔로,자유 -> 포지션과 티어 표시
                      // 일반게임 -> 포지션만 나오게
                      value: item,
                      child: Text(item),
                    );
                  },
                ).toList(),
                value: controller.selectedPositionValue,
                onChanged: controller.changePosition,
              ),
            ),
          ),
          SizedBox(width: 5),
          // 티어 드랍다운 버튼
          Visibility(
            visible: controller.showTear,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                style: Theme.of(context).textTheme.bodyMedium,
                buttonWidth: controller.selectedTearValue == '다이아몬드' ||
                        controller.selectedTearValue == '플래티넘'
                    ? 110
                    : 80,
                dropdownWidth: 130,
                isExpanded: true,
                items: homeTearList
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ),
                    )
                    .toList(),
                value: controller.selectedTearValue,
                onChanged: controller.changeTear,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
