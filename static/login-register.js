const iconList = [
	"fa fa-user",
	"fa fa-paper-plane",
	"fa fa-lock",
	"fa fa-check",
];

$("#login-win").on("click", function (evt) {
    evt.preventDefault();
    $("div#signup-id").addClass('d-none');
    $("div#login-id").removeClass('d-none');
});

$("#signup-win").on("click", function (evt) {
	evt.preventDefault();
    $("div#signup-id").removeClass("d-none");
	$("div#login-id").addClass("d-none");
});
   