class ShopLoginModel{
 String? accessToken;
 String? refreshToken;
 int? id;
 String? username;
 String? email;
 String? firstName;
 String? lastName;
 String? gender;
 String? image;

ShopLoginModel({
  this.accessToken,
  this.refreshToken,
  this.id,
  this.username,
  this.email,
  this.firstName,
  this.lastName,
  this.gender,
  this.image,
});
 ShopLoginModel.fromJson(Map<String,dynamic> json){
     accessToken =json['accessToken'];
   refreshToken = json['refreshToken'];
   id = json['id'];
   username = json['username'];
   email = json['email'];
   firstName = json['firstName'];
   lastName = json['lastName'];
   gender = json['gender'];
   image = json['image'];

 }

}