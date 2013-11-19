// Once the api loads call enable the search box.
function handleAPILoaded() {
    $('#search-button').attr('disabled', false);
}

// Search for a given string.
function search(val, container) {
    var q = val;
    console.log(gapi);
    var request = gapi.client.youtube.search.list({
        q: q,
        part: 'snippet'
    });

    request.execute(function (response) {
        console.log(response.results[0]);
        var str = JSON.stringify(response.result);
        $('#' + container).html('<pre>' + str + '</pre>');
    });
}