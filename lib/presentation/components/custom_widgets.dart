import 'package:equipment_picker/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomButton({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(darkColor),
          backgroundColor: MaterialStateProperty.all<Color>(lightColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: lightColor),
            ),
          ),
        ),
        onPressed: () => onTap(),
        child: Text(title, style: const TextStyle(fontSize: 14),),),
    );
  }
}

class CustomCards extends StatelessWidget {
  final String title;
  final bool isPicked;
  final String imageUrl;
  final VoidCallback onTap;
  const CustomCards({Key? key, required this.title, required this.isPicked, required this.imageUrl, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          InkWell(
            onTap: () => onTap(),
            child: Stack(
              children: [
                Material(
                  color: darkColor,
                  child: Card(
                    elevation: isPicked?0:5,
                    surfaceTintColor: lightColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        imageUrl,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: isPicked
                      ? Icon(
                    Icons.check_circle,
                    color: tickColor,
                  )
                      : Icon(
                    Icons.circle_outlined,
                    color: darkColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
                color: lightColor, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

SnackBar customSnackBar(text) {
  return SnackBar(
      backgroundColor: lightColor,
      content: Text(
        text,
        style: TextStyle(color: darkColor),
      ),
  );
}
