// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTicketCollection on Isar {
  IsarCollection<Ticket> get tickets => this.collection();
}

const TicketSchema = CollectionSchema(
  name: r'Ticket',
  id: -4590405904438382117,
  properties: {
    r'categoria': PropertySchema(
      id: 0,
      name: r'categoria',
      type: IsarType.string,
    ),
    r'comercio': PropertySchema(
      id: 1,
      name: r'comercio',
      type: IsarType.string,
    ),
    r'direccion': PropertySchema(
      id: 2,
      name: r'direccion',
      type: IsarType.string,
    ),
    r'fecha': PropertySchema(
      id: 3,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'fechaProcesamiento': PropertySchema(
      id: 4,
      name: r'fechaProcesamiento',
      type: IsarType.dateTime,
    ),
    r'handmade': PropertySchema(
      id: 5,
      name: r'handmade',
      type: IsarType.bool,
    ),
    r'productos': PropertySchema(
      id: 6,
      name: r'productos',
      type: IsarType.objectList,
      target: r'Product',
    ),
    r'tiempoExtraccion': PropertySchema(
      id: 7,
      name: r'tiempoExtraccion',
      type: IsarType.double,
    ),
    r'total': PropertySchema(
      id: 8,
      name: r'total',
      type: IsarType.double,
    )
  },
  estimateSize: _ticketEstimateSize,
  serialize: _ticketSerialize,
  deserialize: _ticketDeserialize,
  deserializeProp: _ticketDeserializeProp,
  idName: r'id',
  indexes: {
    r'comercio': IndexSchema(
      id: 6761825949999270415,
      name: r'comercio',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'comercio',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'fecha': IndexSchema(
      id: -5395179286312083551,
      name: r'fecha',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fecha',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'categoria': IndexSchema(
      id: -697249392299839610,
      name: r'categoria',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'categoria',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'Product': ProductSchema},
  getId: _ticketGetId,
  getLinks: _ticketGetLinks,
  attach: _ticketAttach,
  version: '3.1.0+1',
);

int _ticketEstimateSize(
  Ticket object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.categoria.length * 3;
  bytesCount += 3 + object.comercio.length * 3;
  {
    final value = object.direccion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.productos.length * 3;
  {
    final offsets = allOffsets[Product]!;
    for (var i = 0; i < object.productos.length; i++) {
      final value = object.productos[i];
      bytesCount += ProductSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _ticketSerialize(
  Ticket object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.categoria);
  writer.writeString(offsets[1], object.comercio);
  writer.writeString(offsets[2], object.direccion);
  writer.writeDateTime(offsets[3], object.fecha);
  writer.writeDateTime(offsets[4], object.fechaProcesamiento);
  writer.writeBool(offsets[5], object.handmade);
  writer.writeObjectList<Product>(
    offsets[6],
    allOffsets,
    ProductSchema.serialize,
    object.productos,
  );
  writer.writeDouble(offsets[7], object.tiempoExtraccion);
  writer.writeDouble(offsets[8], object.total);
}

Ticket _ticketDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Ticket(
    categoria: reader.readString(offsets[0]),
    comercio: reader.readString(offsets[1]),
    direccion: reader.readStringOrNull(offsets[2]),
    fecha: reader.readDateTime(offsets[3]),
    fechaProcesamiento: reader.readDateTimeOrNull(offsets[4]),
    handmade: reader.readBoolOrNull(offsets[5]) ?? false,
    id: id,
    productos: reader.readObjectList<Product>(
          offsets[6],
          ProductSchema.deserialize,
          allOffsets,
          Product(),
        ) ??
        const [],
    tiempoExtraccion: reader.readDoubleOrNull(offsets[7]),
    total: reader.readDouble(offsets[8]),
  );
  return object;
}

P _ticketDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readObjectList<Product>(
            offset,
            ProductSchema.deserialize,
            allOffsets,
            Product(),
          ) ??
          const []) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _ticketGetId(Ticket object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _ticketGetLinks(Ticket object) {
  return [];
}

void _ticketAttach(IsarCollection<dynamic> col, Id id, Ticket object) {
  object.id = id;
}

extension TicketQueryWhereSort on QueryBuilder<Ticket, Ticket, QWhere> {
  QueryBuilder<Ticket, Ticket, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }
}

extension TicketQueryWhere on QueryBuilder<Ticket, Ticket, QWhereClause> {
  QueryBuilder<Ticket, Ticket, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> idBetween(
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

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> comercioEqualTo(
      String comercio) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'comercio',
        value: [comercio],
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> comercioNotEqualTo(
      String comercio) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'comercio',
              lower: [],
              upper: [comercio],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'comercio',
              lower: [comercio],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'comercio',
              lower: [comercio],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'comercio',
              lower: [],
              upper: [comercio],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> fechaEqualTo(DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fecha',
        value: [fecha],
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> fechaNotEqualTo(
      DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fecha',
              lower: [],
              upper: [fecha],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fecha',
              lower: [fecha],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fecha',
              lower: [fecha],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fecha',
              lower: [],
              upper: [fecha],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> fechaGreaterThan(
    DateTime fecha, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fecha',
        lower: [fecha],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> fechaLessThan(
    DateTime fecha, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fecha',
        lower: [],
        upper: [fecha],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> fechaBetween(
    DateTime lowerFecha,
    DateTime upperFecha, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fecha',
        lower: [lowerFecha],
        includeLower: includeLower,
        upper: [upperFecha],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> categoriaEqualTo(
      String categoria) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'categoria',
        value: [categoria],
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterWhereClause> categoriaNotEqualTo(
      String categoria) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoria',
              lower: [],
              upper: [categoria],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoria',
              lower: [categoria],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoria',
              lower: [categoria],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoria',
              lower: [],
              upper: [categoria],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TicketQueryFilter on QueryBuilder<Ticket, Ticket, QFilterCondition> {
  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> categoriaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> categoriaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> categoriaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> categoriaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> categoriaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> categoriaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> categoriaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> categoriaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoria',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> categoriaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoria',
        value: '',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> categoriaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoria',
        value: '',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> comercioEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comercio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> comercioGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comercio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> comercioLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comercio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> comercioBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comercio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> comercioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'comercio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> comercioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'comercio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> comercioContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'comercio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> comercioMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'comercio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> comercioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comercio',
        value: '',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> comercioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'comercio',
        value: '',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'direccion',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'direccion',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'direccion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'direccion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'direccion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'direccion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'direccion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'direccion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'direccion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'direccion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'direccion',
        value: '',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> direccionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'direccion',
        value: '',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> fechaEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> fechaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> fechaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> fechaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fecha',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition>
      fechaProcesamientoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fechaProcesamiento',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition>
      fechaProcesamientoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fechaProcesamiento',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> fechaProcesamientoEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaProcesamiento',
        value: value,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition>
      fechaProcesamientoGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaProcesamiento',
        value: value,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition>
      fechaProcesamientoLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaProcesamiento',
        value: value,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> fechaProcesamientoBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaProcesamiento',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> handmadeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'handmade',
        value: value,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> productosLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'productos',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> productosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'productos',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> productosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'productos',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> productosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'productos',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition>
      productosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'productos',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> productosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'productos',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> tiempoExtraccionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tiempoExtraccion',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition>
      tiempoExtraccionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tiempoExtraccion',
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> tiempoExtraccionEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tiempoExtraccion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition>
      tiempoExtraccionGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tiempoExtraccion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> tiempoExtraccionLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tiempoExtraccion',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> tiempoExtraccionBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tiempoExtraccion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> totalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> totalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> totalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> totalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'total',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension TicketQueryObject on QueryBuilder<Ticket, Ticket, QFilterCondition> {
  QueryBuilder<Ticket, Ticket, QAfterFilterCondition> productosElement(
      FilterQuery<Product> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'productos');
    });
  }
}

extension TicketQueryLinks on QueryBuilder<Ticket, Ticket, QFilterCondition> {}

extension TicketQuerySortBy on QueryBuilder<Ticket, Ticket, QSortBy> {
  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByComercio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comercio', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByComercioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comercio', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByDireccion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direccion', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByDireccionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direccion', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByFechaProcesamiento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaProcesamiento', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByFechaProcesamientoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaProcesamiento', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByHandmade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handmade', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByHandmadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handmade', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByTiempoExtraccion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoExtraccion', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByTiempoExtraccionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoExtraccion', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> sortByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }
}

extension TicketQuerySortThenBy on QueryBuilder<Ticket, Ticket, QSortThenBy> {
  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByComercio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comercio', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByComercioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comercio', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByDireccion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direccion', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByDireccionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direccion', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByFechaProcesamiento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaProcesamiento', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByFechaProcesamientoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaProcesamiento', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByHandmade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handmade', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByHandmadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handmade', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByTiempoExtraccion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoExtraccion', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByTiempoExtraccionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tiempoExtraccion', Sort.desc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<Ticket, Ticket, QAfterSortBy> thenByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }
}

extension TicketQueryWhereDistinct on QueryBuilder<Ticket, Ticket, QDistinct> {
  QueryBuilder<Ticket, Ticket, QDistinct> distinctByCategoria(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoria', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ticket, Ticket, QDistinct> distinctByComercio(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comercio', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ticket, Ticket, QDistinct> distinctByDireccion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'direccion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ticket, Ticket, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<Ticket, Ticket, QDistinct> distinctByFechaProcesamiento() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaProcesamiento');
    });
  }

  QueryBuilder<Ticket, Ticket, QDistinct> distinctByHandmade() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'handmade');
    });
  }

  QueryBuilder<Ticket, Ticket, QDistinct> distinctByTiempoExtraccion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tiempoExtraccion');
    });
  }

  QueryBuilder<Ticket, Ticket, QDistinct> distinctByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'total');
    });
  }
}

extension TicketQueryProperty on QueryBuilder<Ticket, Ticket, QQueryProperty> {
  QueryBuilder<Ticket, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Ticket, String, QQueryOperations> categoriaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoria');
    });
  }

  QueryBuilder<Ticket, String, QQueryOperations> comercioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comercio');
    });
  }

  QueryBuilder<Ticket, String?, QQueryOperations> direccionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'direccion');
    });
  }

  QueryBuilder<Ticket, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<Ticket, DateTime?, QQueryOperations>
      fechaProcesamientoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaProcesamiento');
    });
  }

  QueryBuilder<Ticket, bool, QQueryOperations> handmadeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'handmade');
    });
  }

  QueryBuilder<Ticket, List<Product>, QQueryOperations> productosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productos');
    });
  }

  QueryBuilder<Ticket, double?, QQueryOperations> tiempoExtraccionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tiempoExtraccion');
    });
  }

  QueryBuilder<Ticket, double, QQueryOperations> totalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'total');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ProductSchema = Schema(
  name: r'Product',
  id: -6222113721139403729,
  properties: {
    r'cantidad': PropertySchema(
      id: 0,
      name: r'cantidad',
      type: IsarType.long,
    ),
    r'nombre': PropertySchema(
      id: 1,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'precio': PropertySchema(
      id: 2,
      name: r'precio',
      type: IsarType.double,
    )
  },
  estimateSize: _productEstimateSize,
  serialize: _productSerialize,
  deserialize: _productDeserialize,
  deserializeProp: _productDeserializeProp,
);

int _productEstimateSize(
  Product object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nombre.length * 3;
  return bytesCount;
}

void _productSerialize(
  Product object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cantidad);
  writer.writeString(offsets[1], object.nombre);
  writer.writeDouble(offsets[2], object.precio);
}

Product _productDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Product(
    cantidad: reader.readLongOrNull(offsets[0]) ?? 0,
    nombre: reader.readStringOrNull(offsets[1]) ?? '',
    precio: reader.readDoubleOrNull(offsets[2]) ?? 0.0,
  );
  return object;
}

P _productDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ProductQueryFilter
    on QueryBuilder<Product, Product, QFilterCondition> {
  QueryBuilder<Product, Product, QAfterFilterCondition> cantidadEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidad',
        value: value,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> cantidadGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidad',
        value: value,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> cantidadLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidad',
        value: value,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> cantidadBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> nombreContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> nombreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> precioEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'precio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> precioGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'precio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> precioLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'precio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Product, Product, QAfterFilterCondition> precioBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'precio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ProductQueryObject
    on QueryBuilder<Product, Product, QFilterCondition> {}
