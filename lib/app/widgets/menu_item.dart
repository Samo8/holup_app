import 'package:flutter/material.dart';
import 'package:holup/app/constants/constants.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final void Function() onTap;

  const MenuItem({
    @required this.title,
    @required this.imagePath,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: double.infinity,
        height: 170,
        child: Card(
          color: Constants.primaryColor,
          elevation: 15,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Transform.translate(
                  offset: Offset(25, -50),
                  child: Image.asset(
                    imagePath,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .apply(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
