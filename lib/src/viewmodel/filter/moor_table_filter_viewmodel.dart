import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/model/filter/where/where_clause.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class MoorTableFilterViewModel with ChangeNotifier {
  // ignore: unused_field
  final GeneratedDatabase _db;
  final MoorTableFilterNavigator _navigator;
  FilterData _filterData;
  TableInfo<moor.Table, DataClass> _table;

  String get title => '$tableName Filter';

  String get selectQuery => _filterData.selectQuery;

  String get tableName => _table.entityName;

  bool get areAllColumnsSelected => _filterData.areAllColumnsSelected;

  Map<String, bool> get selectColumns => _filterData.selectColumns;

  Map<String, bool> get orderByColumns => _filterData.orderByColumns;

  List<WhereClause> get whereClauses => _filterData.whereClauses;

  bool get asc => _filterData.asc;

  int get limit => _filterData.limit;

  MoorTableFilterViewModel(
    this._navigator,
    this._db,
    this._table,
    FilterData filterData,
  ) {
    if (filterData == null) {
      this._filterData = FilterData(_table);
    }
    _filterData = filterData;
    notifyListeners();
  }

  void onSelectAllColumns() {
    _filterData.selectAllColumns();
    notifyListeners();
  }

  void onToggleColumn(String value) {
    _filterData.onToggleColumn(value);
    notifyListeners();
  }

  void onBackClicked() => _navigator.goBack(null);

  void onSaveClicked() => _navigator.goBack(_filterData);

  void onAscClicked() {
    _filterData.onAscClicked();
    notifyListeners();
  }

  void onDescClicked() {
    _filterData.onDescClicked();
    notifyListeners();
  }

  void onToggleOrderByColumn(String value) {
    _filterData.onToggleOrderByColumn(value);
    notifyListeners();
  }

  void onAddClicked() {
    _navigator.showAddWhereClause(_table);
  }

  void onWhereColumnSelected(result) {
    _filterData.onWhereColumnSelected(result);
    notifyListeners();
  }

  void onUpdatedWhereClause() {
    _filterData.onUpdatedWhereClause();
    notifyListeners();
  }

  void onDismissWhereClause(WhereClause whereClause) {
    _filterData.remove(whereClause);
    notifyListeners();
  }
}

abstract class MoorTableFilterNavigator {
  void goBack(FilterData filterData);

  void showAddWhereClause(TableInfo<moor.Table, DataClass> table) {}
}
