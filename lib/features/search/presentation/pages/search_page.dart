import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/search_provider.dart';
import '../providers/search_state.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/search_empty_widget.dart';
import '../widgets/search_loading_widget.dart';
import '../widgets/search_result_tile.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(searchProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SearchState state = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          SearchBarWidget(
            initialValue: state.query,
            onChanged: (value) {
              ref.read(searchProvider.notifier).search(value);
            },
            onSubmitted: (value) {
              ref.read(searchProvider.notifier).search(value);
            },
            onClear: () {
              ref.read(searchProvider.notifier).clear();
            },
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (state.isLoading && state.results.isEmpty) {
                  return const SearchLoadingWidget();
                }

                if (state.results.isEmpty) {
                  return const SearchEmptyWidget();
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(searchProvider.notifier)
                        .search(state.query);
                  },
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.results.length +
                        (state.isLoadingMore ? 1 : 0),
                    separatorBuilder: (_, _) =>
                    const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      if (index >= state.results.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return SearchResultTile(
                        result: state.results[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}