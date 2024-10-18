import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:landmarkapp/Routes/app_routes.dart';
import 'package:landmarkapp/model/recommendation_model.dart';
import 'package:landmarkapp/model/result_model.dart';
import 'package:landmarkapp/utils/http_calls.dart';
import 'package:landmarkapp/utils/loader.dart';

class HomeController extends GetxController {
  var isUploaded = false.obs;
  dio.MultipartFile? file;
  var landmarkInfo = [
    {
      "Name": "Kala Ghoda",
      "name": "Kala Ghoda",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Kala_Ghoda_Statue.jpg/1200px-Kala_Ghoda_Statue.jpg",
      "location_link":
          "https://www.google.com/maps/place/Kala+Ghoda/@18.9307214,72.8330849,14z/data=!4m8!1m2!2m1!1sKala+Ghoda!3m4!1s0x3be7d1c49f5d2d63:0xea3b16943edca7ce!8m2!3d18.9307214!4d72.8330849",
      "latitude": 18.93072139160438,
      "longitude": 72.83308490909272
    },
    {
      "Name":
          "Vivekanand Education Society_s Institute of Technology (VESIT) - Chembur",
      "name": "Vivekanand Education Society's Institute Of Technology (VESIT)",
      "image link":
          "https://media.licdn.com/dms/image/C511BAQE5K66Gz4qP2g/company-background_10000/0/1584494950171/vesit_cover?e=2147483647&v=beta&t=zWQsj9P-3AzhHaWxvjJ5O1Tvc-x-NZ8YPbC1ZHVtT8o",
      "location_link":
          "https://www.google.com/maps/place/Vivekanand+Education+Society%27s+Institute+Of+Technology+%28VESIT%29/@19.045727499999998,72.8892177,14z/data=!4m8!1m2!2m1!1sVivekanand+Education+Society%27s+Institute+Of+Technology+%28VESIT%29!3m4!1s0x3be7c8add9569a29:0xb7ad04bf9a389df7!8m2!3d19.045727499999998!4d72.8892177",
      "latitude": 19.0453072378157,
      "longitude": 72.88895891222774
    },
    {
      "Name": "One Indiabulls Centre",
      "name": "One Indiabulls Centre",
      "image link":
          "https://cf-cdn.cityinfoservices.com/public/uploads/property/images/medium/722795d36b1ee6c912One%20Indiabulls%20Centre%20-%20Tower%202A_2B.jpg",
      "location_link":
          "https://www.google.com/maps/place/One+Indiabulls+Centre/@19.0066044,72.8324258,14z/data=!4m8!1m2!2m1!1sOne+Indiabulls+Centre!3m4!1s0x3be7ceebf9b85051:0x9b2aec737f1a7ce!8m2!3d19.0066044!4d72.8324258",
      "latitude": 19.00663121212131,
      "longitude": 72.83236898693598
    },
    {
      "Name": "Haji Ali Dargah, Worli",
      "name": "Haji Ali Dargah",
      "image link":
          "https://static.toiimg.com/thumb/64061841/Haji-Ali-Dargah-all-that-you-need-to-know-about-this-floating-wonder.jpg?width=1200&height=900",
      "location_link":
          "https://www.google.com/maps/place/Haji+Ali+Dargah/@18.9828273,72.8088966,14z/data=!4m8!1m2!2m1!1sHaji+Ali+Dargah!3m4!1s0x3be7ce7e930d42e3:0xd5e05dc7ab078d05!8m2!3d18.9828273!4d72.8088966",
      "latitude": 18.98282725732249,
      "longitude": 72.80889655919913
    },
    {
      "Name": "The Oberoi, Mumbai",
      "name": "The Oberoi, Mumbai",
      "image link":
          "https://cf.bstatic.com/xdata/images/hotel/max1024x768/28759044.jpg?k=4a3e476214895d86a0e71808d9eb5b85acaebe0cbff06bbd2ecdbb3054d98600&o=&hp=1",
      "location_link":
          "https://www.google.com/maps/place/The+Oberoi%2C+Mumbai/@18.926975,72.8204516,14z/data=!4m8!1m2!2m1!1sThe+Oberoi%2C+Mumbai!3m4!1s0x3be7d1e96fffffff:0x385eaa65d82abec1!8m2!3d18.926975!4d72.8204516",
      "latitude": 18.9272484,
      "longitude": 72.8201127
    },
    {
      "Name": "Babulnath Temple",
      "name": "Shree Babulnath Mandir",
      "image link":
          "https://media-cdn.tripadvisor.com/media/photo-o/12/99/65/95/tempio.jpg",
      "location_link":
          "https://www.google.com/maps/place/Shree+Babulnath+Mandir+Charities/@18.9573425,72.8084384,14z/data=!4m8!1m2!2m1!1sShree+Babulnath+Mandir+Charities!3m4!1s0x3be7ce0966bc544b:0x4ef0294279e779d!8m2!3d18.9573425!4d72.8084384",
      "latitude": 18.95738775711088,
      "longitude": 72.80843960787539
    },
    {
      "Name": "Wadiaji Atash Behram, Grant Road",
      "name": "Wadiaji Ateshbehram",
      "image link":
          "https://zagny.org/wp-content/uploads/Wadiaji-Atash-Behram.jpg",
      "location_link":
          "https://www.google.com/maps/place/Wadiaji+Ateshbehram/@18.9458593,72.82721579999999,14z/data=!4m8!1m2!2m1!1sWadiaji+Ateshbehram!3m4!1s0x3be7ce1f7a1031e7:0xc6e70132eff8eb1d!8m2!3d18.9458593!4d72.82721579999999",
      "latitude": 18.94585927920776,
      "longitude": 72.82721583609352
    },
    {
      "Name": "Imperial Towers",
      "name": "The Imperial Tower",
      "image link":
          "https://www.guptasen.com/wp-content/uploads/2021/02/homes-for-sale-imperial-towers-tardeo-south-mumbai.jpg",
      "location_link":
          "https://www.google.com/maps/place/The+Imperial/@18.9709055,72.8128673,14z/data=!4m8!1m2!2m1!1sThe+Imperial!3m4!1s0x3be7ce71737d96fd:0x45d84f73059edc!8m2!3d18.9709055!4d72.8128673",
      "latitude": 18.97090550200824,
      "longitude": 72.81286725723062
    },
    {
      "Name": "St. Xavier_s College - Fort",
      "name": "St. Xavier's College (Autonomous)",
      "image link":
          "https://media-cdn.tripadvisor.com/media/photo-o/0a/69/59/ac/photo0jpg.jpg",
      "location_link":
          "https://www.google.com/maps/place/St.+Xavier%27s+College+%28Autonomous%29/@18.9426104,72.8315117,14z/data=!4m8!1m2!2m1!1sSt.+Xavier%27s+College+%28Autonomous%29!3m4!1s0x3be7b870ba222b0b:0xa35fb09925b0951d!8m2!3d18.9426104!4d72.8315117",
      "latitude": 18.9422805,
      "longitude": 72.8312663
    },
    {
      "Name": "Oberoi Garden City",
      "name": "Oberoi Garden City",
      "image link":
          "https://www.architectandinteriorsindia.com/cloud/2021/11/15/oberoi-1.jpg",
      "location_link":
          "https://www.google.com/maps/place/Oberoi+Garden+City/@19.171948699999998,72.8632251,14z/data=!4m8!1m2!2m1!1sOberoi+Garden+City!3m4!1s0x3be7b7a89d186537:0x858fa6406284c271!8m2!3d19.171948699999998!4d72.8632251"
    },
    {
      "Name": "Sanjay Gandhi National Park",
      "name": "Sanjay Gandhi National Park",
      "image link":
          "https://vajiram-prod.s3.ap-south-1.amazonaws.com/Sanjay_Gandhi_National_Park_6025c3f5dd.jpg",
      "location_link":
          "https://www.google.com/maps/place/Sanjay+Gandhi+National+Park/@19.232779,72.8717923,14z/data=!4m8!1m2!2m1!1sSanjay+Gandhi+National+Park!3m4!1s0x3be7b0c88c663f99:0xd3d9a423d95dbc06!8m2!3d19.232779!4d72.8717923",
      "latitude": 19.2327789703183,
      "longitude": 72.87179232460547
    },
    {
      "Name": "Gloria Church, Byculla",
      "name": "Gloria Church",
      "image link":
          "https://live.staticflickr.com/220/486870735_1c50418a47_b.jpg",
      "location_link":
          "https://www.google.com/maps/place/Gloria+Church/@18.9751463,72.8343331,14z/data=!4m8!1m2!2m1!1sGloria+Church!3m4!1s0x3be7ce5a6aaaaaab:0x3f3da8f08bd8cf20!8m2!3d18.9751463!4d72.8343331",
      "latitude": 18.9755329,
      "longitude": 72.83449499999999
    },
    {
      "Name": "Raheja Towers",
      "name": "Raheja Towers",
      "image link":
          "https://www.mindspaceindia.com/wp-content/uploads/2020/11/raheja-1.jpg",
      "location_link":
          "https://www.google.com/maps/place/Raheja+Towers/@19.067650999999998,72.867302,14z/data=!4m8!1m2!2m1!1sRaheja+Towers!3m4!1s0x3be7c8eec5964717:0xb9592374ed7a843b!8m2!3d19.067650999999998!4d72.867302",
      "latitude": 19.06765096206684,
      "longitude": 72.86730201618461
    },
    {
      "Name": "Wilson College - Chowpatty",
      "name": "Wilson College",
      "image link":
          "https://images.collegedunia.com/public/college_data/images/appImage/5422_WILSON_APP.jpg",
      "location_link":
          "https://www.google.com/maps/place/Wilson+College/@18.9563319,72.81082599999999,14z/data=!4m8!1m2!2m1!1sWilson+College!3m4!1s0x3be7c88d0446cd13:0x5d70fd2fa641a411!8m2!3d18.9563319!4d72.81082599999999",
      "latitude": 18.95631789391013,
      "longitude": 72.8108266011139
    },
    {
      "Name": "Rizvi College of Engineering - Bandra",
      "name": "Rizvi College of Engineering",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/RCoE_-_RCoA_common_entrance.jpg/400px-RCoE_-_RCoA_common_entrance.jpg",
      "location_link":
          "https://www.google.com/maps/place/Rizvi+College+of+Engineering/@19.0667743,72.8261193,14z/data=!4m8!1m2!2m1!1sRizvi+College+of+Engineering!3m4!1s0x3be7c90ee61a46d9:0x632e25778a624051!8m2!3d19.0667743!4d72.8261193",
      "latitude": 19.0667786,
      "longitude": 72.8262372
    },
    {
      "Name": "Teerthdham Mangalayatan, Vasai",
      "name": "Vasai-Virar",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/b/b0/Mangtemp5.jpg",
      "location_link":
          "https://www.google.com/maps/place/Vasai-Virar/@19.391927499999998,72.8397317,14z/data=!4m8!1m2!2m1!1sVasai-Virar!3m4!1s0x3be7ae956bc1587b:0x864f53a94baa5145!8m2!3d19.391927499999998!4d72.8397317",
      "latitude": 19.41708317638873,
      "longitude": 72.8594690616956
    },
    {
      "Name": "Rajiv Gandhi Institute of Technology (RGIT) - Versova",
      "name": "Rajiv Gandhi Institute of Technology",
      "image link":
          "https://images.collegedunia.com/public/college_data/images/appImage/14734_RGIT_New.jpg",
      "location_link":
          "https://www.google.com/maps/place/Rajiv+Gandhi+Institute+of+Technology/@19.1212925,72.82371429999999,14z/data=!4m8!1m2!2m1!1sRajiv+Gandhi+Institute+of+Technology!3m4!1s0x3be7c9e13ef12003:0x5767a74a751ccaf9!8m2!3d19.1212925!4d72.82371429999999",
      "latitude": 19.1217094,
      "longitude": 72.8234587
    },
    {
      "Name": "Powai Lake",
      "name": "Powai Lake",
      "image link":
          "https://a.travel-assets.com/findyours-php/viewfinder/images/res70/472000/472855-Mumbai.jpg",
      "location_link":
          "https://www.google.com/maps/place/Powai+Lake/@19.1272655,72.9048498,14z/data=!4m8!1m2!2m1!1sPowai+Lake!3m4!1s0x3be7c7fbff50aca3:0x8437eb732766346c!8m2!3d19.1272655!4d72.9048498",
      "latitude": 19.12726546243281,
      "longitude": 72.90484977512756
    },
    {
      "Name": "Mahalakshmi Temple, Mahalaxmi",
      "name": "Mahalakshmi Temple Rd",
      "image link":
          "https://media-cdn.tripadvisor.com/media/photo-o/0e/e9/4e/d9/entrance-to-mahalaxmi.jpg",
      "location_link":
          "https://www.google.com/maps/place/Mahalakshmi+Temple+Rd/@18.9772374,72.8081017,14z/data=!4m8!1m2!2m1!1sMahalakshmi+Temple+Rd!3m4!1s0x3be7ce79bbc35f59:0x111b9e321e742016!8m2!3d18.9772374!4d72.8081017",
      "latitude": 18.9772373686987,
      "longitude": 72.80810167252871
    },
    {
      "Name": "Sion Fort",
      "name": "Sion Fort",
      "image link":
          "https://cdn.guidetour.in/wp-content/uploads/2023/08/Sion-Fort-Mumbai.jpg.webp",
      "location_link":
          "https://www.google.com/maps/place/Sion+Fort/@19.0465882,72.8676815,14z/data=!4m8!1m2!2m1!1sSion+Fort!3m4!1s0x3be7c8cee037da53:0xcf5d37e6fe98835e!8m2!3d19.0465882!4d72.8676815",
      "latitude": 19.04658820858161,
      "longitude": 72.867681515103
    },
    {
      "Name": "Grant Medical College - Byculla",
      "name": "Grant Government Medical College",
      "image link":
          "https://asmicareer.com/wp-content/uploads/2024/01/screenshot_1-97.jpg",
      "location_link":
          "https://www.google.com/maps/place/Grant+Government+Medical+College/@18.963068399999997,72.8336083,14z/data=!4m8!1m2!2m1!1sGrant+Government+Medical+College!3m4!1s0x3be7ce3ed52a45b3:0xe18e4692100cf457!8m2!3d18.963068399999997!4d72.8336083",
      "latitude": 18.96306841838791,
      "longitude": 72.83360825848946
    },
    {
      "Name": "Taraporewala Aquarium",
      "name": "Taraporevala Aquarium",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/TaraporewalaAquarium_Renovated.jpg",
      "location_link":
          "https://www.google.com/maps/place/Taraporevala+Aquarium/@18.9492588,72.82003019999999,14z/data=!4m8!1m2!2m1!1sTaraporevala+Aquarium!3m4!1s0x3be7ce1bbc806f01:0x2ec42768fb318cb7!8m2!3d18.9492588!4d72.82003019999999",
      "latitude": 18.9492587838271,
      "longitude": 72.82003020158076
    },
    {
      "Name": "Sewri Fort",
      "name": "Sewri Fort",
      "image link":
          "https://vajiram-prod.s3.ap-south-1.amazonaws.com/Sewri_fort_898a0ea420.jpg",
      "location_link":
          "https://www.google.com/maps/place/Sewri+Fort/@19.0006679,72.86012649999999,14z/data=!4m8!1m2!2m1!1sSewri+Fort!3m4!1s0x3be7cf04fc92ea3b:0xf15095786e72027c!8m2!3d19.0006679!4d72.86012649999999",
      "latitude": 19.0006679298348,
      "longitude": 72.86012649009443
    },
    {
      "Name": "Bandra-Worli Sea Link",
      "name": "Bandra Worli Sea Link",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/a/ae/Bandra_Worli_Sea-Link_%28cropped%29.jpg",
      "location_link":
          "https://www.google.com/maps/place/Bandra+Worli+Sea+Link/@19.0285215,72.8153121,14z/data=!4m8!1m2!2m1!1sBandra+Worli+Sea+Link!3m4!1s0x3be7ceadede4b47f:0x25bb2ff9ed38dca7!8m2!3d19.0285215!4d72.8153121",
      "latitude": 19.0285214694592,
      "longitude": 72.81531209108829
    },
    {
      "Name": "Reserve Bank of India (RBI) building",
      "name": "Reserve Bank of India",
      "image link":
          "https://www.shapoorjipallonji.com/assets/Desktop/Projects/640x640/reserve-bank-of-india-new-640x640.jpg",
      "location_link":
          "https://www.google.com/maps/place/Reserve+Bank+of+India/@18.9331899,72.8364648,14z/data=!4m8!1m2!2m1!1sReserve+Bank+of+India!3m4!1s0x3be7d1db1aab3963:0xd0dec989eec8459e!8m2!3d18.9331899!4d72.8364648",
      "latitude": 18.9327770299762,
      "longitude": 72.83697714119855
    },
    {
      "Name": "The Leela Mumbai",
      "name": "The Leela Mumbai - Resort Style Business Hotel",
      "image link":
          "https://media-cdn.tripadvisor.com/media/photo-o/2a/b2/28/6e/exterior-panorama-view.jpg",
      "location_link":
          "https://www.google.com/maps/place/The+Leela+Mumbai+-+Resort+Style+Business+Hotel/@19.1090922,72.87381859999999,14z/data=!4m8!1m2!2m1!1sThe+Leela+Mumbai+-+Resort+Style+Business+Hotel!3m4!1s0x3be7c83fc0eb5271:0x52b711524a2da569!8m2!3d19.1090922!4d72.87381859999999",
      "latitude": 19.1087813,
      "longitude": 72.8736807
    },
    {
      "Name": "Gilbert Hill",
      "name": "Gilbert hill",
      "image link":
          "https://static.india.com/wp-content/uploads/2017/07/gilbert-hill.jpg?impolicy=Medium_Resize&w=1200&h=800",
      "location_link":
          "https://www.google.com/maps/place/Gilbert+hill/@19.1205717,72.8401933,14z/data=!4m8!1m2!2m1!1sGilbert+hill!3m4!1s0x3be7c9d0a3dd1673:0xc90c2bb3a3983a89!8m2!3d19.1205717!4d72.8401933",
      "latitude": 19.12057169292608,
      "longitude": 72.8401932592033
    },
    {
      "Name": "The Asiatic Society of Mumbai",
      "name": "The Asiatic Society, Mumbai",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/f/f9/Mumbai_03-2016_70_Asiatic_Society_Library.jpg",
      "location_link":
          "https://www.google.com/maps/place/The+Asiatic+Society%2C+Mumbai/@18.9318486,72.8357996,14z/data=!4m8!1m2!2m1!1sThe+Asiatic+Society%2C+Mumbai!3m4!1s0x3be7d1db2d1680df:0x2ce4015ac112d3f9!8m2!3d18.9318486!4d72.8357996",
      "latitude": 18.93184863109727,
      "longitude": 72.83579964228923
    },
    {
      "Name": "Magen David Synagogue, Byculla",
      "name": "Magen David Synagogue",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/9/93/Magen_David_Synagogue%2C_Byculla%2C_Mumbai.jpg",
      "location_link":
          "https://www.google.com/maps/place/Magen+David+Synagogue/@18.9669457,72.8321706,14z/data=!4m8!1m2!2m1!1sMagen+David+Synagogue!3m4!1s0x3be7ce40967f81e5:0x3a1d62b566add929!8m2!3d18.9669457!4d72.8321706",
      "latitude": 18.9673314,
      "longitude": 72.83203619999999
    },
    {
      "Name":
          "National Institute of Fashion Technology (NIFT) Mumbai - Kharghar",
      "name": "National Institute of Fashion Technology",
      "image link":
          "https://abped-college-dashboard.s3.us-east-2.amazonaws.com/tted/college-backend/college/ded6c8af-2426-48b4-9bad-592e59f871ec.jpg",
      "location_link":
          "https://www.google.com/maps/place/National+Institute+of+Fashion+Technology/@19.029894499999997,73.06095119999999,14z/data=!4m8!1m2!2m1!1sNational+Institute+of+Fashion+Technology!3m4!1s0x3be7cee784e322ad:0x2cb6eb7d37a0d33!8m2!3d19.029894499999997!4d73.06095119999999",
      "latitude": 19.02989446123297,
      "longitude": 73.06095120083654
    },
    {
      "Name": "Pillai College of Engineering - Panvel",
      "name": "Pillai College of Engineering, New Panvel (Autonomous)",
      "image link":
          "https://images.shiksha.com/mediadata/images/1505387934php0zH9ZO.jpeg",
      "location_link":
          "https://www.google.com/maps/place/Pillai+College+of+Engineering%2C+New+Panvel+%28Autonomous%29/@18.990201,73.1276701,14z/data=!4m8!1m2!2m1!1sPillai+College+of+Engineering%2C+New+Panvel+%28Autonomous%29!3m4!1s0x3be7e866de88667f:0xc1c5d5badc610f5f!8m2!3d18.990201!4d73.1276701",
      "latitude": 18.9898024,
      "longitude": 73.12788379999999
    },
    {
      "Name": "Indian Institute of Technology (IIT) Bombay - Powai",
      "name": "Indian Institute of Technology Bombay",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/IITBMainBuildingCROP.jpg/640px-IITBMainBuildingCROP.jpg",
      "location_link":
          "https://www.google.com/maps/place/Indian+Institute+of+Technology+Bombay/@19.1330605,72.9151061,14z/data=!4m8!1m2!2m1!1sIndian+Institute+of+Technology+Bombay!3m4!1s0x3be7c7f189efc039:0x68fdcea4c5c5894e!8m2!3d19.1330605!4d72.9151061",
      "latitude": 19.1330605,
      "longitude": 72.9151061
    },
    {
      "Name": "Rustomjee Business School - Dahisar",
      "name": "Rustomjee Business School Mumbai",
      "image link":
          "https://images.collegedunia.com/public/college_data/images/campusimage/1427791075core-0001-fdbffe7325a070690125a1240ee35a47.l_data-0001-fdbffe74269d942c0126a1fd0a530bb3.jpg",
      "location_link":
          "https://www.google.com/maps/place/Rustomjee+Business+School+Mumbai/@19.2412272,72.8583378,14z/data=!4m8!1m2!2m1!1sRustomjee+Business+School+Mumbai!3m4!1s0x3be7d1d998b45a1f:0x8e4790814349ad4!8m2!3d19.2412272!4d72.8583378",
      "latitude": 19.2410913,
      "longitude": 72.8583286
    },
    {
      "Name": "Sophia College for Women - Peddar Road",
      "name": "Sophia College (AUTONOMOUS)",
      "image link": "https://sophiacollegemumbai.com/img/Feb%202009%20032.jpg",
      "location_link":
          "https://www.google.com/maps/place/Sophia+College+%28AUTONOMOUS%29/@18.9695131,72.8076379,14z/data=!4m8!1m2!2m1!1sSophia+College+%28AUTONOMOUS%29!3m4!1s0x3be7cf9507075e4d:0x29a70be09134d7aa!8m2!3d18.9695131!4d72.8076379",
      "latitude": 18.9695131104523,
      "longitude": 72.80763786722869
    },
    {
      "Name": "SNDT Women_s University - Churchgate",
      "name": "SNDT WOMEN'S UNIVERSITY, MUMBAI",
      "image link": "https://sndt.ac.in/images/juhu-photo-gallery/CST_0408.JPG",
      "location_link":
          "https://www.google.com/maps/place/SNDT+WOMEN%27S+UNIVERSITY%2C+MUMBAI/@18.9379295,72.8280927,14z/data=!4m8!1m2!2m1!1sSNDT+WOMEN%27S+UNIVERSITY%2C+MUMBAI!3m4!1s0x3be7d1e397a7704d:0x1418e4b279d4be4f!8m2!3d18.9379295!4d72.8280927",
      "latitude": 18.9380872,
      "longitude": 72.8280764
    },
    {
      "Name": "Khada Parsi Statue",
      "name": "Khada Parsi Statue",
      "image link":
          "https://th-i.thgim.com/public/migration_catalog/article11303073.ece/alternates/FREE_1200/KHADA_PARSI_",
      "location_link":
          "https://www.google.com/maps/place/Khada+Parsi+Statue/@18.9715541,72.8324427,14z/data=!4m8!1m2!2m1!1sKhada+Parsi+Statue!3m4!1s0x3be7ce415ff36f49:0xa4985dc4215da5d3!8m2!3d18.9715541!4d72.8324427",
      "latitude": 18.97155408988903,
      "longitude": 72.83244273395717
    },
    {
      "Name": "Siddhivinayak Temple, Prabhadevi",
      "name": "Shree Siddhivinayak Temple",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/b/b9/Shree_Siddhivinayak_Temple_Mumbai.jpg",
      "location_link":
          "https://www.google.com/maps/place/Shree+Siddhivinayak+Temple/@19.01699,72.8303997,14z/data=!4m8!1m2!2m1!1sShree+Siddhivinayak+Temple!3m4!1s0x3be7cec0d851ebc3:0xcc61876914526329!8m2!3d19.01699!4d72.8303997",
      "latitude": 19.01688466602756,
      "longitude": 72.83026141747052
    },
    {
      "Name": "Sir J.J. College of Architecture - Fort",
      "name": "Sir J J College Of Architecture",
      "image link":
          "https://images.collegedunia.com/public/college_data/images/appImage/5680_SJJA_APP.jpg",
      "location_link":
          "https://www.google.com/maps/place/Sir+J+J+College+Of+Architecture/@18.9442007,72.8338888,14z/data=!4m8!1m2!2m1!1sSir+J+J+College+Of+Architecture!3m4!1s0x3be7ce20cc2c3e79:0xe31d2bd7d79de82b!8m2!3d18.9442007!4d72.8338888",
      "latitude": 18.9445222,
      "longitude": 72.8342962
    },
    {
      "Name": "Bhau Daji Lad Museum",
      "name": "Dr. Bhau Daji Lad Museum",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/1/1b/Dr._Bhau_Daji_Lad_Museum%2C_esterno_01.jpg",
      "location_link":
          "https://www.google.com/maps/place/Dr.+Bhau+Daji+Lad+Museum/@18.978988899999997,72.8348153,14z/data=!4m8!1m2!2m1!1sDr.+Bhau+Daji+Lad+Museum!3m4!1s0x3be7ce5b428e70af:0x79efde6c140c2e05!8m2!3d18.978988899999997!4d72.8348153",
      "latitude": 18.9788866,
      "longitude": 72.8347459
    },
    {
      "Name": "Antilia",
      "name": "Antilia",
      "image link":
          "https://im.indiatimes.in/amp/2019/Jun/antilia_1559648045.jpg?w=400&h=300&cc=1&webp=1&q=75",
      "location_link":
          "https://www.google.com/maps/place/Antilia/@18.968020799999998,72.80949629999999,14z/data=!4m8!1m2!2m1!1sAntilia!3m4!1s0x3be7ce740c73d241:0x2f342887d5ce589f!8m2!3d18.968020799999998!4d72.80949629999999",
      "latitude": 18.96802080520057,
      "longitude": 72.80949632906027
    },
    {
      "Name": "Ghodbunder Fort",
      "name": "Ghodbunder Fort",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/5/5c/Ghodbunder_Fort_courtyard.jpg",
      "location_link":
          "https://www.google.com/maps/place/Ghodbunder+Fort/@19.2961054,72.8883326,14z/data=!4m8!1m2!2m1!1sGhodbunder+Fort!3m4!1s0x3be7b00d9fa57c6d:0xa90b702b630eced0!8m2!3d19.2961054!4d72.8883326",
      "latitude": 19.29610542668753,
      "longitude": 72.88833256856151
    },
    {
      "Name": "Veermata Jijabai Technological Institute (VJTI) - Matunga",
      "name": "Veermata Jijabai Technological Institute",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/VJTI_Quadrangle.jpg/640px-VJTI_Quadrangle.jpg",
      "location_link":
          "https://www.google.com/maps/place/Veermata+Jijabai+Technological+Institute/@19.0222181,72.85612119999999,14z/data=!4m8!1m2!2m1!1sVeermata+Jijabai+Technological+Institute!3m4!1s0x3be7cf26f4972d21:0x2c50185364aca4c1!8m2!3d19.0222181!4d72.85612119999999",
      "latitude": 19.0232042,
      "longitude": 72.85693069999999
    },
    {
      "Name": "Taj Mahal Palace Hotel",
      "name": "The Taj Mahal Palace, Mumbai",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/0/09/Mumbai_Aug_2018_%2843397784544%29.jpg",
      "location_link":
          "https://www.google.com/maps/place/The+Taj+Mahal+Palace%2C+Mumbai/@18.9216631,72.8332028,14z/data=!4m8!1m2!2m1!1sThe+Taj+Mahal+Palace%2C+Mumbai!3m4!1s0x3be7d1c06fffffff:0xc0290485a4d73f57!8m2!3d18.9216631!4d72.8332028",
      "latitude": 18.9219584,
      "longitude": 72.8325365
    },
    {
      "Name": "Afghan Church",
      "name": "Afghan Church Official",
      "image link":
          "https://imgstaticcontent.lbb.in/lbbnew/wp-content/uploads/sites/7/2016/11/11112016_AfghanChurch_Ap4.jpg",
      "location_link":
          "https://www.google.com/maps/place/Afghan+Church+Official/@18.906491,72.816388,14z/data=!4m8!1m2!2m1!1sAfghan+Church+Official!3m4!1s0x3be7cf21727d5445:0x8e7a2eb3befec0ec!8m2!3d18.906491!4d72.816388",
      "latitude": 18.9064261,
      "longitude": 72.8165997
    },
    {
      "Name": "M.H. Saboo Siddik College of Engineering - Byculla",
      "name": "M.H. Saboo Siddik College of Engineering",
      "image link": "https://www.mhssce.ac.in/images/about/2.jpg",
      "location_link":
          "https://www.google.com/maps/place/M.H.+Saboo+Siddik+College+of+Engineering/@18.9681556,72.8313206,14z/data=!4m8!1m2!2m1!1sM.H.+Saboo+Siddik+College+of+Engineering!3m4!1s0x3be7ce40ffcfcacd:0x5d71ff22760f8e77!8m2!3d18.9681556!4d72.8313206",
      "latitude": 18.96815562978475,
      "longitude": 72.83132056874253
    },
    {
      "Name": "Rajabai Clock Tower",
      "name": "Rajabai Clock Tower",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Rajabai_Clock_Tower%2C_Mumbai_%2831_August_2008%29.jpg/1200px-Rajabai_Clock_Tower%2C_Mumbai_%2831_August_2008%29.jpg",
      "location_link":
          "https://www.google.com/maps/place/Rajabai+Clock+Tower/@18.9297669,72.830083,14z/data=!4m8!1m2!2m1!1sRajabai+Clock+Tower!3m4!1s0x3be7d1c2dd3082b3:0x15db02833bd8cc03!8m2!3d18.9297669!4d72.830083",
      "latitude": 18.92976672284538,
      "longitude": 72.82998094175953
    },
    {
      "Name": "Vasai Fort",
      "name": "Vasai Fort",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Vasai_fort_building2.jpg/640px-Vasai_fort_building2.jpg",
      "location_link":
          "https://www.google.com/maps/place/Vasai+Fort/@19.330556599999998,72.8155747,14z/data=!4m8!1m2!2m1!1sVasai+Fort!3m4!1s0x3be7ae0d11f21ae5:0x178d6c5c42c53d28!8m2!3d19.330556599999998!4d72.8155747",
      "latitude": 19.33053800251427,
      "longitude": 72.8155814036073
    },
    {
      "Name": "Bombay Art Society",
      "name": "The Bombay Art Society",
      "image link":
          "https://static.designboom.com/wp-content/uploads/2013/09/sanjay-puri-architects-bombay-arts-society-designboom-01.jpg",
      "location_link":
          "https://www.google.com/maps/place/The+Bombay+Art+Society/@19.0516084,72.83251419999999,14z/data=!4m8!1m2!2m1!1sThe+Bombay+Art+Society!3m4!1s0x3be7c9394ebbf42b:0x476047fd77e4409e!8m2!3d19.0516084!4d72.83251419999999",
      "latitude": 19.0516514,
      "longitude": 72.8324414
    },
    {
      "Name": "Kanheri Caves",
      "name": "Kanheri Caves",
      "image link":
          "https://www.fabhotels.com/blog/wp-content/uploads/2022/02/Kanheri-Caves_603505061-600X400.jpg",
      "location_link":
          "https://www.google.com/maps/place/Kanheri+Caves/@19.205850899999998,72.9068504,14z/data=!4m8!1m2!2m1!1sKanheri+Caves!3m4!1s0x3be7b9e6e177d16d:0xf5677ab36922b95f!8m2!3d19.205850899999998!4d72.9068504",
      "latitude": 19.2058509,
      "longitude": 72.9068504
    },
    {
      "Name": "Nehru Centre",
      "name": "Nehru Centre",
      "image link":
          "https://media-cdn.tripadvisor.com/media/photo-o/0f/e0/57/c8/inside.jpg",
      "location_link":
          "https://www.google.com/maps/place/Nehru+Centre/@19.0000337,72.81674749999999,14z/data=!4m8!1m2!2m1!1sNehru+Centre!3m4!1s0x3be7ce87923542fb:0x47283ba7db229598!8m2!3d19.0000337!4d72.81674749999999",
      "latitude": 19.0000337090553,
      "longitude": 72.8167474593817
    },
    {
      "Name": "Flora Fountain",
      "name": "Flora Fountain",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/d/dd/Mumbai_03-2016_72_Flora_Fountain.jpg",
      "location_link":
          "https://www.google.com/maps/place/Flora+Fountain/@18.932480599999998,72.8315166,14z/data=!4m8!1m2!2m1!1sFlora+Fountain!3m4!1s0x3be7d1dcddd8200d:0x918ba93685508c8a!8m2!3d18.932480599999998!4d72.8315166",
      "latitude": 18.9317787,
      "longitude": 72.8310092
    },
    {
      "Name": "Bombay Stock Exchange (BSE)",
      "name": "Bombay Stock Exchange",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/BSE_building_at_Dalal_Street.JPG/220px-BSE_building_at_Dalal_Street.JPG",
      "location_link":
          "https://www.google.com/maps/place/Bombay+Stock+Exchange/@18.9299891,72.83340799999999,14z/data=!4m8!1m2!2m1!1sBombay+Stock+Exchange!3m4!1s0x3be7d1c363d83329:0xc3516cb22743963b!8m2!3d18.9299891!4d72.83340799999999",
      "latitude": 18.92998907057151,
      "longitude": 72.83340802451185
    },
    {
      "Name": "St. Michael_s Church, Mahim",
      "name": "St. Michael's Church, Mahim",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/3/30/St._Michael%27s_Church%2C_Mahim_4.jpg",
      "location_link":
          "https://www.google.com/maps/place/St.+Michael%27s+Church%2C+Mahim/@19.042752699999998,72.84057539999999,14z/data=!4m8!1m2!2m1!1sSt.+Michael%27s+Church%2C+Mahim!3m4!1s0x3be7c92e17100001:0x8ba96c0925b39f32!8m2!3d19.042752699999998!4d72.84057539999999",
      "latitude": 19.0426632,
      "longitude": 72.84026109999999
    },
    {
      "Name": "Chhatrapati Shivaji Maharaj Vastu Sangrahalaya",
      "name": "Chhatrapati Shivaji Maharaj Vastu Sangrahalaya",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/7/79/Chhatrapati_Shivaji_Maharaj_Vastu_Sangrahalaya.jpg",
      "location_link":
          "https://www.google.com/maps/place/Chhatrapati+Shivaji+Maharaj+Vastu+Sangrahalaya/@18.9269015,72.83269159999999,14z/data=!4m8!1m2!2m1!1sChhatrapati+Shivaji+Maharaj+Vastu+Sangrahalaya!3m4!1s0x3be7d1c3eaf8b127:0x44e72610553e9253!8m2!3d18.9269015!4d72.83269159999999",
      "latitude": 18.92690153803966,
      "longitude": 72.83269156237266
    },
    {
      "Name": "Walkeshwar Temple, Walkeshwar",
      "name": "Shri Walkeshwar Temple",
      "image link":
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/99/65/95/tempio.jpg?w=300&h=300&s=1",
      "location_link":
          "https://www.google.com/maps/place/Shri+Walkeshwar+Temple/@18.9456144,72.7931926,14z/data=!4m8!1m2!2m1!1sShri+Walkeshwar+Temple!3m4!1s0x3be7cdf9899a8b5b:0xcbbe7589ec985cdc!8m2!3d18.9456144!4d72.7931926",
      "latitude": 18.94561435385116,
      "longitude": 72.79319256248309
    },
    {
      "Name": "nirlon knowledge park",
      "name": "Nirlon Knowledge Park",
      "image link":
          "https://www.vagroup.com/wp-content/uploads/2019/11/9-7.jpg",
      "location_link":
          "https://www.google.com/maps/place/Nirlon+Knowledge+Park/@19.1551241,72.85344309999999,14z/data=!4m8!1m2!2m1!1sNirlon+Knowledge+Park!3m4!1s0x3be7b7b4fd8496ff:0x21a9ae17e6912c28!8m2!3d19.1551241!4d72.85344309999999",
      "latitude": 19.1551162,
      "longitude": 72.85403889999999
    },
    {
      "Name": "royal opera house mumbai",
      "name": "The Royal Opera House, Mumbai",
      "image link":
          "https://lh3.googleusercontent.com/ci/AL18g_QMivu7B_5LITfSsvKPCdHo3Q5Ic76AUGqEC3T4CbNOvuskQBdcWGN7oAn89_pxpmpV8gZM7xQ=s1200",
      "location_link":
          "https://www.google.com/maps/place/The+Royal+Opera+House%2C+Mumbai/@18.9560617,72.8156158,14z/data=!4m8!1m2!2m1!1sThe+Royal+Opera+House%2C+Mumbai!3m4!1s0x3be7ce0e2fe0e8d9:0xd7ee4c0edc05f692!8m2!3d18.9560617!4d72.8156158",
      "latitude": 18.9559115,
      "longitude": 72.8156683
    },
    {
      "Name": "ISKCON Temple, Juhu",
      "name": "ISKCON Mandir - Juhu",
      "image link":
          "https://content.jdmagicbox.com/comp/mumbai/05/022p7702605/catalogue/hare-rama-hare-krishna-temple-juhu-mumbai-temples-wh2p13dhyj.jpg",
      "location_link":
          "https://www.google.com/maps/place/ISKCON+Mandir+-+Juhu/@19.113016,72.826576,14z/data=!4m8!1m2!2m1!1sISKCON+Mandir+-+Juhu!3m4!1s0x3be7c9e83c34362f:0x6d7c69d4f830e48!8m2!3d19.113016!4d72.826576",
      "latitude": 19.1130655,
      "longitude": 72.826138
    },
    {
      "Name": "Taj Lands End",
      "name": "Taj Lands End, Mumbai",
      "image link":
          "https://www.tajhotels.com/content/dam/luxury/tle/16x7/Exterior-16x7.jpg/jcr:content/renditions/cq5dam.web.1280.1280.jpeg",
      "location_link":
          "https://www.google.com/maps/place/Taj+Lands+End%2C+Mumbai/@19.0439124,72.81926829999999,14z/data=!4m8!1m2!2m1!1sTaj+Lands+End%2C+Mumbai!3m4!1s0x3be7c945f2fb1149:0xa2ba742a39963b31!8m2!3d19.0439124!4d72.81926829999999",
      "latitude": 19.0439539,
      "longitude": 72.8190844
    },
    {
      "Name": "Jama_Masjid",
      "name": "Jama Masjid Building",
      "image link":
          "https://www.trawell.in/admin/images/upload/465224718Mumbai_Jama_Masjid_Main.jpg",
      "location_link":
          "https://www.google.com/maps/place/Jama+Masjid+Building/@18.948971999999998,72.8342347,14z/data=!4m8!1m2!2m1!1sJama+Masjid+Building!3m4!1s0x3be7ce240232bd3b:0xfd1316fb133fcaff!8m2!3d18.948971999999998!4d72.8342347",
      "latitude": 18.94897199381795,
      "longitude": 72.8342347436544
    },
    {
      "Name": "Eliphistone college",
      "name": "Elphinstone College",
      "image link":
          "https://content.jdmagicbox.com/comp/mumbai/90/022p33090/catalogue/elphinstone-college-of-arts-science-and-commerce-fort-mumbai-colleges-358ee.jpg",
      "location_link":
          "https://www.google.com/maps/place/Elphinstone+College/@18.9271362,72.8310487,14z/data=!4m8!1m2!2m1!1sElphinstone+College!3m4!1s0x3be7ce1e3a9a13c5:0xa5a1ee827799317d!8m2!3d18.9271362!4d72.8310487",
      "latitude": 18.9271362156172,
      "longitude": 72.83104865904873
    },
    {
      "Name": "Marine Drive",
      "name": "Marine Dr",
      "image link":
          "https://www.tripsavvy.com/thmb/soWUDapWGtmRQbvvY5OFMdd8Ezs=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-1008831236-5c65d6bf4cedfd00014aa310.jpg",
      "location_link":
          "https://www.google.com/maps/place/Marine+Dr/@18.9432111,72.8229983,14z/data=!4m8!1m2!2m1!1sMarine+Dr!3m4!1s0x3be7d1e25ee8439d:0x5acd924f2726ad2b!8m2!3d18.9432111!4d72.8229983",
      "latitude": 18.95521390723142,
      "longitude": 72.8133199626709
    },
    {
      "Name": "Tata Institute of Social Sciences (TISS) - Deonar",
      "name": "Tata Institute of Social Sciences",
      "image link":
          "https://iirfpedia.com/admin/upload/upload__1620888992556.webp",
      "location_link":
          "https://www.google.com/maps/place/Tata+Institute+of+Social+Sciences/@19.0446964,72.91248399999999,14z/data=!4m8!1m2!2m1!1sTata+Institute+of+Social+Sciences!3m4!1s0x3be7c608f591996b:0x69dbb7e2f00ee03c!8m2!3d19.0446964!4d72.91248399999999",
      "latitude": 19.04469637987044,
      "longitude": 72.91248396969604
    },
    {
      "Name": "Sardar Patel Institute of Technology (SPIT) - Andheri West",
      "name":
          "Bharatiya Vidya Bhavan's Sardar Patel Institute of Technology (SPIT)",
      "image link": "https://img.collegepravesh.com/2018/11/SPIT-Mumbai.jpg",
      "location_link":
          "https://www.google.com/maps/place/Bharatiya+Vidya+Bhavan%27s+Sardar+Patel+Institute+of+Technology+%28SPIT%29/@19.123177599999998,72.8361154,14z/data=!4m8!1m2!2m1!1sBharatiya+Vidya+Bhavan%27s+Sardar+Patel+Institute+of+Technology+%28SPIT%29!3m4!1s0x3be7c9d90e067ba9:0x16268e5d6bca2e6a!8m2!3d19.123177599999998!4d72.8361154",
      "latitude": 19.1241432,
      "longitude": 72.83651739999999
    },
    {
      "Name": "Jai Hind College - Churchgate",
      "name": "Jai Hind College",
      "image link":
          "https://static.toiimg.com/thumb/msid-71860546,width-1070,height-580,imgsize-780390,resizemode-75,overlay-toi_sw,pt-32,y_pad-40/photo.jpg",
      "location_link":
          "https://www.google.com/maps/place/Jai+Hind+College/@18.9345107,72.8252105,14z/data=!4m8!1m2!2m1!1sJai+Hind+College!3m4!1s0x3be7d1e71c2b104b:0x2b32a4be81621938!8m2!3d18.9345107!4d72.8252105",
      "latitude": 18.93454437222468,
      "longitude": 72.82520532225664
    },
    {
      "Name": "SIES Graduate School of Technology - Nerul",
      "name": "SIES Graduate School of Technology",
      "image link":
          "https://images.collegedunia.com/public/college_data/images/appImage/14825_Untitled.jpg",
      "location_link":
          "https://www.google.com/maps/place/SIES+Graduate+School+of+Technology/@19.042813,73.023078,14z/data=!4m8!1m2!2m1!1sSIES+Graduate+School+of+Technology!3m4!1s0x3be7c3db5e2c85cd:0xef26c52d7d73816e!8m2!3d19.042813!4d73.023078",
      "latitude": 19.04281300683094,
      "longitude": 73.02307795942907
    },
    {
      "Name": "Banganga Tank",
      "name": "Banganga Tank",
      "image link":
          "https://static.theprint.in/wp-content/uploads/2023/12/Banganga-Tank.jpg",
      "location_link":
          "https://www.google.com/maps/place/Banganga+Tank/@18.9454723,72.79364319999999,14z/data=!4m8!1m2!2m1!1sBanganga+Tank!3m4!1s0x3be7cdfa1913c867:0x3fe8af82ef72a0d0!8m2!3d18.9454723!4d72.79364319999999",
      "latitude": 18.94547227966174,
      "longitude": 72.79364323029921
    },
    {
      "Name": "Regal Cinema",
      "name": "Regal Cinema",
      "image link":
          "https://images.mid-day.com/images/images/2022/dec/Regal-theatre_d.jpg",
      "location_link":
          "https://www.google.com/maps/place/Regal+Cinema/@18.924725799999997,72.8323707,14z/data=!4m8!1m2!2m1!1sRegal+Cinema!3m4!1s0x3be7d1c142fcac63:0x8efdea86372f2a0!8m2!3d18.924725799999997!4d72.8323707",
      "latitude": 18.92472579591331,
      "longitude": 72.8323706998866
    },
    {
      "Name": "Narsee Monjee Institute of Management Studies - VIle Parle",
      "name": "NMIMS Deemed-to-be-University",
      "image link": "https://www.nmims.edu/images/home-slide/m-school-1.jpg",
      "location_link":
          "https://www.google.com/maps/place/NMIMS+Deemed-to-be-University/@19.103303699999998,72.83659879999999,14z/data=!4m8!1m2!2m1!1sNMIMS+Deemed-to-be-University!3m4!1s0x3be7c9b8676487ef:0x2c4fac1c801d5128!8m2!3d19.103303699999998!4d72.83659879999999",
      "latitude": 19.1033026,
      "longitude": 72.836783
    },
    {
      "Name": "Renaissance Mumbai Convention Centre Hotel",
      "name": "Renaissance Mumbai Hotel & Convention Centre",
      "image link":
          "https://static.toiimg.com/photo/msid-29953464,width-96,height-65.cms",
      "location_link":
          "https://www.google.com/maps/place/Renaissance+Mumbai+Hotel+%26+Convention+Centre/@19.134566799999998,72.9012065,14z/data=!4m8!1m2!2m1!1sRenaissance+Mumbai+Hotel+%26+Convention+Centre!3m4!1s0x3be7b8006416f777:0x57ce9a10d943b8a9!8m2!3d19.134566799999998!4d72.9012065",
      "latitude": 19.13456677112321,
      "longitude": 72.90120649192036
    },
    {
      "Name": "Gateway of India",
      "name": "Gateway Of India Mumbai",
      "image link":
          "https://img.veenaworld.com/wp-content/uploads/2021/03/Gateway-of-India-Mumbai-History-and-Heritage.jpeg",
      "location_link":
          "https://www.google.com/maps/place/Gateway+Of+India+Mumbai/@18.9219841,72.8346543,14z/data=!4m8!1m2!2m1!1sGateway+Of+India+Mumbai!3m4!1s0x3be7d1c73a0d5cad:0xc70a25a7209c733c!8m2!3d18.9219841!4d72.8346543",
      "latitude": 18.92198407012483,
      "longitude": 72.83465432283158
    },
    {
      "Name": "David Sassoon Library and Reading Room",
      "name": "David Sassoon Library and Reading Room",
      "image link":
          "https://kalaghodaassociation.com/wp-content/uploads/2023/07/IMG_3416.jpg",
      "location_link":
          "https://www.google.com/maps/place/David+Sassoon+Library+and+Reading+Room/@18.9277144,72.83109139999999,14z/data=!4m8!1m2!2m1!1sDavid+Sassoon+Library+and+Reading+Room!3m4!1s0x3be7d1d998b45a1f:0xb5407002be39b5a1!8m2!3d18.9277144!4d72.83109139999999",
      "latitude": 18.9277443,
      "longitude": 72.83130729999999
    },
    {
      "Name": "Mahalaxmi Racecourse",
      "name": "Mahalakshmi Race Course",
      "image link":
          "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202401/mahalaxmi-racecourse-315007451-16x9_0.jpg?VersionId=InT2Bz_oAwqZcF09PoCoB54u_68ecMac&size=690:388",
      "location_link":
          "https://www.google.com/maps/place/Mahalakshmi+Race+Course/@18.9842089,72.8200753,14z/data=!4m8!1m2!2m1!1sMahalakshmi+Race+Course!3m4!1s0x3be7ce63d14b3d83:0xb6ce08c6304dcc32!8m2!3d18.9842089!4d72.8200753",
      "latitude": 18.98425090612726,
      "longitude": 72.8202795836015
    },
    {
      "Name": "Worli Sea Face",
      "name": "Worli Sea Face",
      "image link":
          "https://live.staticflickr.com/5803/22367486062_fac15750c4_h.jpg",
      "location_link":
          "https://www.google.com/maps/place/Worli+Sea+Face/@19.0091432,72.8157283,14z/data=!4m8!1m2!2m1!1sWorli+Sea+Face!3m4!1s0x3be7ce981ee36cbf:0xecfef9dd3e1afd0d!8m2!3d19.0091432!4d72.8157283",
      "latitude": 19.00914321047865,
      "longitude": 72.81572827663061
    },
    {
      "Name": "Mani Bhavan Gandhi Museum",
      "name": "Mani Bhavan Gandhi Sangrahalaya",
      "image link":
          "https://gandhi-manibhavan.org/assets/images/about-us/ManiBHavan.jpg",
      "location_link":
          "https://www.google.com/maps/place/Mani+Bhavan+Gandhi+Sangrahalaya/@18.9598019,72.8116101,14z/data=!4m8!1m2!2m1!1sMani+Bhavan+Gandhi+Sangrahalaya!3m4!1s0x3be7ce0c69115555:0xc0b175f791f839fd!8m2!3d18.9598019!4d72.8116101",
      "latitude": 18.9596743,
      "longitude": 72.8115135
    },
    {
      "Name": "Victoria Terminus (Chhatrapati Shivaji Maharaj Terminus)",
      "name": "victoria terminus",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/4/4d/Chhatrapati_shivaji_terminus%2C_esterno_01.jpg",
      "location_link":
          "https://www.google.com/maps/place/victoria+terminus/@18.9398178,72.8354622,14z/data=!4m8!1m2!2m1!1svictoria+terminus!3m4!1s0x3be7d1e16d1afc3f:0x2dd85eeb1639696!8m2!3d18.9398178!4d72.8354622",
      "latitude": 18.93981783565711,
      "longitude": 72.83546219553033
    },
    {
      "Name": "Hanging Gardens",
      "name": "Hanging Gardens",
      "image link":
          "https://www.mumbairesort.in/blog/wp-content/uploads/2020/09/hanging-garden-mumbai.jpg",
      "location_link":
          "https://www.google.com/maps/place/Hanging+Gardens/@18.9565598,72.80498659999999,14z/data=!4m8!1m2!2m1!1sHanging+Gardens!3m4!1s0x3be7ce09e53e749f:0x94a70633cf948b9a!8m2!3d18.9565598!4d72.80498659999999",
      "latitude": 18.95655978116919,
      "longitude": 72.80498656834999
    },
    {
      "Name": "University of Mumbai - Kalina, Santacruz",
      "name": "University of Mumbai",
      "image link":
          "https://content.jdmagicbox.com/comp/mumbai/33/022p900433/catalogue/mumbai-university-santacruz-east-mumbai-universities-2792uif.jpg",
      "location_link":
          "https://www.google.com/maps/place/University+of+Mumbai/@19.0727327,72.8608677,14z/data=!4m8!1m2!2m1!1sUniversity+of+Mumbai!3m4!1s0x3be7c96c440c0d51:0x89f533b9650af7cb!8m2!3d19.0727327!4d72.8608677",
      "latitude": 19.07302080827397,
      "longitude": 72.8582874349103
    },
    {
      "Name": "Worli Fort",
      "name": "Worli Fort",
      "image link":
          "https://upload.wikimedia.org/wikipedia/commons/e/ea/Worli_Fort_Mumbai.jpg",
      "location_link":
          "https://www.google.com/maps/place/Worli+Fort/@19.0237125,72.8168,14z/data=!4m8!1m2!2m1!1sWorli+Fort!3m4!1s0x3be7ceb03b280171:0x526dd9446adfb620!8m2!3d19.0237125!4d72.8168",
      "latitude": 19.02371251842744,
      "longitude": 72.8168000232744
    },
    {
      "Name": "Jamnalal_Bajaj_Institute_of_Management_Studies_(JBIMS)",
      "name": "Jamnalal Bajaj Institute of Management Studies (JBIMS)",
      "image link": "https://www.jbims.edu/uploads/homebanner/jbims_img-1.jpg",
      "location_link":
          "https://www.google.com/maps/place/Jamnalal+Bajaj+Institute+of+Management+Studies+%28JBIMS%29/@18.9284884,72.827437,14z/data=!4m8!1m2!2m1!1sJamnalal+Bajaj+Institute+of+Management+Studies+%28JBIMS%29!3m4!1s0x3be7d1e82db619f3:0x40906a78994f422a!8m2!3d18.9284884!4d72.827437",
      "latitude": 18.9285763,
      "longitude": 72.8274544
    },
    {
      "Name": "Global Vipassana Pagoda, Gorai",
      "name": "Global Vipassana Pagoda",
      "image link":
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/19/88/12/global-vipassana-pagoda.jpg?w=1200&h=1200&s=1",
      "location_link":
          "https://www.google.com/maps/place/Global+Vipassana+Pagoda/@19.228203399999998,72.8058891,14z/data=!4m8!1m2!2m1!1sGlobal+Vipassana+Pagoda!3m4!1s0x3be7b158222067c7:0x4ce86be376e098ba!8m2!3d19.228203399999998!4d72.8058891",
      "latitude": 19.22823636390566,
      "longitude": 72.80590165515554
    },
    {
      "Name":
          "S.P. Jain Institute of Management and Research (SPJIMR) - Andheri West",
      "name": "S. P. Jain Institute of Management & Research",
      "image link":
          "https://images.shiksha.com/mediadata/images/articles/1689154195php8x3fHJ_480x360.jpeg",
      "location_link":
          "https://www.google.com/maps/place/S.+P.+Jain+Institute+of+Management+%26+Research/@19.1240207,72.8369064,14z/data=!4m8!1m2!2m1!1sS.+P.+Jain+Institute+of+Management+%26+Research!3m4!1s0x3be7c9d9a8279baf:0xb21f38cb0efce957!8m2!3d19.1240207!4d72.8369064",
      "latitude": 19.1240489,
      "longitude": 72.8374668
    },
    {
      "Name": "Mumba Devi Temple",
      "name": "Shree Mumbadevi Temple",
      "image link":
          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/d2/87/e3/temple-tower.jpg?w=1200&h=-1&s=1",
      "location_link":
          "https://www.google.com/maps/place/Shree+Mumbadevi+Temple/@18.951940099999998,72.83074359999999,14z/data=!4m8!1m2!2m1!1sShree+Mumbadevi+Temple!3m4!1s0x3be7cfecc763321b:0x9853129a582225b2!8m2!3d18.951940099999998!4d72.83074359999999",
      "latitude": 18.9520633,
      "longitude": 72.8307353
    },
    {
      "Name": "Lokmanya Tilak Terminus",
      "name": "Lokmanya Tilak",
      "image link": "https://i.ytimg.com/vi/0I8bEhBp03E/maxresdefault.jpg",
      "location_link":
          "https://www.google.com/maps/place/Lokmanya+Tilak/@19.0696829,72.8919715,14z/data=!4m8!1m2!2m1!1sLokmanya+Tilak!3m4!1s0x3be7c89be8e89fdb:0x66694e36862ff3a1!8m2!3d19.0696829!4d72.8919715",
      "latitude": 19.06949237335124,
      "longitude": 72.89201931084109
    },
    {
      "Name": "K. J. Somaiya College of Engineering - Vidyavihar",
      "name": "K. J. Somaiya College of Engineering",
      "image link":
          "https://media.licdn.com/dms/image/C4D1BAQFIFrwjA7JpJw/company-background_10000/0/1600677977408/kj_somaiya_college_of_engineering_vidyavihar_cover?e=2147483647&v=beta&t=qbUQKVvgT77OKlEhtv2YK7GJPFZ4kiHlZ7hwyk_NmhY",
      "location_link":
          "https://www.google.com/maps/place/K.+J.+Somaiya+College+of+Engineering/@19.072847,72.8999262,14z/data=!4m8!1m2!2m1!1sK.+J.+Somaiya+College+of+Engineering!3m4!1s0x3be7c627a20bcaa9:0xb2fd3bcfeac0052a!8m2!3d19.072847!4d72.8999262",
      "latitude": 19.0729027,
      "longitude": 72.9002941
    },
    {
      "Name": "Peninsula Corporate Park",
      "name": "Peninsula Corporate Park",
      "image link":
          "https://jll-global-gdim-res.cloudinary.com/image/upload/f_auto,dpr_auto,w_1920,q_70/v1505555974/IN_ML20170916/Peninsula-Corporate-Park---Peninsula-Tower_7526_20170916_004.jpg",
      "location_link":
          "https://www.google.com/maps/place/Peninsula+Corporate+Park/@18.9987679,72.82569459999999,14z/data=!4m8!1m2!2m1!1sPeninsula+Corporate+Park!3m4!1s0x3be7ce8d4770d38f:0x5214c40cb2670327!8m2!3d18.9987679!4d72.82569459999999",
      "latitude": 18.99876787641658,
      "longitude": 72.82569460891904
    },
    {
      "Name": "Bombay High Court",
      "name": "HIGH COURT OF BOMBAY",
      "image link":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxa007jlP9-H2aG9qR9cCpU_F01EYnvNirHLibkOYd7A&s",
      "location_link":
          "https://www.google.com/maps/place/HIGH+COURT+OF+BOMBAY/@18.930987899999998,72.8303287,14z/data=!4m8!1m2!2m1!1sHIGH+COURT+OF+BOMBAY!3m4!1s0x3be7d14d7d8bb7f9:0x2ef2ec6fb96c1186!8m2!3d18.930987899999998!4d72.8303287",
      "latitude": 18.93098793384232,
      "longitude": 72.83032867389332
    },
    {
      "Name": "St. Thomas Cathedral",
      "name": "St. Thomas’ Cathedral, Mumbai",
      "image link":
          "https://www.snkindia.com/images/projects/main/st_thomas_arc_a-png(1).jpg",
      "location_link":
          "https://www.google.com/maps/place/St.+Thomas%E2%80%99+Cathedral%2C+Mumbai/@18.9319003,72.8336849,14z/data=!4m8!1m2!2m1!1sSt.+Thomas%E2%80%99+Cathedral%2C+Mumbai!3m4!1s0x3be7d1dca9fe9353:0xb735e75014a52ce9!8m2!3d18.9319003!4d72.8336849",
      "latitude": 18.93190418135672,
      "longitude": 72.83339152616237
    }
  ];

  RecommendationModel model = RecommendationModel();

  getRecommendation() async {
    var db = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    var data = await db.collection("userhistory").doc(user.uid).get();
    Map<String, dynamic>? history;
    List<String> historyNames = [];
    if (data.exists) {
      history = data.data();
      for (var item in history!['visited']) {
        historyNames.add(item['landmarkName']);
      }
    }
    var recommendation = await doApiCall(historyNames);
    return recommendation;
  }

  doApiCall(List<String> historyNames) async {
    print(historyNames);
    var data = await HttpCalls.apiHelper(
        body: {"user_history": historyNames},
        endpoint: 'recommendations/',
        isJson: true);
    print(data);
    return data;
  }

  // A function to upload a file, either from the camera or the gallery.
  Future<void> uploadFile({required bool isCamera}) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;

    // Check if the source is camera or gallery
    pickedFile = isCamera
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);
    Utils.loader();
    // If a file was picked, then proceed to upload
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      // We create a MultipartFile without making it observable since the file itself does not change.
      file = await dio.MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      );

      // Set the upload flag to true to indicate a file is selected
      isUploaded.value = true;
      Map<String, dynamic> r = await HttpCalls.apiHelper(body: {
        "file": file!,
      }, endpoint: "classify/");
      ResultModel model = ResultModel.fromJson(r);
      if (model.landmarkName == 'Sorry, unable to identify landmark') {
        Get.snackbar(
          'Sorry, unable to identify landmark',
          model.landmarkName.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      } else {
        var db = FirebaseFirestore.instance;
        var user = FirebaseAuth.instance.currentUser;
        var data = await db.collection("userhistory").doc(user?.uid).get();
        if (data.exists) {
          var visited = data.get("visited") as List;
          visited.add({
            "landmarkName": model.landmarkName.toString(),
            "landmarkImage": "",
            "landmarkDescription": model.landmarkInformation.toString(),
            "landmarkLocation": "",
            "timestamp": DateTime.now().toIso8601String(),
          });
          db.collection("userhistory").doc(user?.uid).set({
            "visited": visited,
          });
        } else {
          db.collection("userhistory").doc(user?.uid).set({
            "visited": [
              {
                "landmarkName": model.landmarkName.toString(),
                "landmarkImage": landmarkInfo.firstWhere((element) =>
                    element['Name'] == model.landmarkName)['image link'],
                "landmarkDescription": model.landmarkInformation.toString(),
                "landmarkLocation": landmarkInfo.firstWhere((element) =>
                    element['Name'] == model.landmarkName)['location_link'],
                "timestamp": DateTime.now().toIso8601String(),
              }
            ],
          });
        }
      }
      print(r);
      Get.back();
      if (r.containsKey("message")) {
        print(r['message']);
        Get.snackbar(
          'Sorry, unable to identify landmark',
          r['message'],
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      } else {
        r.addAll({'image': imageFile});
        // GetStorage box = GetStorage();
        // if (box.hasData("history")) {
        //   List data = box.read("history") as List;
        //   data.insert(0, r);
        //   box.write("history", data);
        // } else {
        //   List data = [];
        //   data.insert(0, r);
        //   box.write("history", data);
        // }
        Get.toNamed(AppRoutes.resultScreen,
            arguments: {"model": model, "image": imageFile});
      }

      // Here you would typically make a network request to upload the file
      // using the 'dio' package or any other network client you prefer.
    }
  }

  var loading = false.obs;
  @override
  void onInit() async {
    loading.value = true;
    var data = await getRecommendation();
    model = RecommendationModel.fromJson(data);
    loading.value = false;
    super.onInit();
  }
}
