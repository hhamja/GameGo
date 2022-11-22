import 'package:mannergamer/utilites/index/index.dart';

class HomeDropDownButton extends StatefulWidget {
  const HomeDropDownButton({Key? key}) : super(key: key);

  @override
  State<HomeDropDownButton> createState() => _HomeDropDownButtonState();
}

class _HomeDropDownButtonState extends State<HomeDropDownButton> {
  /* Put -> DropDwon Button Controller */
  HomePageDropDownBTController homeDropDownBTController =
      Get.put(HomePageDropDownBTController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageDropDownBTController>(
      builder: (controller) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /* 게임모드 드랍다운 버튼 */
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              buttonWidth: controller.selectedModeValue == '무작위 총력전' ? 125 : 85,
              dropdownWidth: 130,
              isExpanded: true,
              items: gameModes.map(
                (item) {
                  return DropdownMenuItem<String>(
                    onTap: () {}, // 솔로,자유 -> 포지션과 티어 표시, 일반게임 -> 포지션만 나오게
                    value: item,
                    child: Text(item),
                  );
                },
              ).toList(),
              value: controller.selectedModeValue,
              onChanged: controller.changeGamemode,
            ),
          ),
          SizedBox(width: 10),

          /* 포지션 드랍다운 버튼*/
          Visibility(
            visible: controller.showPosition,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                buttonWidth: 70,
                dropdownWidth: 100,
                isExpanded: true,
                items: postions.map(
                  (item) {
                    return DropdownMenuItem<String>(
                      onTap: () {},
                      // 솔로,자유 -> 포지션과 티어 표시, 일반게임 -> 포지션만 나오게
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
          SizedBox(width: 10),
          /* 티어 드랍다운 버튼*/
          Visibility(
            visible: controller.showTear,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                buttonWidth: controller.selectedTearValue == '다이아몬드' ||
                        controller.selectedTearValue == '플래티넘'
                    ? 100
                    : 70,
                dropdownWidth: 110,
                isExpanded: true,
                items: tears
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