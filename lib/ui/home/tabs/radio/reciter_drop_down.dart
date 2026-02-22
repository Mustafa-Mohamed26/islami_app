import 'package:flutter/material.dart';
import 'package:islami_app/model/reciters_response.dart';
import 'package:islami_app/util/app_styles.dart';

class ReciterDropdown extends StatelessWidget {
  final List<Reciters> reciters;
  final Reciters? selectedReciter;
  final ValueChanged<Reciters?> onChanged;

  const ReciterDropdown({
    super.key,
    required this.reciters,
    required this.selectedReciter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<Reciters>(
        value: selectedReciter,
        hint: Text("Choose a reciter", style: AppStyles.bold20Primary),
        isExpanded: true,
        items: reciters.map((reciter) {
          return DropdownMenuItem(
            value: reciter,
            child: Text(reciter.name ?? "", style: AppStyles.bold20Primary),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
