import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tickets_app/models/ticket.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  factory IsarService() => _instance;
  IsarService._internal();

  Isar? _isar;

  Future<Isar> get isar async {
    if (_isar != null) return _isar!;
    _isar = await _initIsar();
    return _isar!;
  }

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [TicketSchema],
      directory: dir.path,
    );
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  Future<List<Ticket>> getAllTickets() async {
    final db = await isar;
    return await db.tickets.where().sortByFechaDesc().findAll();
  }

  Future<Ticket?> getTicket(Id id) async {
    final db = await isar;
    return await db.tickets.get(id);
  }

  Future<Id> saveTicket(Ticket ticket) async {
    final db = await isar;
    return await db.writeTxn(() async {
      return await db.tickets.put(ticket);
    });
  }

  Future<void> deleteTicket(Id id) async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.tickets.delete(id);
    });
  }

  Future<List<Ticket>> getTicketsByCategory(String categoria) async {
    final db = await isar;
    return await db.tickets
        .filter()
        .categoriaEqualTo(categoria)
        .sortByFechaDesc()
        .findAll();
  }

  Future<List<Ticket>> getTicketsByComercio(String comercio) async {
    final db = await isar;
    return await db.tickets
        .filter()
        .comercioEqualTo(comercio)
        .sortByFechaDesc()
        .findAll();
  }

  Future<List<Ticket>> getTicketsByDateRange(
      DateTime start, DateTime end) async {
    final db = await isar;
    return await db.tickets
        .filter()
        .fechaBetween(start, end)
        .sortByFechaDesc()
        .findAll();
  }

  Stream<List<Ticket>> watchAllTickets() async* {
    final db = await isar;
    yield* db.tickets.where().sortByFechaDesc().watch(fireImmediately: true);
  }

  Stream<Ticket?> watchTicket(Id id) async* {
    final db = await isar;
    yield* db.tickets.watchObject(id, fireImmediately: true);
  }
}
