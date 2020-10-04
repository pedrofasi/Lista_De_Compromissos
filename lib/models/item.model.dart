class Item {
  String nome;
  String data;
  bool concluido;

  Item({this.nome, this.data, this.concluido});

  Item.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    data = json ['data'];
    concluido = json['concluido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['data'] = this.data;
    data['concluido'] = this.concluido;
    return data;
  }
}