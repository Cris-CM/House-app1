import 'package:flutter/material.dart';
import 'package:house_app/colors/palette.dart';

class RoomCard extends StatelessWidget {
  final String image;
  final String title;
  final String devices;
  final bool isOn;
  final VoidCallback onTap;
  final bool containLight;
  const RoomCard({
    super.key,
    required this.image,
    required this.title,
    required this.devices,
    required this.isOn,
    required this.onTap,
    required this.containLight,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isOn ? Colors.white : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isOn ? Colors.purple.withOpacity(0.25) : Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    devices,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  SizedBox(height: 14),

                  if (containLight)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isOn ? "ON" : "OFF",
                          style: TextStyle(
                            fontSize: 14,
                            color: isOn ? Colors.purple : Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        GestureDetector(
                          onTap: onTap,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                            width: 45,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isOn ? Palette.purpleAccent : Palette.grey,
                            ),
                            child: AnimatedAlign(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              alignment: isOn
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isOn ? Colors.white : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
