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
        var str = JSON.stringify(response.result);
        console.log(str);
        var videoID = response.results.items[0];
        console.log(videoID);
        $('#' + container).html('<iframe width="420" height="315" src="//www.youtube.com/embed/' + videoID + '" frameborder="0" allowfullscreen></iframe>');
    });
}