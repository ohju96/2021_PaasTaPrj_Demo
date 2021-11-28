<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="">
<head>

<!-- meta charset -->
<meta charset="utf-8">
<!-- site title -->
<title>AII FOR YOU</title>
<!-- meta description -->
<meta name="description" content="">
<!-- mobile viwport meta -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- fevicon -->
<link rel="shortcut icon" type="image/x-icon"
   href="/resource/favicon.ico">

<!-- ================================
        CSS Files
        ================================= -->
<link
   href="https://fonts.googleapis.com/css?family=Libre+Baskerville:400,400i|Open+Sans:400,600,700,800"
   rel="stylesheet">
<link rel="stylesheet" href="/resource/css/themefisher-fonts.min.css">
<link rel="stylesheet" href="/resource/css/bootstrap.min.css">
<link rel="stylesheet" href="/resource/css/main.css">
<link rel="stylesheet" href="/resource/css/style.css">
<link id="color-changer" rel="stylesheet"
   href="/resource/css/colors/color-0.css">
   
<style>
.foodcolor{
color:#F7ADAD;
padding-left:10px;
}
</style>

   
</head>
   <script>
   /* 이미지 미리보기  */
   var sel_file;
   document.addEventListener("DOMContentLoaded", function() {
      document.getElementById('ex_file').addEventListener('change',handleImgFileSelect)
   })


   function handleImgFileSelect(e) {
      console.log(e);
      var files = e.target.files;
      var filesArr = Array.prototype.slice.call(files);
      filesArr.forEach(function(f) {
         if (!f.type.match("image.*")) {
            alert("확장자는 이미지 확장자만 가능합니다.");
            return;
         }
         sel_file = f;

         var reader = new FileReader();
         reader.onload = function(e) {
            document.getElementById('preview_text').src = e.target.result;
         }
         reader.readAsDataURL(f);
      });
   }
   
   
   /* 이미지 번역 ajax */
   function trans() {
      console.log("돼라")
      var form = $('#imageForm')[0];
      console.log(form)
      var formData = new FormData(form);
      console.log(formData)
      $.ajax({
         url : '/ocr/getReadforImageText.do',
         type : 'post',
         enctype : 'multipart/form-data',
         processData : false,
         contentType : false,
         cache : false,
         timeout : 600000,
         data : formData,
         success : function(data) {
            console.log("성공");
            console.log(data.map(item=> item.food_name));
            $('#food_name').text(data.map(item=> item.food_name));
            $('#food_material').text(data.map(item=> item.food_material));
            alert(data.map(item=> item.alert));
         },
         error : function(e) {
            alert("error");
         }
      })
   }
   </script>

<body>

   <div class="preloader">
      <div class="loading-mask"></div>
      <div class="loading-mask"></div>
      <div class="loading-mask"></div>
      <div class="loading-mask"></div>
      <div class="loading-mask"></div>
   </div>


   <main class="site-wrapper">
      <div class="pt-table">
         <div class="pt-tablecell page-contact relative">
            <!-- .close -->
            <a href="./" class="page-close"><i class="tf-ion-close"></i></a>
            <!-- /.close -->

            <div class="container">
               <div class="row">
                  <div
                     class="col-xs-12 col-md-offset-1 col-md-10 col-lg-offset-2 col-lg-8 ">
                     <div class="page-title text-center login_imgbiv clearing_gap">
                        <h2>
                           <a href="/index.do"><img src="/resource/img/logorm.png" class="login_logo"></a>
                           <!--<h2>All <span class="primary">for you</span><span class="title-bg">Welcome</span>-->
                        </h2>
                        <p> 알레르기 검색을 위해 음식사진을 업로드해주세요.
                        </p>
                     </div>
                  </div>
            
               </div>
               <!-- /.row -->

               <div class="row">

                  <div
                     class="col-xs-12 col-sm-7 col-md-7 col-md-offset-1 col-lg-offset-2 login_box mid">
                     <div class="section-title clear">
                             
                        <h3>알레르기 검색</h3>
                        <br>
                        <h4>음식 사진을 업로드해주세요.</h4>
                        <span class="bar-dark"></span> <span class="bar-primary"></span>
                     </div>
                     <div class="row">
                        <form id="imageForm" method="post" enctype="multipart/form-data">
                           <div class="col-xs-12 col-sm-12">
                              <div class="input-field">
                                 <span class="btn-border email_length">
                                    <label for="ex_file" class="btn btn-primary btn-custom-border text-uppercase email_length"style="margin-bottom:0px; width:100%; height:100%; text-align:center;
                                          font-weight:600; ">올리기</label>
                                    <input type="file" name="fileUpload" id="ex_file" style="display:none;">
                                 </span>
                              </div>
                           </div>
                        </form>
                        <div class="col-xs-12 col-sm-12">
                              <div class="input-field">
                                 <span class="btn-border email_length">
                                    <button class="btn btn-primary btn-custom-border text-uppercase email_length" onclick="trans()">분석하기</button>
                                 </span>
                              </div>
                           </div>
                     </div>
                     <div class="pd-20 bg-white border-radius-4 box-shadow mb-30">
                        <div id="carouselExampleCaptions"
                           class="carousel slide pointer-event">
                           <div id="image_container">
                              <img id="preview_text" style="width:100%;" />
                           </div>
                        </div>
                     </div>
                     <div class="pd-20 bg-white border-radius-4 box-shadow mb-30">
                        <div id="carouselExampleCaptions"
                           class="carousel slide pointer-event" data-ride="carousel" style="font-weight: bold; width:100%;">
                           <div style="float:left;">음식 : </div><div id="food_name" class="foodcolor" style="padding-left: 50px;"></div>
                           <br> <div style="float:left;">원재료 :</div><div id="food_material" class="foodcolor" style="padding-left:65px;"></div>
                        </div>
                     </div>
                        </div>
                        <!-- ./col- -->
                     <!-- /.row -->
                  </div>
                  <!-- /.col- -->
               </div>
               <!-- /.row -->
                <nav class="page-nav clear">
               <div class="container">
                  <div class="flex flex-middle space-between">
                     <span class="prev-page"><a href="/index.do"
                        class="link">&larr; 이전</a></span> <span class="copyright hidden-xs">Copyright
                        &copy; 2021 ALL FOR YOU, All Rights Reserved.</span>
                  </div>
               </div>
               <!-- /.page-nav -->
            </nav>
            </div>
         </div>
         <!-- /.pt-tablecell -->
      <!-- /.pt-table -->
   </main>
   <!-- /.site-wrapper -->

   <!-- ================================
        JavaScript Libraries
        ================================= -->
   <script src="/resource/js/vendor/jquery-2.2.4.min.js"></script>
   <script src="/resource/js/vendor/bootstrap.min.js"></script>
   <script src="/resource/js/jquery.easing.min.js"></script>
   <script src="/resource/js/isotope.pkgd.min.js"></script>
   <script src="/resource/js/jquery.nicescroll.min.js"></script>
   <script src="/resource/js/owl.carousel.min.js"></script>
   <script src="/resource/js/jquery-validation.min.js"></script>
   <script src="/resource/js/form.min.js"></script>
   <script src="/resource/js/main.js"></script>
</body>
</html>