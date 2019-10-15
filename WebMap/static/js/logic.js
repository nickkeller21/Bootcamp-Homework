
var map = L.map("map", {
    center: [30, -130],
    zoom: 3
});

L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
    attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
    maxZoom: 18,
    id: "mapbox.light",
    accessToken: API_KEY
}).addTo(map);


var link = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson";


d3.json(link, function (data) {

    function style(feature) {
        return {
            opacity: 1,
            fillOpacity: 1,
            fillColor: Color(feature.properties.mag),
            color: "#000000",
            radius: feature.properties.mag,
            weight: 0.5
        };
    }

 
    function Color(magnitude) {
        switch (true) {
            case magnitude > 5:
                return "#FF0000";
            case magnitude > 4:
                return "#FFFF00";
            case magnitude > 3:
                return "#FFA500";
            case magnitude > 2:
                return "#7FFF00";
            default:
                return "#00FF00";
        }
    }



    var geojson = L.geoJson(data, {

       
        pointToLayer: function (feature, latlng) {
            return L.circleMarker(latlng);
        },
       
        style: style,
          
        onEachFeature: function(feature, layer) {
        layer.bindPopup("Magnitude: " + feature.properties.mag + "<br>Location: " + feature.properties.place+ "<br>Minutes Ago: " + Math.round(feature.properties.time*1.66667e-5));
      }

    }).addTo(map);


  var legend = L.control({
    position: "bottomright"
  });

   legend.onAdd = function() {
    var div = L.DomUtil.create("div", "info legend");
    var mag = [0, 2, 3, 4, 5];
    var colors = [
      "#00FF00",
      "#7FFF00",
      "#FFA500",
      "#FFFF00",
      "#FF0000"
    ];
    var patch = [];
    var labels = [];
    
    mag.forEach(function(limit, index) {
        labels.push("<p>"+mag[index]+"-"+mag[index+1]+"</p>");
      });
 

    colors.forEach(function(limit, index) {
      patch.push("<div style=\"background-color: " + colors[index] + "; height: 20px; width: 20px\">"+labels[index]+"</div>");
    });

    div.innerHTML += "<ul>" + patch.join("")+ "</ul>";
    return div;
  };

    legend.addTo(map);
});