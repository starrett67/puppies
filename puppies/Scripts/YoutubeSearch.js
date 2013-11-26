// Once the api loads call enable the search box.
function handleAPILoaded() {
    $('#search-button').attr('disabled', false);
}

// Search for a given string.
function search(val, container) {
    if ($('#' + container).html().indexOf("iframe") > 0 ) {
        $('#' + container).html('');
        return;
    }
    var q = val;
    console.log(gapi);
    var request = gapi.client.youtube.search.list({
        q: q,
        part: 'snippet'
    });

    request.execute(function (response) {
        console.log(response);
        console.log(response.log);
        var videoID = response.items[0].id.videoId;
        $('#' + container).html('<iframe width="230" height="200" src="//www.youtube.com/embed/' + videoID + '" frameborder="0" allowfullscreen></iframe>');
    });
}