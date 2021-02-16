/// Data class for the dimensions of a [LazyDataTable].
class LazyDataTableDimensions {
  const LazyDataTableDimensions({
    this.cellHeight = 50,
    this.cellWidth = 50,
    this.columnHeaderHeight = 50,
    this.rowHeaderWidth = 50,
    this.customCellHeight = const {},
    this.customCellWidth = const {},
  });

  /// Height of a cell and row header.
  final double cellHeight;

  /// Width of a cell and column header.
  final double cellWidth;

  /// Height of a column header.
  final double columnHeaderHeight;

  /// Width of a row header.
  final double rowHeaderWidth;

  /// Map with the custom height for a certain rows.
  final Map<int, double> customCellHeight;

  /// Map with the custom width for certain columns.
  final Map<int, double> customCellWidth;
}
