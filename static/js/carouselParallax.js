/* Carousel*/
$("#recipeCarousel").carousel({
	interval: 2000,
});

$(".carousel .carousel-item").each(function () {
	const minPerSlide = 3;
	let next = $(this).next();
	if (!next.length) {
		next = $(this).siblings(":first");
	}
	next.children(":first-child").clone().appendTo($(this));

	for (let i = 0; i < minPerSlide; i++) {
		next = next.next();
		if (!next.length) {
			next = $(this).siblings(":first");
		}
		next.children(":first-child").clone().appendTo($(this));
	}
});

/* Parallax Transitioning */
$(document).ready(function () {
	const $window = $(window);
	$('section[data-type="background"]').each(function () {
		let $bgobj = $(this); // assigning the object

		$(window).scroll(function () {
			let yPos = -($window.scrollTop() / $bgobj.data("speed"));

			// Put together our final background position
			let coords = "50% " + yPos + "px";

			// Move the background
			$bgobj.css({ backgroundPosition: coords });
		});
	});
});

/* Navbar Transitioning */
$(document).ready(function () {
	$(window).scroll(function () {
		const scroll = $(window).scrollTop();
		if (scroll > 0) {
			$(".navbar").addClass("navbar-scroll");
		} else {
			$(".navbar").removeClass("navbar-scroll");
		}
		if (scroll > 200) {
			$(".navbar").addClass("bg-white");
		} else {
			$(".navbar").removeClass("bg-white");
		}
	});
});
