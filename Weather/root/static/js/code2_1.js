/* Google Maps API */

var map;
var geocoder;

function initialize() {
  if (GBrowserIsCompatible()) {
    map = new GMap2(document.getElementById("map_canvas"));
    map.setCenter(new GLatLng(36.004673,137.351074), 5);

    geocoder = new GClientGeocoder();
  }
}

function getAddress() {
  var address = document.getElementById("address").value;
  geocoder.getLocations(address, markAddress);
}

function markAddress(obj) {
  if (obj.Status.code == G_GEO_SUCCESS){
      var names = check(obj, "");
 	  location.href='[% c.uri_for('/search', { search => names }) %]'
  }
}

function check(obj, str){
  var names = "";
  for (var name in obj){
    if (typeof obj[name] == "object"){
      names += check(obj[name], str + name + ".") + "\n";
    }else{
      names += str + name + "=" + obj[name] + "\n";
    }
  }
  return names;
}
