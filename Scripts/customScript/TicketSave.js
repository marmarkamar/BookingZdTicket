define(['jquery', 'jquery_ui','pdfmake','html2canvas'], function () {
    $('#cmd').click(function () {
        html2canvas($('#divContent'),
            {
                onrendered: function(canvas) {
                    var data = canvas.toDataURL();
                    var docDefinition = {
                        content: [
                            {
                                image: data,
                                width: 500,
                            }
                        ]
                    };
                    pdfMake.createPdf(docDefinition).download("Ticket.pdf");
                }
            })});

    $("#Send").click(function () {
        $.ajax
        ({
            type: "POST",
            url: '/HomePage/SendMail',
            data: {
                'InsertValue': $('#divContent').text(),
                'Name': Name,
                'SName': SName
            },
            success: function (html) {
                var message = ("Письмо было отправлено на почту");
                alert(message);
            },
            error: function () {
                alert("error");
            }
        });
    });
});