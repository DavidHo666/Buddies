/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/map.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/map.js":
/*!*************************************!*\
  !*** ./app/javascript/packs/map.js ***!
  \*************************************/
/*! no static exports found */
/***/ (function(module, exports) {

function initMap() {
  var div = document.getElementById("map");
  var location = {
    lat: parseFloat(div.getAttribute("data-center-lat")),
    lng: parseFloat(div.getAttribute("data-center-lng"))
  };
  var map = new google.maps.Map(div, {
    zoom: 12,
    center: location
  });
  var events = document.querySelectorAll("li.event-result-item");
  events = Array.from(events);
  var eventInfo = events.map(function (event) {
    return {
      coords: {
        lat: parseFloat(event.getAttribute("data-latitude")),
        lng: parseFloat(event.getAttribute("data-longitude"))
      },
      title: event.children[0].innerText,
      address: event.getAttribute("data-address")
    };
  });
  var infoWindow = new google.maps.InfoWindow();
  var labelDict = {};
  eventInfo.forEach(function (event) {
    var name = event.coords['lat'] + "," + event.coords['lng'];
    if (labelDict.hasOwnProperty(name)) {
      labelDict[name] += 1;
    } else {
      labelDict[name] = 1;
    }
  });
  eventInfo.forEach(function (event, i) {
    var name = event.coords['lat'] + "," + event.coords['lng'];
    var marker = new google.maps.Marker({
      position: event.coords,
      map: map,
      label: labelDict[name].toString(),
      title: "".concat(event.title, " \n ").concat(event.address.split("-").join(" "))
    });
    marker.addListener("click", function () {
      infoWindow.close();
      infoWindow.setContent(marker.getTitle());
      infoWindow.open(marker.getMap(), marker);
    });
  });
  console.log(eventInfo);
  console.log(location);
  console.log(div);
}
window.initMap = initMap;

/***/ })

/******/ });
//# sourceMappingURL=map-e6e41129864ee38b77b8.js.map