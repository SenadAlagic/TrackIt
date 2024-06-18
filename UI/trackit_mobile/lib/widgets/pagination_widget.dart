import 'package:flutter/material.dart';

import '../../models/search_result.dart';
import '../providers/base_provider.dart';

class PaginationWidget<T> extends StatefulWidget {
  final SearchResult<T> result;
  final BaseProvider<T> _provider;
  final int pageSize;
  final Map<String, dynamic>? filter;
  final Function(SearchResult<T>) onResultFetched;

  const PaginationWidget(
      this.result, this._provider, this.onResultFetched, this.pageSize,
      {super.key, this.filter});

  @override
  State<PaginationWidget> createState() => PaginationWidgetState();
}

class PaginationWidgetState extends State<PaginationWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: widget.result.meta.hasPrevious
              ? () async {
                  Map<String, dynamic> filter = {
                    "Page": widget.result.meta.currentPage - 1,
                    "PageSize": widget.pageSize
                  };
                  if (widget.filter != null) {
                    filter.addAll(widget.filter!);
                  }
                  var results = await widget._provider.get(filter: filter);
                  widget.onResultFetched(results);
                }
              : null,
          child: const Icon(Icons.keyboard_arrow_left),
        ),
        ..._drawPaginationNumbers(),
        ElevatedButton(
          onPressed: widget.result.meta.hasNext
              ? () async {
                  Map<String, dynamic> filter = {
                    "Page": widget.result.meta.currentPage + 1,
                    "PageSize": widget.pageSize
                  };
                  if (widget.filter != null) {
                    filter.addAll(widget.filter!);
                  }
                  var results = await widget._provider.get(filter: filter);
                  widget.onResultFetched(results);
                }
              : null,
          child: const Icon(Icons.keyboard_arrow_right),
        )
      ],
    );
  }

  List<Widget> _drawPaginationNumbers() {
    List<Widget> numbers = List.empty(growable: true);
    if (widget.result.meta.hasPrevious) {
      numbers.add(_drawPaginationNumber(widget.result.meta.currentPage));
    }

    numbers.add(_drawPaginationNumber(widget.result.meta.currentPage + 1,
        active: true));

    if (widget.result.meta.hasNext) {
      numbers.add(_drawPaginationNumber(widget.result.meta.currentPage + 2));
    }

    if (widget.result.meta.currentPage < widget.result.meta.totalPages - 2) {
      numbers.add(const Text("..."));
      numbers.add(_drawPaginationNumber(widget.result.meta.totalPages));
    }

    return numbers;
  }

  Widget _drawPaginationNumber(int number, {bool active = false}) {
    return InkWell(
        onTap: () async {
          Map<String, dynamic> filter = {
            "Page": number - 1,
            "PageSize": widget.pageSize
          };
          if (widget.filter != null) {
            filter.addAll(widget.filter!);
          }
          var results = await widget._provider.get(filter: filter);
          widget.onResultFetched(results);
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
                alignment: Alignment.center,
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active ? Colors.white : null),
                child: Text(
                  "$number",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ))));
  }
}
