// Creating map object
var map = L.map("map", {
    center: [30, -130],
    zoom: 3
});

// Adding tile layer
L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
    attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
    maxZoom: 18,
    id: "mapbox.light",
    accessToken: API_KEY
}).addTo(map);

// If data.beta.nyc is down comment out this link
var link = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson";

// Uncomment this link local geojson for when data.beta.nyc is down
// var link = "static/data/nyc.geojson";

// Grabbing our GeoJSON data..
d3.json(link, function (data) {
    // Creating a GeoJSON layer with the retrieved data
    // L.geoJson(data).addTo(map);

    // This function returns the style data for each of the earthquakes we plot on
    // the map. We pass the magnitude of the earthquake into two separate functions
    // to calculate the color and radius.
    function style(feature) {
        return {
            opacity: 1,
            fillOpacity: 1,
            fillColor: getColor(feature.properties.mag),
            color: "#000000",
            radius: feature.properties.mag,
            weight: 0.5
        };
    }

    // This function determines the color of the marker based on the magnitude of the earthquake.
    function getColor(magnitude) {
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

        // We turn each feature into a circleMarker on the map.
        pointToLayer: function (feature, latlng) {
            return L.circleMarker(latlng);
        },
        // We set the style for each circleMarker using our styleInfo function.
        style: style,
            // We create a popup for each marker to display the magnitude and location of the earthquake after the marker has been created and styled
        onEachFeature: function(feature, layer) {
        layer.bindPopup("Magnitude: " + feature.properties.mag + "<br>Location: " + feature.properties.place+ "<br>Minutes Ago: " + Math.round(feature.properties.time*1.66667e-5));
      }

    }).addTo(map);

  // Here we create a legend control object.
  var legend = L.control({
    position: "bottomright"
  });
   // Then add all the details for the legend
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
    // Add legend to the map.
    legend.addTo(map);
});