const BASE_IMG_LINK = "https://spoonacular.com/cdn/ingredients_250x250";

$("#add_links").on("submit", processForm);

$("#add_links_cr").on("submit", processRecipeForm);

$("#modbod").on("click", "div[data-id]", getIngredientUnits);

$("#modbod2").on("click", "div[data-id]", getIngredientUnitsForRecipe);

async function getIngredientUnits(evt) {
	evt.preventDefault();
	const id = $(evt.currentTarget).attr("data-id");
	const response = await axios.get(`/api/get-ingredient/${id}`);
	console.log(response.data);
	handleResponseInfoForIngredient(response.data);
}

async function getIngredientUnitsForRecipe(evt) {
	evt.preventDefault();
	const id = $(evt.currentTarget).attr("data-id");
	const response = await axios.get(`/api/get-ingredient/${id}`);
	console.log(response.data);
	handleResponseInfoForRecipe(response.data);
}

/* Ingredient form */

async function processForm(evt) {
	evt.preventDefault();
	const ing = $("#text").val();
	console.log(ing);
	const response = await axios.get("/api/get-ingredient", {
		params: {
			text: ing,
		},
	});
	$("#ingredientModalLabel").html("Choose your Ingredients");
	handleResponse(response, "modbod");
}

async function processRecipeForm(evt) {
	evt.preventDefault();
	const ing = $("#ing-text").val();
	console.log(ing);
	const response = await axios.get("/api/get-ingredient", {
		params: {
			text: ing,
		},
	});
	$("#ingredientModalLabel2").html("Choose your Ingredients");
	handleResponse(response, "modbod2");
}

function handleResponse(res, id) {
	//$('#modbod').empty()
	$(`#${id}`).append("<div id='options'></div>");
	console.log(res.data);
	console.log(Object.keys(res.data).length === 0);

	if (Object.keys(res.data).length !== 0) {
		for (let val in res.data) {
			$("#options").append(
				`<div data-id="${res.data[val]}"><a href="">${val}</a></div>`
			);
		}
	} else {
		$("#options").append(
			`<h3>Sorry, nothing was found</h3>
		<p>This is usually due to mispelling or server error :(</p>
		`
		);
	}
}

function handleResponseInfoForIngredient(data) {
	$("#options").hide();
	const img = `${BASE_IMG_LINK}/${data.img}`;
	const amtPerServing = data.price;
	const units = data.units;
	const name = data.name;
	const id = data.id;
	formNutritionLookUp(
		img,
		amtPerServing,
		units,
		name,
		id,
		data.category[0],
		data.category[1],
		getIngredientNutriFacts,
		`/api/get-ingredient/${id}/info`
	);
}

function handleResponseInfoForRecipe(data) {
	$("#options").hide();
	const img = `${BASE_IMG_LINK}/${data.img}`;
	const amtPerServing = data.price;
	const units = data.units;
	const name = data.name;
	const id = data.id;
	formNutritionLookUp(
		img,
		amtPerServing,
		units,
		name,
		id,
		data.category[0],
		data.category[1],
		getInfoIngredient,
		`/api/get-ingredient/${id}/nutrifacts`
	);
}

function formNutritionLookUp(
	img,
	price,
	units,
	name,
	id,
	category1,
	category2,
	func,
	route
) {
	$("h5.title-ingr").text(name[0].toUpperCase() + name.slice(1));
	$(".body-ingr").append('<div id="ing-details"></div>');
	$("#ing-details").append(`
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-8">
                    <img src="${img}" alt="">
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-8 text-center">
                    <h6>Category: ${category1}/${category2}</h6>
                    <p>
						<form id="units_form" action="${route}">
							<div class="form-group">
								<label for="units"><b>Choose a unit:</b></label>
								<select id="units" name="units" data-id="${id}" class="form-control">
								</select>
							</div>
							<div class="form-group">
    							<label for="amount"><b>Choose amount:</b></label>
    							<input type="text" class="form-control" id="amount" name="amount" placeholder="Enter the amount">
  							</div>
                            <button id="unit-form-btn" type="submit" class="btn btn-outline-dark" >Submit</button>
                        </form>
                    </p>
                </div>
            </div>
        </div>
    `);
	$("#units_form").on("submit", func);
	const sb = document.querySelector("#units");
	for (let unit of units) {
		let newOption = new Option(unit, unit);
		sb.add(newOption, undefined);
	}
	$(".footer-ingr").prepend(
		'<button type="button" class="btn btn-outline-dark" id="back">Back</button>'
	);
	$("#back").on("click", function () {
		$("#options").show();
		$("#ing-details").remove();
		$("#back").hide();
	});
}

/* Local Storage Manipulations */
function accessToLocaStorage() {
	let existing = localStorage.getItem("recipe");
	existing = existing ? JSON.parse(existing) : {};
	return existing;
}

function saveToLocStorage(key, val) {
	let existing = accessToLocaStorage();
	existing[key] = val;
	localStorage.setItem("recipe", JSON.stringify(existing));
}

function saveIngInst(key, val) {
	let existing = accessToLocaStorage();
	existing[key] = existing[key] ? existing[key] : [];
	existing[key].push(val);
	localStorage.setItem("recipe", JSON.stringify(existing));
}

function deleteIngInst(key, idx) {
	let existing = accessToLocaStorage();
	existing[key] = existing[key] ? existing[key].split(",") : [];
	existing[key].splice(idx, 1);
	localStorage.setItem("recipe", JSON.stringify(existing));
}

function lenRecipeArray(obj) {
	let existing = accessToLocaStorage();
	console.log(existing[obj].length);
	return existing[obj].length;
}

function saveNutrients(nutrients, vitamins) {
	let existing = accessToLocaStorage();
	existing["nutrients"] = existing["nutrients"] ? existing["nutrients"] : [];
	existing["vitamins"] = existing["vitamins"] ? existing["vitamins"] : [];
	existing["nutrients"].push(nutrients);
	existing["vitamins"].push(vitamins);
	localStorage.setItem("recipe", JSON.stringify(existing));
}

function deleteFromIngredientList(id, nutrients, vitamins) {
	let existing = accessToLocaStorage();
	existing["ingredients"].splice(id, 1);
	existing["nutrients"].splice(id, 1);
	existing["vitamins"].splice(id, 1);
	saveToLocStorage("total_nutrients", nutrients);
	saveToLocStorage("total_vitamins", vitamins);
}

window.onbeforeunload = function (e) {
	localStorage.clear();
};

////////////////////////////////////////////////////////////////////

$(".modal").on("hidden.bs.modal", function () {
	$(".body-ingr").html("");
	$("#back").remove();
});

$("#search-recipe").on("submit", processRecipe);

$(document).on("submit", "#recipe_title", function (evt) {
	$("#yield").show();
	evt.preventDefault();
	saveToLocStorage("title", $("#title").val());
	$("#svg-container-1").append(addCheckmark());
});

$(document).on("submit", "#serving-form", function (evt) {
	evt.preventDefault();
	if ($("#title").val()) {
		$("#done-yield").show();
		const servingsPerRecipe = $("p.servings_recipe");
		saveToLocStorage("servings", parseInt($("#serving").val()));
		const existing = accessToLocaStorage();
		servingsPerRecipe.html(`Servings Per Recipe ${existing["servings"]}`);
	}
});

$("#cooking-time").on("submit", function (evt) {
	evt.preventDefault();
	$("#done-ttime").show();
	saveToLocStorage("ttime", parseInt($("#ctime").val()));
});

$("#done-ing").on("click", function (evt) {
	evt.preventDefault();
	$("#inst").show();
	$("#svg-container-2").append(addCheckmark());
	$("#done-ing").remove();
});

$("#done-yield").on("click", function (evt) {
	evt.preventDefault();
	$("#ingr").show();
	$("#svg-container-3").append(addCheckmark());
	$("#done-yield").remove();
});

$("#done-inst").on("click", function (evt) {
	evt.preventDefault();
	$("#cuisine").show();
	$("#svg-container-4").append(addCheckmark());
	$("#done-inst").remove();
});

$("#done-type").on("click", function (evt) {
	evt.preventDefault();
	const existing = accessToLocaStorage();
	const mealType = $("#mealtype").find(":selected").text();
	const dishType = $("#dishtype").find(":selected").text();
	saveToLocStorage("mealType", mealType);
	saveToLocStorage("dishType", dishType);
	$("#ttime").show();
	$("#svg-container-5").append(addCheckmark());
	$("#done-type").remove();
});

$("#done-ttime").on("click", function (evt) {
	evt.preventDefault();
	$("#picture").show();
	$("#svg-container-6").append(addCheckmark());
	$("#done-ttime").remove();
});

$(document).ready(function () {
	$(".show-modal").click(function () {
		$("#ingredientModal").modal({
			backdrop: "static",
			keyboard: false,
		});
	});
});

$(document).ready(function () {
	$(".show-modal").click(function () {
		$("#ingredientModal2").modal({
			backdrop: "static",
			keyboard: false,
		});
	});
});

$(document).on("click", "i.fas.fa-trash-alt", async function () {
	const existing = accessToLocaStorage();
	const id = parseInt($(this).closest("tr").attr("id"));
	const response = await axios.get("/api/delete-ingredient", {
		params: {
			nutrients: JSON.stringify(existing["nutrients"][id - 1]),
			vitamins: JSON.stringify(existing["vitamins"][id - 1]),
			total_nutrients: JSON.stringify(existing["total_nutrients"]),
			total_vitamins: JSON.stringify(existing["total_vitamins"]),
		},
	});
	deleteFromIngredientList(id - 1, response.data[0], response.data[1]);
	addValuesToNutritionTable();
	let cache = $(this).closest("tbody");
	$(this).parents("tr").remove();
	cache.find("tr").attr("id", function (i) {
		return i + 1;
	});
	if (!$("#recipe_ingr_table tbody").children().length) {
		$("#done-ing").remove();
	}
});

$(document).on("click", "i.fas.fa-trash-alt.instr", function () {
	const existing = accessToLocaStorage();
	const id = parseInt($(this).closest("tr").attr("id").replace(/\D/g, ""));
	existing["instructions"].splice(id - 1, 1);
	saveToLocStorage("instructions", existing["instructions"]);
	let cache = $(this).closest("tbody");
	$(this).parents("tr").remove();
	cache.find("tr").attr("id", function (i) {
		const idx = i + 1;
		return `${idx}-step`;
	});
});

async function processRecipe(evt) {
	evt.preventDefault();
	keyword = $("#search").val();
	const response = await axios.get(`/api/get-recipe`, {
		params: {
			search: keyword,
		},
	});
	await handleRecipe(response.data.hits);
}

async function handleRecipe(data) {
	for (let rec of data) {
		const calories = rec.recipe.calories;
		const image = rec.recipe.image;
		const servings = rec.recipe.yield;
		const ingredients = rec.recipe.ingredients;
		const label = rec.recipe.label;
		const totalDaily = rec.recipe.totalDaily;
		const totalNutrients = rec.recipe.totalNutrients;
		const url = rec.recipe.url;
		const { instructions, prepMins, cookMins } = await getInstructions(url);
	}
}

async function getInstructions(url) {
	const response = await axios.get(`/api/get-instructions`, {
		params: {
			url,
		},
	});
	console.log(response);
	const instructions = response.data.analyzedInstructions[0].steps;
	const prepMins = response.data.preparationMinutes;
	const cookMins = response.data.cookingMinutes;
	return {
		instructions,
		prepMins,
		cookMins,
	};
}

// FOR INGREDIENT
async function getIngredientNutriFacts(evt) {
	const id = $("#units").attr("data-id");
	const amount = $("#amount").val();
	const unit = $("select#units").val();
	await axios.get(`/api/get-ingredient/${id}/info`, {
		params: {
			amount,
			units: unit,
		},
	});
}
// FOR CREATING RECIPE
async function getInfoIngredient(evt) {
	evt.preventDefault();
	const id = $("#units").attr("data-id");
	let amount = $("#amount").val();
	const unit = $("select#units").val();
	const name = $("#ingredientModalLabel2").text();
	if (isFraction(amount)) {
		amount = handleFraction(amount);
	} else {
		amount = parseFloat(amount);
	}
	const existing = accessToLocaStorage();
	const response = await axios.post(`/api/get-ingredient/${id}/nutrifacts`, {
		body: {
			amount,
			units: unit,
			serving: existing["servings"],
			nutrients: JSON.stringify(existing["total_nutrients"]),
			vitamins: JSON.stringify(existing["total_vitamins"]),
		},
	});
	const netCarbAmount = response.data[2]["Net Carbohydrates"]["amount"];
	if (netCarbAmount < 15) {
		const res = `${name}: ${amount} ${unit}`;
		saveIngInst("ingredients", res);
		saveNutrients(response.data[0], response.data[1], "nutrients", "vitamins");
		saveToLocStorage("total_nutrients", response.data[2]);
		saveToLocStorage("total_vitamins", response.data[3]);
		let count = lenRecipeArray("ingredients");
		$("#done-ing").show();
		$("#recipe_ingr_table tbody").append(`<tr id="${count}"></tr>`);
		$(`tr#${count}`).append(`<th scope="row">${count}</th>`);
		$(`tr#${count}`).append(`<td>${name}</td>`);
		$(`tr#${count}`).append(`<td>${amount}</td>`);
		$(`tr#${count}`).append(`<td>${unit}</td>`);
		$(`tr#${count}`).append(`<td><i class="fas fa-trash-alt"></i></td>`);
		////////////////////////////////////////////// Add nutrient table
		$("div#ingr").removeClass("justify-content-center");
		//$("div.tbl-ingredients").addClass("col-xl-6 ");
		$("div.tbl-nutrients").removeClass("is-hidden");
		addValuesToNutritionTable();
	} else {
		$("#not-keto").modal("show");
	}
	$("#ingredientModal2").modal("toggle");
	$("#ing-text").val("");
}

$("form#add_instr").on("submit", function addInstruction(evt) {
	evt.preventDefault();
	let step = $("#inst-text").val();
	saveIngInst("instructions", step);
	const count = lenRecipeArray("instructions");
	$("#done-inst").show();
	$("#recipe_instr_table tbody").append(`<tr id="${count}-step"></tr>`);
	$(`tr#${count}-step`).append(`<th scope="row">${count}</th>`);
	$(`tr#${count}-step`).append(`<td>${step}</td>`);
	$(`tr#${count}-step`).append(
		`<td><i class="fas fa-trash-alt instr"></i></td>`
	);
	$("#inst-text").val("");
});

function isFraction(val) {
	return val.includes("/") ? true : false;
}

function handleFraction(val) {
	let split, result;
	if (val.includes(" ")) {
		//split whole num and proper fraction
		let mixed_num = val.split(" ");
		split = [mixed_num[0], ...mixed_num[1].split("/")];
		result = (
			(parseInt(split[0]) * parseInt(split[2]) + parseInt(split[1])) /
			parseInt(split[2])
		).toFixed(2);
	} else {
		//simple fractions
		split = val.split("/");
		result = (parseInt(split[0], 10) / parseInt(split[1], 10)).toFixed(2);
	}
	return result;
}

function addCheckmark() {
	return `
        <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 130.2 130.2" class="mx-sm-1 mb-5">
            <circle class="path circle" fill="none" stroke="#73AF55" stroke-width="6" stroke-miterlimit="10" cx="65.1" cy="65.1" r="62.1"/>
            <polyline class="path check" fill="none" stroke="#73AF55" stroke-width="6" stroke-linecap="round" stroke-miterlimit="10" points="100.2,40.2 51.5,88.8 29.8,67.5 "/>
        </svg>
    `;
}

function addValuesToNutritionTable() {
	const existing = accessToLocaStorage();
	const nutrients = existing["total_nutrients"];
	const servingsPerRecipe = $("p.servings_recipe");
	const caloriesField = $("td#cal b");
	servingsPerRecipe.html(`Servings Per Recipe ${existing["servings"]}`);
	caloriesField.html(nutrients["Calories"]["amount"]);
	const nutrientsTable = $(".performance-facts__table tbody");
	nutrientsTable.find("tr:not(:nth-child(1)):not(:nth-child(2))").remove();
	for (let nutrient in nutrients) {
		const { amount, unit, percentOfDailyNeeds } = nutrients[nutrient];
		if (parseInt(amount) && nutrient != "Calories") {
			nutrientsTable.append(
				`<tr id = ${nutrient}>
					<th colspan = "2"><b>${nutrient}</b> ${amount}${unit}</th> 
					<td><b>${percentOfDailyNeeds}%</b></td>
				</tr>
			`
			);
		}
	}
}

/* Search for recipe*/

$("form#search-recipe-form").on("submit", async function () {
	const val = $("input#search-bar").val();
	const response = await axios.get(`/api/get-recipe`, {
		params: {
			val: val,
		},
	});
});

// flash
$(document).ready(function () {
	$(".alert").delay(4000).slideUp(300);
});

// HOVERING, CLICKING OVER the RATING
let funcs = [];
$("#ratings")
	.on("mouseover", "i", async function (evt) {
		for (let i = 1; i <= 5; i++) {
			if (i <= $(this).attr("data-id")) {
				$(`i#${i}`).addClass("star-yellow");
			} else {
				$(`i#${i}`).removeClass("star-yellow");
			}
		}
	})
	.on("click", "i", async function (evt) {
		for (let i = 1; i <= 5; i++) {
			if (i <= $(this).attr("data-id")) {
				$(`i#${i}`).addClass("star-red");
			} else {
				$(`i#${i}`).removeClass("star-red");
			}
		}
		const recipe_id = $("#recipe-content-id").val();
		const rating = $(this).attr("data-id");

		const response = await axios
			.post(`/api/add-rating`, {
				recipe_id: recipe_id,
				rating: rating,
			})
			.then(function (response) {
				console.log(response.data);
				const avg = response.data[0].toFixed(1);
				$("span#avg-rating").text(avg);
				const percentages = response.data[1];
				for (let val = 4; val > -1; val--) {
					$(`p#stars-total-${val}`).text(`${val + 1} stars`);
					const perc = percentages[val];

					$(`#${val}-perc`).width(`${perc}%`);
					$(`#${val}-perc`).attr("aria-valuenow", perc);
					$(`#${val}-perc`).text(`${perc}%`);
					if (perc == 0) {
						$(`#${val}-perc`).addClass("text-dark");
					} else {
						$(`#${val}-perc`).removeClass("text-dark");
					}
				}
			})
			.catch((error) => {
				console.log(error.response);
			});
	})
	.on("mouseout", "i", async function (evt) {
		for (let i = 1; i <= 5; i++) {
			$(`i#${i}`).removeClass("star-yellow");
		}
	});

$("#recipe_submit").on("submit", async function (evt) {
	evt.preventDefault();
	const existing = accessToLocaStorage();
	delete existing["nutrients"];
	delete existing["vitamins"];
	const formData = new FormData();
	const element = document.getElementById("uploadImage");
	const file = element.files[0];
	formData.append("file", file);
	formData.append("otherData", JSON.stringify(existing));

	const resp = await axios.post("/api/create-recipe", formData);
	window.location.href = resp.data;
});

$(document).ready(function () {
	$("#uploadProfileImage").change(async function () {
		const fileData = document.getElementById("uploadProfileImage");
		const file = fileData.files[0];
		let formData = new FormData();
		formData.append("file", file);

		const resp = await axios.post("/upload-profile-image", formData);
		window.location.href = resp.data;
	});
});

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

//Dropdown nav for mobile
$(".navbar-nav li a").on("click", function () {
	if (!$(this).hasClass("dropdown-toggle")) {
		$(".navbar-collapse").collapse("hide");
	}
});
