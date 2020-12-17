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

/* Will create a new message in the modal window*/
$(document).ready(function() {
    $('#register-form').on('submit', async function(evt) {
        evt.preventDefault();
        const username = $("input#username.form-control").val();
        const email = $("input#email.form-control").val();
        const password = $("input#password.form-control").val();
        const confirm = $("input#password_check.form-control").val();
        const data = await axios.post(`/`, {username,email,password,confirm});
        console.log(data);
        // if (data.status == 201) {
        //     $('#registerModal').modal('hide');
        //     location.reload();
        // }
    });
});

$(document).ready(function () {
	$("#login-form").on("submit", async function (evt) {
		evt.preventDefault();
		const email = $("input#email.form-control").val();
		const password = $("input#password.form-control").val();
		const data = await axios.post(`/login`, { email, password});
		console.log(data);
	});
});
   