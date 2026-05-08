import 'package:flutter/material.dart';

import '../../core/constants/app_routes.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../models/cat_model.dart';
import '../../services/activity_log_service.dart';
import '../../services/cat_service.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/search_box.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final CatService _service = const CatService();
  Future<List<Cat>>? _catsFuture;
  String _query = '';
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) {
      return;
    }
    final args = ModalRoute.of(context)?.settings.arguments;
    _query = args is String ? args : '';
    if (_query.isNotEmpty) {
      ActivityLogService.add("User searched for '$_query'");
      _catsFuture = _service.fetchCats();
    }
    _initialized = true;
  }

  void _fetchCats(String query) {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) {
      setState(() => _catsFuture = null);
      return;
    }

    ActivityLogService.add("User searched for '$normalizedQuery'");
    setState(() {
      _query = normalizedQuery;
      _catsFuture = _service.fetchCats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.primary,
          ),
        ),
        title: const Text('Search'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.screenMaxWidth),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.sm,
                ),
                child: SearchBox(
                  hint: 'Search cats',
                  initialValue: _query,
                  onSearch: _fetchCats,
                ),
              ),
              Expanded(
                child: _catsFuture == null
                    ? const _SearchStateMessage(
                        icon: Icons.search_rounded,
                        title: 'Search for cats',
                        message:
                            'Type a search term and press the search icon to load cats.',
                      )
                    : FutureBuilder<List<Cat>>(
                        future: _catsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return _SearchStateMessage(
                              icon: Icons.wifi_off_rounded,
                              title: 'Search unavailable',
                              message:
                                  'We could not load cats from the API. Please try again.',
                              onRetry: () => _fetchCats(_query),
                            );
                          }

                          final cats = snapshot.data ?? const <Cat>[];
                          if (cats.isEmpty) {
                            return const _SearchStateMessage(
                              icon: Icons.pets_rounded,
                              title: 'No results found',
                              message:
                                  'The Cat API returned no images. Please try again.',
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.all(AppSpacing.xl),
                            itemCount: cats.length,
                            itemBuilder: (context, index) {
                              final cat = cats[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.lg,
                                ),
                                child: CustomCard(
                                  onTap: () {
                                    ActivityLogService.add(
                                      'Opened animal details',
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.animalDetail,
                                      arguments: cat,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          AppRadius.lg,
                                        ),
                                        child: Image.network(
                                          cat.imageUrl,
                                          width: 92,
                                          height: 92,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.lg),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cat.titleFor(index),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            ),
                                            const SizedBox(
                                              height: AppSpacing.xs,
                                            ),
                                            Text(
                                              cat.breedName == null
                                                  ? 'Cat ID: ${cat.shortId}'
                                                  : 'Breed from API • ID: ${cat.shortId}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: AppColors.muted,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchStateMessage extends StatelessWidget {
  const _SearchStateMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.onRetry,
  });

  final IconData icon;
  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary, size: 48),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              FilledButton(onPressed: onRetry, child: const Text('Try Again')),
            ],
          ],
        ),
      ),
    );
  }
}
