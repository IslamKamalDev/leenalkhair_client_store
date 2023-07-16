class TokenPermissionsResponse {
  var iss;
  var iat;
  var nbf;
  var jti;
  var sub;
  var prv;
  List<Permissions>? permissions;

  TokenPermissionsResponse(
      {this.iss,
        this.iat,
        this.nbf,
        this.jti,
        this.sub,
        this.prv,
        this.permissions});

  TokenPermissionsResponse.fromJson(Map<String, dynamic> json) {
    iss = json['iss'];
    iat = json['iat'];
    nbf = json['nbf'];
    jti = json['jti'];
    sub = json['sub'];
    prv = json['prv'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iss'] = this.iss;
    data['iat'] = this.iat;
    data['nbf'] = this.nbf;
    data['jti'] = this.jti;
    data['sub'] = this.sub;
    data['prv'] = this.prv;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  var id;
  var name;

  Permissions({this.id, this.name});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}