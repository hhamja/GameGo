import 'package:mannergamer/utilites/index.dart';

class CreatePostDropDownButton extends StatelessWidget {
  const CreatePostDropDownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePostDropDownBTController>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /* 게임모드 드랍다운버튼 */
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Text(
                '게임모드',
              ),
              items: gameModes2
                  .map(
                    (modeItem) => DropdownMenuItem<String>(
                      value: modeItem,
                      child: Text(
                        modeItem,
                      ),
                    ),
                  )
                  .toList(),
              value: controller.seledtedPostGamemodeValue,
              onChanged: controller.showPositonAndTear,
              buttonHeight: 60,
              itemHeight: 50,
            ),
          ),
          /* 포지션 드랍다운버튼 */
          Visibility(
            visible: controller.showPosition,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text(
                  '포지션',
                ),
                items: postions2
                    .map(
                      (positionItem) => DropdownMenuItem<String>(
                        value: positionItem,
                        child: Text(
                          positionItem,
                        ),
                      ),
                    )
                    .toList(),
                value: controller.seledtedPostdPositionValue,
                onChanged: (positionValue) {
                  controller.seledtedPostdPositionValue =
                      positionValue as String;
                  controller.update();
                },
                buttonHeight: 60,
                itemHeight: 50,
              ),
            ),
          ),
          //티어 드랍다운버튼
          Visibility(
            visible: controller.showTear,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text(
                  '티어',
                ),
                items: tears2
                    .map(
                      (tearItem) => DropdownMenuItem<String>(
                        value: tearItem,
                        child: Text(tearItem),
                      ),
                    )
                    .toList(),
                value: controller.seledtedPostTearValue,
                onChanged: (tearValue) {
                  controller.seledtedPostTearValue = tearValue as String;
                  controller.update();
                },
                buttonHeight: 60,
                itemHeight: 50,
              ),
            ),
          ),
        ],
      );
    });
  }
}
