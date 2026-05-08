import 'package:flutter/material.dart';

import '../core/constants/app_routes.dart';
import '../core/constants/app_sizes.dart';
import '../core/theme/app_colors.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    this.hint = 'Search',
    this.initialValue,
    this.onSearch,
  });

  final String hint;
  final String? initialValue;
  final ValueChanged<String>? onSearch;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.searchHeight,
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => _openSearch(context, value),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          suffixIcon: IconButton(
            tooltip: 'Search',
            onPressed: () => _openSearch(context, _controller.text),
            icon: const Icon(Icons.search_rounded, color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  void _openSearch(BuildContext context, [String query = '']) {
    final normalizedQuery = query.trim();
    final onSearch = widget.onSearch;
    if (onSearch != null) {
      onSearch(normalizedQuery);
      return;
    }

    if (normalizedQuery.isEmpty) {
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.searchResults,
      arguments: normalizedQuery,
    );
  }
}
