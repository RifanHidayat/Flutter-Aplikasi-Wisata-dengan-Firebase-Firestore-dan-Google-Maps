class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("");
  sliderModel.setTitle("Wellcome Travel App");
  sliderModel.setImageAssetPath("assets/images/onboarding-1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Cari Destinasi favorite anda");
  sliderModel.setTitle("Travel App");
  sliderModel.setImageAssetPath("assets/images/onboarding-2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Liburan lebih mudah ");
  sliderModel.setTitle("Travel App");
  sliderModel.setImageAssetPath("assets/images/onboarding-3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}