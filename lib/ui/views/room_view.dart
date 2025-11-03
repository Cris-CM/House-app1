import 'package:flutter/material.dart';
import 'package:house_app/colors/palette.dart';
import 'package:house_app/widgets/room_card.dart';

class RoomView extends StatefulWidget {
  const RoomView({Key? key}) : super(key: key);

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  bool salaOn = true;
  bool livingOn = false;

  int selectedTab = 0; // 0 = Habitaciones, 1 = Dispositivos

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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // ----------- TARJETA PRINCIPAL ------------
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 46,
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
                        const Text(
                          'Mi Casa',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w600,
                            color: Palette.white,
                          ),
                        ),
                        Text(
                          'Sala principal',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                            color: Palette.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '-10°',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w500,
                        color: Palette.white,
                      ),
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
                        onTap: () => setState(() => selectedTab = 0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: selectedTab == 0
                                ? Palette.white
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Habitaciones",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: selectedTab == 0
                                  ? Palette.black
                                  : Palette.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedTab = 1),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: selectedTab == 1
                                ? Palette.white
                                : Colors.grey.shade400,
                            borderRadius: BorderRadiusDirectional.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Dispositivos",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: selectedTab == 1
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
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: selectedTab == 0
                      ? _habitacionesView()
                      : _dispositivosView(),
                ),
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
      children: [
        RoomCard(
          image: "assets/images/sala.jpg",
          title: "Sala",
          devices: "4 devices",
          isOn: salaOn,
          onTap: () {
            setState(() {
              salaOn = !salaOn;
            });
          },
        ),
        RoomCard(
          image: "assets/images/sala.jpg",
          title: "Living",
          devices: "15 devices",
          isOn: livingOn,
          onTap: () {
            setState(() {
              livingOn = !livingOn;
            });
          },
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
