define(['jquery', 'jquery_ui'], function($) {
    $(document).ready(function () {
        $("#Station1").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: "HomePage/SelectStationValue",
                    data: { 'InsertValue': $("#Station1").val() },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        response(data);
                    },
                    error: function (e) {
                        alert(e.message);
                    }
                });
            },
        });
        $("#Station2").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: "HomePage/SelectStationValue",
                    data: { 'InsertValue': $("#Station2").val() },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        response(data);
                    },
                    error: function (e) {
                        alert(e.message);
                    }
                });
            },
        });
    });
});