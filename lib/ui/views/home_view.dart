import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_app/app/controllers/home_controller.dart';
import 'package:house_app/colors/palette.dart';
import 'package:house_app/widgets/device_card.dart';
import 'package:house_app/widgets/room_card.dart';
import 'package:sizer/sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Palette.grey,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.showLuaBottonSheet();
            },
            child: const Icon(Ionicons.logo_electron),
          ),
          appBar: AppBar(
            backgroundColor: Palette.grey,
            elevation: 0,
            centerTitle: false,
            title: Row(
              children: [
                Text(
                  "Casa Inteligente",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Palette.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Get.offAllNamed('/splash');
                  },
                  icon: const Icon(Icons.logout_outlined, color: Colors.black),
                ),
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.refreshData();
            },
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Palette.purpleAccent, Palette.red],
                        ),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mi Casa',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.white,
                                ),
                              ),
                              Text(
                                'Sala principal',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Palette.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '-10°',
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: Palette.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    Obx(() {
                      return Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Palette.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.selectedTab.value = 0,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  decoration: BoxDecoration(
                                    color: controller.selectedTab.value == 0
                                        ? Palette.white
                                        : Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Habitaciones",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: controller.selectedTab.value == 0
                                          ? Palette.black
                                          : Palette.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.selectedTab.value = 1,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  decoration: BoxDecoration(
                                    color: controller.selectedTab.value == 1
                                        ? Palette.white
                                        : Colors.grey.shade400,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Dispositivos",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: controller.selectedTab.value == 1
                                          ? Palette.black
                                          : Palette.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Obx(() {
                        return controller.selectedTab.value == 0
                            ? _habitacionesView()
                            : _dispositivosView();
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => !controller.isSetupPins.value
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withAlpha(128),
                  child: Center(
                    child: IconButton.filled(
                      iconSize: 15.w,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: () => controller.setupPins(),
                      icon: const Icon(
                        Ionicons.power_outline,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _habitacionesView() {
    return GridView.builder(
      key: const ValueKey(0),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 6 / 8,
      ),
      itemCount: controller.rooms.length,
      itemBuilder: (context, index) {
        final room = controller.rooms[index];
        return RoomCard(
          image: "assets/images/sala.jpg",
          title: room.name,
          devices: "${room.devices.length} devices",
          isOn:
              room.devices
                  .where((e) => e.name.toLowerCase().contains("luz"))
                  .firstOrNull
                  ?.light ??
              false,
          onTap: () {
            final deviceLight = room.devices
                .where((e) => e.name.toLowerCase().contains("luz"))
                .firstOrNull;
            if (deviceLight != null) {
              controller.changeLight(deviceLight.id, !deviceLight.light);
            }
          },
          containLight: room.devices.any(
            (e) => e.name.toLowerCase().contains("luz"),
          ),
        );
      },
    );
  }

  Widget _dispositivosView() {
    return GridView.builder(
      key: const ValueKey(0),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 6 / 8,
      ),
      itemCount: controller.devices.length,
      itemBuilder: (context, index) {
        final device = controller.devices[index];
        return DeviceCard(
          image: "assets/images/sala.jpg",
          title: device.name,
          isOn: device.light,
          onTap: () {},
        );
      },
    );
  }
}
