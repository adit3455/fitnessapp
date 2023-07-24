// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_weekly_goal_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSetWeeklyGoalModelCollection on Isar {
  IsarCollection<SetWeeklyGoalModel> get setWeeklyGoalModels =>
      this.collection();
}

const SetWeeklyGoalModelSchema = CollectionSchema(
  name: r'SetWeeklyGoalModel',
  id: -6155934727577388716,
  properties: {
    r'daySet': PropertySchema(
      id: 0,
      name: r'daySet',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    )
  },
  estimateSize: _setWeeklyGoalModelEstimateSize,
  serialize: _setWeeklyGoalModelSerialize,
  deserialize: _setWeeklyGoalModelDeserialize,
  deserializeProp: _setWeeklyGoalModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _setWeeklyGoalModelGetId,
  getLinks: _setWeeklyGoalModelGetLinks,
  attach: _setWeeklyGoalModelAttach,
  version: '3.1.0+1',
);

int _setWeeklyGoalModelEstimateSize(
  SetWeeklyGoalModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.daySet.length * 3;
  return bytesCount;
}

void _setWeeklyGoalModelSerialize(
  SetWeeklyGoalModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.daySet);
  writer.writeLong(offsets[1], object.hashCode);
}

SetWeeklyGoalModel _setWeeklyGoalModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SetWeeklyGoalModel(
    daySet: reader.readString(offsets[0]),
    id: id,
  );
  return object;
}

P _setWeeklyGoalModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _setWeeklyGoalModelGetId(SetWeeklyGoalModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _setWeeklyGoalModelGetLinks(
    SetWeeklyGoalModel object) {
  return [];
}

void _setWeeklyGoalModelAttach(
    IsarCollection<dynamic> col, Id id, SetWeeklyGoalModel object) {}

extension SetWeeklyGoalModelQueryWhereSort
    on QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QWhere> {
  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SetWeeklyGoalModelQueryWhere
    on QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QWhereClause> {
  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SetWeeklyGoalModelQueryFilter
    on QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QFilterCondition> {
  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      daySetEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daySet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      daySetGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daySet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      daySetLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daySet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      daySetBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daySet',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      daySetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'daySet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      daySetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'daySet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      daySetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'daySet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      daySetMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'daySet',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      daySetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daySet',
        value: '',
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      daySetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'daySet',
        value: '',
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SetWeeklyGoalModelQueryObject
    on QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QFilterCondition> {}

extension SetWeeklyGoalModelQueryLinks
    on QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QFilterCondition> {}

extension SetWeeklyGoalModelQuerySortBy
    on QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QSortBy> {
  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterSortBy>
      sortByDaySet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daySet', Sort.asc);
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterSortBy>
      sortByDaySetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daySet', Sort.desc);
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }
}

extension SetWeeklyGoalModelQuerySortThenBy
    on QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QSortThenBy> {
  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterSortBy>
      thenByDaySet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daySet', Sort.asc);
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterSortBy>
      thenByDaySetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daySet', Sort.desc);
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension SetWeeklyGoalModelQueryWhereDistinct
    on QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QDistinct> {
  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QDistinct>
      distinctByDaySet({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daySet', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }
}

extension SetWeeklyGoalModelQueryProperty
    on QueryBuilder<SetWeeklyGoalModel, SetWeeklyGoalModel, QQueryProperty> {
  QueryBuilder<SetWeeklyGoalModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SetWeeklyGoalModel, String, QQueryOperations> daySetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daySet');
    });
  }

  QueryBuilder<SetWeeklyGoalModel, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }
}
