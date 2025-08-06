import 'package:evently_app/providers/event_provider.dart';
import 'package:evently_app/widget/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveTab extends StatefulWidget {
  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late EventProvider eventProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => eventProvider.favouriteFilterEvents([]),
    );
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DefaultTextFormField(
              hintText: 'Search for Event',
              preFixIconImageName: 'search',
              onChanged: (quary) {},
            ),
          ),
          SizedBox(height: 10),
          // Expanded(
          //   child: ListView.separated(
          //     padding: EdgeInsets.zero,
          //     itemBuilder: (context, index) => EventItem(),
          //     separatorBuilder: (context, index) => SizedBox(height: 10),
          //     itemCount: 10,
          //   ),
          // ),
        ],
      ),
    );
    ;
  }
}
