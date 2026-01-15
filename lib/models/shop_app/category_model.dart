class CategoryModel {
  String? slug;
  String? name;
  String? url;

CategoryModel({
    this.slug,
  this.name,
  this.url
});

  CategoryModel.fromJson(Map<String , dynamic> json){
    slug = json['slug'];
    name = json['name'];
    url = json['url'];
  }
}