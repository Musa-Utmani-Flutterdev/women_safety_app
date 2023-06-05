
  class UserModel{
  String? name;
  String? phone;
  String? id;
  String? childEmail;
  String? guardianEmail;
  String? type;

  UserModel({this.name,this.phone,this.id,this.childEmail,this.guardianEmail,this.type});

    Map<String,dynamic> toJason()=>{
      'name':name,
      'phone':phone,
      'id':id,
      'childEmail':childEmail,
      'guardianEmail':guardianEmail,
      'type':type,
    };
  }