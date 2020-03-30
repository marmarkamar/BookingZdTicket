define(['jquery', 'jquery_ui','jquery_unobtrusive_ajax'], function () {
    var id;
    for (var i = 0; i < count; i++) {
        id = "text\\ " + i;
        $("#" + id).find("button").click(function (e) {
            var i = e.target.id;
            id = i;
            if ($("#" + id).css("border-color") == "rgb(44, 106, 140)") {
                Style_Color = "darkred";
            } else {
                Style_Color = "#2c6a8c";
            }

            $("#" + id).css("border-color", Style_Color);

            if (Style_Color == "darkred") {
                $("#BookingTicket").css("display", "block");

                $.ajax
                ({
                    type: "POST",
                    url: '/HomePage/BookingSeats',
                    data: {
                        "id": id
                    },
                    success: function (html) {
                        $("#Ticket").append(html);
                    }
                });
            } else {
                $("#T" + id).remove();
                if ( $("#Ticket").has("tr").length <=0) {
                    $("#BookingTicket").css("display", "none");
                }
            }
        });
    }
});