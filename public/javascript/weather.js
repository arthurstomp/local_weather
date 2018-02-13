function getWeather(position) {
  $.get('/weather/'+position.coords.latitude+'/'+position.coords.longitude, function(data) {
    showWeather(data);
  });
}

function showWeather(weather) {
  $('#main').html(weather['main']);
  $('#description').html(weather['description']);
  $('#temp').html(weather['temp'] + 'ºF');
  $('#temp_min').html(weather['temp_min'] + 'ºF');
  $('#temp_max').html(weather['temp_max'] + 'ºF');
  $('#humidity').html(weather['humidity'] + '%');
}
function getLocation() {
  if (navigator.geolocation) {
    return navigator.geolocation.getCurrentPosition(getWeather);
  } else {
    geoloc.innerHTML = "Geolocation is not supported by this browser.";
  }
}
$(document).ready(function(){
  getLocation();
});
