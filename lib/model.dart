class RecipeModel{
  late String applabel;
  late double Calories;
  late String appimageUrl;
  late String appurl;

  RecipeModel({this.applabel= "label", this.Calories=0.000 ,this.appimageUrl= "IMAGE", this.appurl= "URL"});
  factory RecipeModel.fromMap(Map recipe)
  {
    return RecipeModel(
        applabel: recipe["label"],
        Calories: recipe["calories"],
        appimageUrl: recipe["image"],
        appurl: recipe["url"]
    );
  }
}