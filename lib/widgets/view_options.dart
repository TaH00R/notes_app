import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/enums/order_options.dart';
import 'package:provider/provider.dart';

class ViewOptions extends StatefulWidget {
  const ViewOptions({super.key});

  @override
  State<ViewOptions> createState() => _ViewOptionsState();
}

class _ViewOptionsState extends State<ViewOptions> {

  @override
  Widget build(BuildContext context) {
    return 
      Consumer<NotesProvider>(
        builder: (context, notesProvider, child) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            notesProvider.isDescending = !notesProvider.isDescending;
                          });
                        },
                        icon: notesProvider.isDescending
                            ? Icon(Icons.arrow_downward)
                            : Icon(Icons.arrow_upward),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        constraints: BoxConstraints(),
                        style: IconButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        iconSize: 18,
                        color: gray700,
                      ),
                      SizedBox(width: 16),
                      DropdownButton<OrderOption>(
                        iconSize: 18,
                        underline: SizedBox.shrink(),
                        borderRadius: BorderRadius.circular(16),
                        isDense: true,
                        value: notesProvider.orderBy,
                        items: OrderOption.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Row(
                                  children: [
                                    Text(e.name),
                                    if (e == notesProvider.orderBy) ...[
                                      SizedBox(width: 6),
                                      Icon(Icons.check, size: 15),
                                    ],
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        selectedItemBuilder: (context) =>
                            OrderOption.values.map((e) => Text(e.name)).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            notesProvider.orderBy = newValue!;
                          });
                        },
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            notesProvider.isGrid = !notesProvider.isGrid;
                          });
                        },
                        icon: notesProvider.isGrid ? Icon(Icons.menu) : Icon(Icons.tab),
                      ),
                    ],
                  ),
            ),
      );
  }
}