define(['jquery', 'jquery_ui'], function () {
    var id;
    for (var i = 0; i < count; i++) {
        id = "hider\\ " + i;
        $("#" + id).click(function (e) {
            var i = e.target.id.toString().slice(-1);
            for (var j = 0; j < count; j++) {
                id = "text\\ " + j;
                $("#" + id).css("display", "none");
            }
            id = "text\\ " + i;
            $("#" + id).css("display", "block");
        });
    }
});