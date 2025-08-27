import 'package:mysql_client/mysql_client.dart';
// Configuração de conexão com banco de dados
// Diretivas para conexão com o banco
const String _dbHost = '127.0.0.1'; // localhost
const int _dbPort = 3306;

// diretivas do usuário e o nome do database (altere conforme a sua necessidade)
const String _dbUser = 'lais';
const String _dbPassword = 'senha';
const String _dbDatabase = 'loja';

void main() async {
  // Inicializa a conexão com o banco de dados
  final conn = await conectarBanco();
  if (conn == null) {
      print('Não foi possível estabelecer conexão com o banco de dados.');
      return;
    }

    print('Conectado ao banco de dados');

  // chamada de api's   --- inicio
  /*
  await inserirCliente(conn, "Julia ", "julia@email.com");
  await inserirCliente(conn, "Carlos Henrique", "ch@email.com");

  await inserirPedido(conn, 1, "Fini Jujubas", 10.00);
  await inserirPedido(conn, 1, "Batata Pringeals", 15.00);
  await inserirPedido(conn, 2, "Pipoca ", 3.50);

  await listarClientesPedidos(conn);
  await totalPorCliente(conn);

  // chamada de api's   --- fim
  */

  await conn.close();
}

Future<MySQLConnection?> conectarBanco() async {
  try{
    final conn = await MySQLConnection.createConnection(
     host: _dbHost,
      port: _dbPort,
      userName: _dbUser,
      databaseName: _dbDatabase,
      password: _dbPassword,
    secure: false,
  );
    await conn.connect();
    return conn;
   } catch (erro) {
      print('Erro ao conectar ao banco de dados: $erro');
      return null;
  }
}

class Cliente {
  int? id;
  String nome;
  String email;

  Cliente({this.id, required this.nome, required this.email});

  @override
  String toString() {
    return "Cliente(id: $id, nome: $nome, email: $email)";
  }
}

class Pedido {
  int? id;
  int clienteId;
  String produto;
  double valor;

  Pedido({this.id, required this.clienteId, required this.produto, required this.valor});

  @override
  String toString() {
    return "Pedido(id: $id, clienteId: $clienteId, produto: $produto, valor: $valor)";
  }
}

Future<void> inserirCliente(MySQLConnection conn, String nome, String email) async {
  await conn.execute(
    "INSERT INTO clientes (nome, email) VALUES (:nome, :email)",
    {"nome": nome, "email": email},
  );
  print("Cliente $nome cadastrado com sucesso!");
}

Future<void> inserirPedido(MySQLConnection conn, int clienteId, String produto, double valor) async {
  await conn.execute(
    "INSERT INTO pedidos (cliente_id, produto, valor) VALUES (:cliente_id, :produto, :valor)",
    {
      "cliente_id": clienteId,
      "produto": produto,
      "valor": valor,
    },
  );
  print("Pedido de $produto adicionado para cliente $clienteId!");
}
Future<void> listarClientesPedidos(MySQLConnection conn) async {
  final result = await conn.execute("""
    SELECT c.id, c.nome, p.produto, p.valor
    FROM clientes c
    JOIN pedidos p ON c.id = p.cliente_id;
  """);

  print("\n=== LISTA DE PEDIDOS ===");
  for (final row in result.rows) {
    print("Cliente: ${row.colByName("nome")} | Produto: ${row.colByName("produto")} | Valor: R\$${row.colByName("valor")}");
  }
}
Future<void> totalPorCliente(MySQLConnection conn) async {
  final result = await conn.execute("""
    SELECT c.nome, SUM(p.valor) AS total
    FROM clientes c
    JOIN pedidos p ON c.id = p.cliente_id
    GROUP BY c.nome;
  """);

  print("\n=== TOTAL GASTO POR CLIENTE ===");
  for (final row in result.rows) {
    print("${row.colByName("nome")} → R\$${row.colByName("total")}");
  }
}
