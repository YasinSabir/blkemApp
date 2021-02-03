import 'package:colibri/features/pagination_bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:colibri/extensions.dart';
class PaginationWidget<T> extends StatefulWidget {
  final PaginationFunc loadData;
  final CustomWidget<T> child;
  final PaginationBloc<T> paginationBloc;
  const PaginationWidget({Key key, this.child, this.loadData, this.paginationBloc}) : super(key: key);
  @override
  _PaginationWidgetState createState() => _PaginationWidgetState<T>();
}

class _PaginationWidgetState<T> extends State<PaginationWidget> {
  static const _pageSize = 20;
   PagingController<int, T> _pagingController;
  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) {
     fetchPage(pageKey);
     widget.paginationBloc.loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
  // package takes care of that. If you want to customize them, use the
  // [PagedChildBuilderDelegate] properties.
  PagedListView<int, T>(
    pagingController: _pagingController,
    builderDelegate: PagedChildBuilderDelegate<T>(
      itemBuilder: (context, item, index) => widget.child(item),
    ),
  );

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems = await widget.loadData<T>();
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class TestPagination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: PaginationWidget<String>(
      child: customItem,
    ),);
  }
  Container customItem<String>(String item){
    return Container();
  }
}
