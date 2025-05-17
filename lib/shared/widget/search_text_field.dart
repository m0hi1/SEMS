import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final Function({required String val}) onSearch;
  const SearchTextField({
    super.key,
    required this.onSearch,
    required this.context,
  });

  final BuildContext context;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final TextEditingController searchController;
  // final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    // _focusNode.addListener(() {
    //   if (!_focusNode.hasFocus) {
    //     // Clear the text when leaving the TextField
    //     searchController.clear();
    //     context.read<BatchBloc>().add(SearchBatchEvent(''));
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    // _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
        autofocus: true,
        // focusNode: _focusNode,
        decoration: const InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(
              color: Color.fromARGB(115, 255, 255, 255), fontSize: 20),
          border: InputBorder.none,
        ),
        onChanged: (val) {
          // searchController.text = val;
          widget.onSearch(val: val);
          // context.read<BatchBloc>().add(
          //       SearchBatchEvent(
          //         val,
          //         // batches,
          //       ),
          //     );
        },
      );
}
