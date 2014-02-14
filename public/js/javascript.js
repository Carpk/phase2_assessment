$(document).ready(function() {
    $("#js_event").submit(function(event) {
        event.preventDefault();
        var data = $(this).serialize();
        console.log(data);
        $.post("/create_event", data, function(data) {
            console.log(data)
        });
    })
});


// $("ul li a").on('click', function(event) {
//     event.preventDefault();
//     console.log("stopped event")
//     $('.container:last-child').append("<p>Hello</p>");
// });
