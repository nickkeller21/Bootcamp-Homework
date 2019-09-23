// from data.js
var tableData = data;

// HTML references
var tbody = d3.select("tbody");
var button = d3.select("#filter-btn");
var dateInput = d3.select("#datetime").property("value");

// function that inserts the table
function renderTable(table){
    tbody.html("");
    table.forEach(sighting => {
        var row = tbody.append("tr");
        Object.entries(sighting).forEach(([key, value]) => {
        var cell = row.append("td");
        cell.text(value);
        });
    });
}


// handle the click
function handleClick(){
    var filteredData = tableData;
    filteredData = filteredData.filter(s => s.datetime === dateInput);
    
    renderTable(filteredData);
}
renderTable(tableData);
button.on("click", handleClick);


// var filterArray = []
// var filteredData = tableData;
// filterArray = filterArray.push(s => s.datetime === dateInput);
//renderTable(filteredData);
//filterArray.forEach(f => (filteredData = filteredData.filter(f)));