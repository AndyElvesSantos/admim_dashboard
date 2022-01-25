class DenunciaModel {
  Data? data;

  DenunciaModel({this.data});

  DenunciaModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Denuncia>? denuncia;

  Data({this.denuncia});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Denuncia'] != null) {
      denuncia = <Denuncia>[];
      json['Denuncia'].forEach((v) {
        denuncia!.add(new Denuncia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.denuncia != null) {
      data['Denuncia'] = this.denuncia!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Denuncia {
  bool? atendido;
  String? bairro;
  String? cidade;
  String? descricao;
  String? estado;
  int? id;
  int? idade;
  String? nome;
  String? numero;
  String? rua;
  String? sexo;
  String? telefone;
  String? usuario;

  Denuncia(
      {this.atendido,
      this.bairro,
      this.cidade,
      this.descricao,
      this.estado,
      this.id,
      this.idade,
      this.nome,
      this.numero,
      this.rua,
      this.sexo,
      this.telefone,
      this.usuario});

  Denuncia.fromJson(Map<String, dynamic> json) {
    atendido = json['atendido'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    descricao = json['descricao'];
    estado = json['estado'];
    id = json['id'];
    idade = json['idade'];
    nome = json['nome'];
    numero = json['numero'];
    rua = json['rua'];
    sexo = json['sexo'];
    telefone = json['telefone'];
    usuario = json['usuario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['atendido'] = this.atendido;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['descricao'] = this.descricao;
    data['estado'] = this.estado;
    data['id'] = this.id;
    data['idade'] = this.idade;
    data['nome'] = this.nome;
    data['numero'] = this.numero;
    data['rua'] = this.rua;
    data['sexo'] = this.sexo;
    data['telefone'] = this.telefone;
    data['usuario'] = this.usuario;
    return data;
  }
}