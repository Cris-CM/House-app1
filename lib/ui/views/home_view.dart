import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_app/app/controllers/home_controller.dart';
import 'package:house_app/colors/palette.dart';
import 'package:house_app/widgets/room_card.dart';
import 'package:sizer/sizer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        backgroundColor: Palette.grey,
        elevation: 0,
        title: Text(
          'Casa Inteligente',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Palette.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
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
                      style: TextStyle(fontSize: 25.sp, color: Palette.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Container(
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
                            borderRadius: BorderRadiusDirectional.circular(20),
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
              ),

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
    );
  }

  Widget _habitacionesView() {
    return GridView.count(
      key: const ValueKey(0),
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 6 / 8,
      children: [
        RoomCard(
          image: "assets/images/sala.jpg",
          title: "Sala",
          devices: "4 devices",
          isOn: true,
          onTap: () {},
        ),
        RoomCard(
          image: "assets/images/sala.jpg",
          title: "Living",
          devices: "15 devices",
          isOn: false,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _dispositivosView() {
    return ListView(
      key: const ValueKey(1),
      padding: const EdgeInsets.all(20),
      children: [Text("Dispositivos")],
    );
  }
}
