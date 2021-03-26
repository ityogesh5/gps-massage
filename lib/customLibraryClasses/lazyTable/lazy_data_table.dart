library lazy_data_table;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';

import 'src/lazy_data_table_dimensions.dart';
import 'src/lazy_data_table_theme.dart';

export 'src/lazy_data_table_dimensions.dart';
export 'src/lazy_data_table_theme.dart';

/// Create a lazily loaded data table.
///
/// The table is [columns] by [rows] big.
/// The [columnHeaderBuilder] and [rowHeaderBuilder] are optional,
/// and when either of those is not given, the corner widget should also not be given.
class LazyDataTable extends StatefulWidget {
  LazyDataTable({
    Key key,
    // Number of data columns.
    @required this.columns,

    // Number of data rows.
    @required this.rows,

    // Dimensions of the table elements.
    this.tableDimensions = const LazyDataTableDimensions(),

    // Theme of the table elements.
    this.tableTheme = const LazyDataTableTheme(),

    // Builder function for the column header.
    this.columnHeaderBuilder,

    // Builder function for the row header.
    this.rowHeaderBuilder,

    // Builder function for the data cell.
    @required this.dataCellBuilder,

    // Corner widget.
    this.cornerWidget,
  }) : super(key: key) {
    assert(columns != null);
    assert(rows != null);
    assert(dataCellBuilder != null);
    if (rowHeaderBuilder == null || columnHeaderBuilder == null) {
      assert(cornerWidget == null,
          "The corner widget is only allowed when you have both a column header and a row header.");
    }
  }

  /// The state class that contains the table.
  final table = _LazyDataTableState();

  // Amount of cells
  /// The number of columns in the table.
  final int columns;

  /// The number of rows in the table.
  final int rows;

  // Size of cells and headers
  /// The dimensions of the table cells and headers.
  final LazyDataTableDimensions tableDimensions;

  // Theme of the table
  /// The theme of the table cells and headers.
  final LazyDataTableTheme tableTheme;

  // Builder functions
  /// The builder function for a column header.
  final Widget Function(int columnIndex) columnHeaderBuilder;

  /// The builder function for a row header.
  final Widget Function(int rowIndex) rowHeaderBuilder;

  /// The builder function for a data cell.
  final Widget Function(int columnIndex, int rowIndex) dataCellBuilder;

  /// The widget for the upper-left corner.
  final Widget cornerWidget;

  @override
  _LazyDataTableState createState() => table;

  /// Jump the table to the given cell.
  void jumpToCell(int column, int row) {
    table.jumpToCell(column, row);
  }

  /// Jump the table to the given location.
  void jumpTo(double x, double y) {
    table.jumpTo(x, y);
  }
}

class _LazyDataTableState extends State<LazyDataTable>
    with TickerProviderStateMixin {
  _CustomScrollController _horizontalControllers;
  _CustomScrollController _verticalControllers;

  @override
  void initState() {
    super.initState();

    _horizontalControllers = _CustomScrollController(this);
    _verticalControllers = _CustomScrollController(this);
  }

  @override
  void dispose() {
    _horizontalControllers.dispose();
    _verticalControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          jump(pointerSignal.scrollDelta.dx, pointerSignal.scrollDelta.dy);
        }
      },
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          jump(-details.delta.dx, -details.delta.dy);
        },
        onPanEnd: (DragEndDetails details) {
          _verticalControllers
              .setVelocity(-details.velocity.pixelsPerSecond.dy / 100);
          _horizontalControllers
              .setVelocity(-details.velocity.pixelsPerSecond.dx / 100);
        },
        child: Row(
          children: <Widget>[
            widget.rowHeaderBuilder != null
                ? SizedBox(
                    width: widget.tableDimensions.rowHeaderWidth,
                    child: Column(
                      children: <Widget>[
                        // Corner widget
                        SizedBox(
                          height: widget.tableDimensions.columnHeaderHeight,
                          width: widget.tableDimensions.rowHeaderWidth,
                          child: widget.cornerWidget != null
                              ? Container(
                                  decoration: widget.tableTheme.corner,
                                  child: widget.cornerWidget,
                                )
                              : Container(),
                        ),
                        // Row headers
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: _verticalControllers,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.rows,
                              itemBuilder: (__, i) {
                                return Container(
                                  height: widget
                                          .tableDimensions.customCellHeight
                                          .containsKey(i)
                                      ? widget
                                          .tableDimensions.customCellHeight[i]
                                      : widget.tableDimensions.cellHeight,
                                  width: widget.tableDimensions.rowHeaderWidth,
                                  decoration: widget.tableTheme.rowHeader,
                                  child: widget.rowHeaderBuilder(i),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Expanded(
              child: Column(
                children: <Widget>[
                  // Column headers
                  widget.columnHeaderBuilder != null
                      ? SizedBox(
                          height: widget.tableDimensions.columnHeaderHeight,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: _horizontalControllers,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.columns,
                              itemBuilder: (__, i) {
                                return Container(
                                  height:
                                      widget.tableDimensions.columnHeaderHeight,
                                  width: widget.tableDimensions.customCellWidth
                                          .containsKey(i)
                                      ? widget
                                          .tableDimensions.customCellWidth[i]
                                      : widget.tableDimensions.cellWidth,
                                  decoration: widget.tableTheme.columnHeader,
                                  child: widget.columnHeaderBuilder(i),
                                );
                              }),
                        )
                      : Container(),
                  // Main data
                  Expanded(
                    // List of rows
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: _verticalControllers,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.rows,
                        itemBuilder: (_, i) {
                          // Single row
                          return SizedBox(
                            height: widget.tableDimensions.customCellHeight
                                    .containsKey(i)
                                ? widget.tableDimensions.customCellHeight[i]
                                : widget.tableDimensions.cellHeight,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                controller: _horizontalControllers,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.columns,
                                itemBuilder: (__, j) {
                                  return Container(
                                    height: widget
                                            .tableDimensions.customCellHeight
                                            .containsKey(i)
                                        ? widget
                                            .tableDimensions.customCellHeight[i]
                                        : widget.tableDimensions.cellHeight,
                                    width: widget
                                            .tableDimensions.customCellWidth
                                            .containsKey(j)
                                        ? widget
                                            .tableDimensions.customCellWidth[j]
                                        : widget.tableDimensions.cellWidth,
                                    decoration:
                                        (widget.tableTheme.alternateRow &&
                                                    i % 2 != 0) ||
                                                (widget.tableTheme
                                                        .alternateColumn &&
                                                    j % 2 != 0)
                                            ? widget.tableTheme.alternateCell
                                            : widget.tableTheme.cell,
                                    child: widget.dataCellBuilder(i, j),
                                  );
                                }),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Jump the table to the given cell.
  void jumpToCell(int column, int row) {
    double customWidth = 0;
    int customWidthCells = 0;
    for (int i = 0; i < column; i++) {
      if (widget.tableDimensions.customCellWidth.containsKey(i)) {
        customWidth += widget.tableDimensions.customCellWidth[i];
        customWidthCells++;
      }
    }
    _horizontalControllers.jumpTo(
        (column - customWidthCells) * widget.tableDimensions.cellWidth +
            customWidth);

    double customHeight = 0;
    int customHeightCells = 0;
    for (int i = 0; i < column; i++) {
      if (widget.tableDimensions.customCellHeight.containsKey(i)) {
        customHeight += widget.tableDimensions.customCellHeight[i];
        customHeightCells++;
      }
    }
    _verticalControllers.jumpTo(
        (row - customHeightCells) * widget.tableDimensions.cellHeight +
            customHeight);
  }

  /// Jump the table to the given location.
  void jumpTo(double x, double y) {
    _horizontalControllers.jumpTo(x);
    _verticalControllers.jumpTo(y);
  }

  /// Jump to a relative location from the current location.
  void jump(double x, double y) {
    _horizontalControllers.jump(x);
    _verticalControllers.jump(y);
  }
}

/// A custom synchronized scroll controller.
///
/// This controller stores all their attached [ScrollPosition] in a list,
/// and when given a notification via [processNotification], it will scroll
/// every ScrollPosition in that list to the same [offset].
class _CustomScrollController extends ScrollController {
  _CustomScrollController(TickerProvider provider) : super() {
    _ticker = provider.createTicker((_) {
      jumpTo(offset + _velocity);
      _velocity *= 0.9;
      if (_velocity < 0.1 && _velocity > -0.1) {
        _ticker.stop();
      }
    });
  }

  /// List of [ScrollPosition].
  List<ScrollPosition> _positions = List();

  /// The offset of the ScrollPositions.
  double offset = 0;

  /// Ticker to calculate the [_velocity].
  Ticker _ticker;

  /// The velocity of the controller.
  /// The [_ticker] will tick while the velocity
  /// is not between -0.1 and 0.1.
  double _velocity;

  /// Stores given [ScrollPosition] in the list and
  /// set the initial offset of that ScrollPosition.
  @override
  void attach(ScrollPosition position) {
    position.correctPixels(offset);
    _positions.add(position);
  }

  /// Removes given [ScrollPostion] from the list.
  @override
  void detach(ScrollPosition position) {
    _positions.remove(position);
  }

  /// Processes notification from one of the [ScrollPositions] in the list.
  void processNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      jumpTo(notification.metrics.pixels);
    }
  }

  /// Jumps every item in the list to the given [value],
  /// except the ones that are already at the correct offset.
  @override
  void jumpTo(double value) {
    if (_positions[0] != null && value > _positions[0].maxScrollExtent) {
      offset = _positions[0].maxScrollExtent;
    } else if (value < 0) {
      offset = 0;
    } else {
      offset = value;
    }
    for (ScrollPosition position in _positions) {
      if (position.pixels != offset) {
        position.jumpTo(offset);
      }
    }
  }

  /// Jump to [offset] + [value].
  void jump(double value) {
    jumpTo(offset + value);
  }

  /// Set [_velocity] to new value.
  void setVelocity(double velocity) {
    if (_ticker.isActive) _ticker.stop();
    _velocity = velocity;
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
