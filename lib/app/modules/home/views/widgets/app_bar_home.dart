import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../controllers/home_controller.dart';

//AppBar
class AppBarFit extends StatelessWidget {
  const AppBarFit({
    super.key,
    required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 80,
      color: Colors.transparent,
      child: Row(
        children: [
          //========================================= fit aja logo and icon search =======================
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            color: Colors.transparent,
            height: 60,
            //================== obx if press search and close ========================
            child: Obx(
              () => controller.isSearchAppBar.value
                  //=========== Row True =======
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: 40,
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            autocorrect: false,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.isSearchAppBar.value = false;
                                },
                                icon: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 30,
                          child: IconButton(
                            color: Colors.white,
                            iconSize: 25,
                            onPressed: () {},
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ],
                    )
                  : //=========== Row False =======
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage("assets/logo/fitaja.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        IconButton(
                          color: Colors.white,
                          iconSize: 25,
                          onPressed: () {
                            controller.isSearchAppBar.value = true;
                          },
                          icon: Icon(Icons.search_outlined),
                        ),
                      ],
                    ),
            ),
          ),
          //================================================ icon notif and person =================================
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            color: Colors.transparent,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 12.5,
                  child: IconButton(
                    iconSize: 25,
                    color: Colors.white,
                    onPressed: () {},
                    icon: Icon(Icons.notification_add_outlined),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 12.5,
                  child: IconButton(
                    color: Colors.white,
                    iconSize: 25,
                    onPressed: () {},
                    icon: Icon(Icons.person_outline),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
