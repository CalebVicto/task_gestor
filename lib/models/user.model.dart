class UsuarioModel {
  late int idUsuario;
  late String usuario;
  late String password;

  UsuarioModel({
    required this.idUsuario,
    required this.usuario,
    required this.password,
  });

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    idUsuario = json['id_usuario'];
    usuario = json['usuario'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario'] = idUsuario;
    data['usuario'] = usuario;
    data['password'] = password;
    return data;
  }
}
