import 'package:flutter/material.dart';
import 'package:my_notes/presentation/constants.dart';

class ChooseNoteColorButton extends StatelessWidget {
  final void Function(int) changeColor;
  final ColorSelection colorSelected;

  const ChooseNoteColorButton(
      {super.key, required this.changeColor, required this.colorSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child: const Text(
          "Change color",
          style: TextStyle(color: Colors.white70, fontSize: 17),
        ),
        itemBuilder: (context) {
          return List.generate(ColorSelection.values.length, (index) {
            final currentColor = ColorSelection.values[index];
            return PopupMenuItem(
                onTap: () {
                  changeColor(index);
                },
                enabled: currentColor != colorSelected,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.opacity_rounded,
                        color: currentColor.color,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(currentColor.label),
                    )
                  ],
                ));
          });
        }
        //onSelected: changeColor,
        );
  }
}
