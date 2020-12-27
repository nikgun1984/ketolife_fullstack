const BASE_IMG_LINK = "https://spoonacular.com/cdn/ingredients_250x250";
const nutriObject = nutritionObject();
let title = "",
	servings = 0,
	count = 0;

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
	const response = await axios.get("/api/get-ingredient", {
		params: {
			text: ing,
		},
	});
	handleResponse(response,'modbod');
}

async function processRecipeForm(evt) {
	evt.preventDefault();
	const ing = $("#ing-text").val();
	const response = await axios.get("/api/get-ingredient", {
		params: {
			text: ing,
		},
	});
	handleResponse(response, "modbod2");
}

function handleResponse(res,id) {
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
		`/api/get-ingredient/${id}/nutrifacts`
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
		''
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
	$("h5.modal-title").text(name[0].toUpperCase() + name.slice(1));
	$(".modal-body").append('<div id="ing-details"></div>');
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
	$(".modal-footer").prepend(
		'<button type="button" class="btn btn-outline-dark" id="back">Back</button>'
	);
	$("#back").on("click", function () {
		$("#options").show();
		$("#ing-details").remove();
		$("#back").hide();
	});
}

$(".modal").on("hidden.bs.modal", function () {
	$(".modal-body").html("");
	$("#back").remove();
});

$("#search-recipe").on("submit", processRecipe);

$("#recipe_title").on("submit", function (evt) {
	$("#ingr").show();
	evt.preventDefault();
	title = $("#title").val();
	$("#svg-container").append(addCheckmark());
});

$("#serving-form").on("submit", function (evt) {
	evt.preventDefault();
	if ($("#title").val()) {
		$("#serving-form").append(addCheckmark());
		$("#done-yield").show();
		servings = parseInt($("#serving").val());
		calculateGenNutritionPerServing(nutriObject.nutrients);
		calculateGenNutritionPerServing(nutriObject.vitamins);
		addValuesToNutritionTable();
		$("section.performance-facts").show();
	}
});

$("#done-ing").on("click", function (evt) {
	evt.preventDefault();
	$("#yield").show();
	$("#add_links").append(addCheckmark());
});

$(document).on("click", "i.fas.fa-trash-alt", function () {
	console.log("i am here");
	$(this).parents("tr").remove();
	if (!$("#recipe_ingr_table tbody").children().length) {
		$("#done-ing").remove();
	}
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
		console.log(calories);
		console.log(image);
		console.log(servings);
		console.log(ingredients);
		console.log(label);
		console.log(totalDaily);
		console.log(totalNutrients);
		console.log(url);
		console.log(instructions);
		console.log(prepMins);
		console.log(cookMins);
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
	// evt.preventDefault();
	const id = $("#units").attr("data-id");
	const amount = $("#amount").val();
	const unit = $("select#units").val();
	console.log(id, amount, unit);
	const response = await axios.get(`/api/get-ingredient/${id}/nutrifacts`, {
		params: {
			amount,
			units: unit
		}
	});
	const data = response.data;
	handleNutrifacts(data, "ingredientModal");
	$("#ingredient-header").text(`Ingredient: ${data.name}`);
	$("#ingr-unit").text(`${data.amount} ${data.amount} per serving`);
    calculateGenNutritionPerServing(nutriObject.nutrients);
	calculateGenNutritionPerServing(nutriObject.vitamins);
	addValuesToNutritionTable();
	$("section.performance-facts").show();
}
// FOR CREATING RECIPE
async function getInfoIngredient(evt) {
	evt.preventDefault();
	const id = $("#units").attr("data-id");
	let amount = $("#amount").val();
	const unit = $("select#units").val();
	const name = $("#ingredientModalLabel2").text();
	count += 1;
	$("#done-ing").show();
	$("#recipe_ingr_table tbody").append(`<tr id="${count}"></tr>`);
	$(`tr#${count}`).append(`<th scope="row">${count}</th>`);
	$(`tr#${count}`).append(`<td>${name}</td>`);
	$(`tr#${count}`).append(`<td>${amount}</td>`);
	$(`tr#${count}`).append(`<td>${unit}</td>`);
	$(`tr#${count}`).append(`<td><i class="fas fa-trash-alt"></i></td>`);
	if (isFraction(amount)) {
		amount = handleFraction(amount);
	} else {
		amount = parseFloat(amount);
	}
	const response = await axios.get(`/api/get-ingredient/${id}/nutrifacts`, {
		params: {
			amount,
			units: unit
		}
	});
	console.log(response.data);
	handleNutrifacts(response.data, "ingredientModal2");
}

// function handleNutrifacts(data){
//     const price = data.cost;
//     const nutrients = data.nutrients;
//     $('#ing-details').append(`<p>Price for ${data.unit}: ${price}</p>`);
//     for(let obj of nutrients){
//         $('#ing-details').append(`<p>${obj.title} : ${obj.amount}</p>`);
//     }
// }

function nutritionObject() {
	return {
		nutrients: {
			Calories: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Fat: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Trans Fat": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Saturated Fat": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Mono Unsaturated Fat": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Poly Unsaturated Fat": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Cholesterol: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Sodium: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Carbohydrates: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Net Carbohydrates": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Fiber: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Sugar: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Sugar Alcohol": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Alcohol: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Caffeine: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Protein: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
		},
		vitamins: {
			Potassium: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Calcium: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Copper: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Zinc: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Phosphorus: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Iron: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin A": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin B1": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin B2": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin B3": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin B5": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin B6": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin B12": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin C": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin D": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin E": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Vitamin K": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			"Folic Acid": {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Selenium: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Iodine: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Choline: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
			Magnesium: {
				amount: 0,
				unit: "",
				percentOfDailyNeeds: 0,
			},
		},
	};
}

function handleNutrifacts(data,id) {
	//const price = data.cost;
	const nutrients = data.nutrients;
	const cost = data.cost;
	const unit = data.unit;
	const amount = data.amount;
	const name = data.name;
	for (let obj of nutrients) {
		if (obj.title in nutriObject.nutrients) {
			nutriObject.nutrients[obj.title].amount += obj.amount;
			nutriObject.nutrients[obj.title].unit = obj.unit;
			nutriObject.nutrients[obj.title].percentOfDailyNeeds +=
				obj.percentOfDailyNeeds;
		} else if (obj.title in nutriObject.vitamins) {
			nutriObject.vitamins[obj.title].amount += obj.amount;
			nutriObject.vitamins[obj.title].unit = obj.unit;
			nutriObject.vitamins[obj.title].percentOfDailyNeeds +=
				obj.percentOfDailyNeeds;
		}
	}
	console.log(nutriObject);
	console.log(name);
	console.log(unit);
	console.log(amount);
	console.log(cost);

	$(`#${id}`).modal("hide");
	return {
		nutriObject,
		name,
		unit,
		amount,
		cost
	};
}

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

function calculateGenNutritionPerServing(nutriObj) {
	const nutrients = Object.keys(nutriObj);
	for (let obj of nutrients) {
		if (nutriObj[obj].amount) {
			nutriObj[obj].amount = Math.ceil(nutriObj[obj].amount / servings);
		}
		if (nutriObj[obj].percentOfDailyNeeds) {
			nutriObj[obj].percentOfDailyNeeds = Math.ceil(
				nutriObj[obj].percentOfDailyNeeds / servings
			);
		}
	}
}

function addValuesToNutritionTable() {
	const servingsPerRecipe = $("p.servings_recipe");
	const caloriesField = $("#Calories td b");
	servingsPerRecipe.append(servings);
	caloriesField.append(nutriObject.nutrients.Calories.amount);
	const nutrientsTable = $(".performance-facts__table tbody");
	const vitaminsTable = $(".performance-facts__table--grid tbody");
	const fats = new Set([
		"Trans Fat",
		"Saturated Fat",
		"Mono Unsaturated Fat",
		"Poly Unsaturated Fat",
	]);
	const carbs = new Set([
		"Sugar Alcohol",
		"Sugar",
		"Fiber",
		"Net Carbohydrates",
	]);
	for (let nutrient in nutriObject.nutrients) {
		const { amount, unit, percentOfDailyNeeds } = nutriObject.nutrients[
			nutrient
		];
		if (parseInt(amount) && nutrient != "Calories") {
			if (fats.has(nutrient) || carbs.has(nutrient)) {
				nutrientsTable.append(
					`<tr id = ${nutrient}>
                        <td class = "blank-cell"></td>
                        <th>${nutrient} ${amount}${unit}</th> 
                        <td><b>${percentOfDailyNeeds}%</b></td>
                     </tr>
                `
				);
			} else {
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
	$("tr#Protein").addClass("thick-end");

	for (let vitamin in nutriObject.vitamins) {
		const { amount, unit, percentOfDailyNeeds } = nutriObject.vitamins[vitamin];
		if (amount) {
			vitaminsTable.append(
				`<tr id=${vitamin}>
                    <th colspan="2"><b>${vitamin}</b> ${amount}${unit}</th>
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

$(document).ready(function () {
	$(".alert").delay(4000).slideUp(300);
});

// HOVERING, CLICKING OVER the RATING
let funcs = [];
$("#ratings").on("mouseover", "i", async function (evt) {

	for (let i = 1; i <= 5; i++) {
		if (i <= $(this).attr("data-id")) {
			$(`i#${i}`).addClass("star-yellow");
		} else {
			$(`i#${i}`).removeClass("star-yellow");
		}
	}
}).on("click", "i", async function (evt) {
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
		.then(function(response){
			console.log(response.data);
			const avg = response.data[0].toFixed(1);
			$("span#avg-rating").text(avg);
			const percentages = response.data[1];
			for(let val=4;val>-1;val--){
				// funcs[val] = function() {
					$(`p#stars-total-${val}`).text(`${val + 1} stars`);
					// console.log(percentages[val]);
					//console.log(val);
					const perc = percentages[val];
					// console.log(perc);
					console.log(val);

					$(`#${val}-perc`).css("width", `${perc}%`);
					$(`#${val}-perc`).attr("aria-valuenow", perc);
					$(`#${val}-perc`).text(`${perc}%`);
					if (perc == 0) {
						$(`#${val}-perc`).addClass("text-dark");
					} else {
						$(`#${val}-perc`).removeClass("text-dark");
					}
				// }
			}
			// for (let val=4;val>-1;val--) {
			// 	// we can use "var" here without issue
			// 	funcs[j]();
			// 	console.log(funcs[j]());
			// }
		})
		.catch((error) => {
			console.log(error.response);
		});
}).on("mouseout", "i", async function (evt) {
		for (let i = 1; i <= 5; i++) {
			$(`i#${i}`).removeClass("star-yellow");
		}
});
