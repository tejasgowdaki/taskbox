window.onload = function () {

  var clientHandle = document.getElementById('project_client_id');

  clientHandle.onchange = function () {
    var clientDetailHandle = document.getElementById('clientDetail');
    var clientId = clientHandle.options[clientHandle.selectedIndex].value;
    var request = new XMLHttpRequest();
    request.open('GET', '/clients/' + clientId + '.json', true);
    request.onreadystatechange = function(){
      if ((request.status === 200) && (request.readyState === 4)) {
        var client = JSON.parse(request.responseText);
        var output = "Mobile : " + client.mobile + " - ID : " + client.id;
        clientDetailHandle.innerHTML = output;
      }
    };
    request.send();
  };
}
