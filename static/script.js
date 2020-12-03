const BASE_IMG_LINK = 'https://spoonacular.com/cdn/ingredients_250x250';
const nutriObject = nutritionObject();
let title = '',
    servings = 0,
    count = 0;

$("#add_links").on("submit",processForm);

$("#modbod").on("click", "div[data-id]", getIngredientUnits);

$(".modal").on("hidden.bs.modal", function(){
    $(".modal-body").html("");
    $("#back").remove();
});

$("#search-recipe").on("submit",processRecipe);

$("#recipe_title").on("submit",function(evt){
    $("#ingr").show();
    evt.preventDefault();
    title = $('#title').val();
    console.log(title);
});

$("#done-ing").on("click",function(evt){
    evt.preventDefault();
    $("#yield").show();
    evt.preventDefault();
    servings = $('#serving').val();
    console.log(servings);
});

$(document).on('click',"i.fas.fa-trash-alt",function(){
    console.log('i am here');
    $(this).parents("tr").remove();
    if(!$("#recipe_ingr_table tbody").children().length){
        $('#done-ing').remove();
    }
});

$(document).ready(function(){
    $(".show-modal").click(function(){
        $("#ingredientModal").modal({
            backdrop: 'static',
            keyboard: false
        });
    });
});

async function processRecipe(evt){
    evt.preventDefault();
    keyword = $('#search').val();
    const response = await axios.get(`/api/get-recipe`,{params:{search:keyword}});
    await handleRecipe(response.data.hits);
}
async function handleRecipe(data){
    for(let rec of data){
        const calories = rec.recipe.calories;
        const image = rec.recipe.image;
        const servings = rec.recipe.yield;
        const ingredients = rec.recipe.ingredients;
        const label = rec.recipe.label;
        const totalDaily = rec.recipe.totalDaily;
        const totalNutrients = rec.recipe.totalNutrients;
        const url = rec.recipe.url;
        const {instructions, prepMins, cookMins} = await getInstructions(url);
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

async function getInstructions(url){
    const response = await axios.get(`/api/get-instructions`,{params:{url}});
    console.log(response);
    const instructions = response.data.analyzedInstructions[0].steps;
    const prepMins = response.data.preparationMinutes;
    const cookMins = response.data.cookingMinutes;
    return {
        instructions,
        prepMins,
        cookMins
    }
}

async function processForm(evt) {
    evt.preventDefault();
    const ing = $('#text').val();
    console.log(ing)
    const response = await axios.get('/api/get-ingredient', {params:{text:ing}});
    handleResponse(response);
}

function handleResponse(res) {
    //$('#modbod').empty()
    $('#modbod').append("<div id='options'></div>")
    for(let val in res.data){
        $('#options').append(`<div data-id="${res.data[val]}"><a href="">${val}</a></div>`);
    }
}

function handleResponseInfo(data) {
    $('#options').hide();
    const img = `${BASE_IMG_LINK}/${data.img}`;
    const amtPerServing = data.price;
    const units = data.units;
    const name = data.name;
    const id = data.id;
    formNutritionLookUp(img,amtPerServing,units,name,id,data.category[0],data.category[1]);
}

function formNutritionLookUp(img,price,units,name,id,category1,category2){
    $('h5.modal-title').text(name[0].toUpperCase()+name.slice(1));
    $('.modal-body').append('<div id="ing-details"></div>');
    $('#ing-details').append(`
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-8">
                    <img src="${img}" alt="">
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-8 text-center">
                    <p>Category: ${category1}, ${category2}</p>
                    <p>
                        <form id="units_form">
                            <label for="units">Choose a unit:</label>
                            <select name="units" id="units" data-id="${id}">
                            </select><br>
                            <label for="amount">Choose amount:</label>
                            <input type="text" id="amount" name="amount">
                            <button id="unit-form-btn" type="submit" class="btn btn-primary">Submit</button>
                        </form>
                    </p>
                </div>
            </div>
        </div>
    `);
    $("#units_form").on("submit",getInfoIngredient);
    const sb = document.querySelector('#units');
    for(let unit of units){
        let newOption = new Option(unit,unit);
        sb.add(newOption,undefined);
    }
    $('.modal-footer').prepend('<button type="button" class="btn btn-primary" id="back">Back</button>');
    $("#back").on("click", function(){
        $("#options").show();
        $("#ing-details").remove();
        $("#back").hide();
    });
}

async function getIngredientUnits(evt){
    evt.preventDefault();
    const id = $(evt.currentTarget).attr("data-id")
    const response = await axios.get(`/api/get-ingredient/${id}`);
    console.log(response.data);
    handleResponseInfo(response.data);

}

async function getIngredientNutriFacts(evt){
    evt.preventDefault();
    const id = $("#units").attr("data-id")
    const amount = $('input[type=number]').val();
    const unit = $("select#units").val();
    console.log(id,amount,unit);
    const response = await axios.get(`/api/get-ingredient/${id}/nutrifacts`,{params:{amount,units:unit}});
    handleNutrifacts(response.data);
}

async function getInfoIngredient(evt){
    evt.preventDefault();
    const id = $("#units").attr("data-id");
    let amount = $('#amount').val();
    const unit = $("select#units").val();
    const name = $("#ingredientModalLabel").text();
    count += 1;
    $("#done-ing").show();
    $('#recipe_ingr_table tbody').append(`<tr id="${count}"></tr>`);
    $(`tr#${count}`).append(`<th scope="row">${count}</th>`);
    $(`tr#${count}`).append(`<td>${name}</td>`);
    $(`tr#${count}`).append(`<td>${amount}</td>`);
    $(`tr#${count}`).append(`<td>${unit}</td>`);
    $(`tr#${count}`).append(`<td><i class="fas fa-trash-alt"></i></td>`);
    if(isFraction(amount)){
        amount = handleFraction(amount);
    } else {
        amount = parseFloat(amount)
    }
    const response = await axios.get(`/api/get-ingredient/${id}/nutrifacts`,{params:{amount,units:unit}});
    //console.log(response.data);
    handleNutrifacts(response.data);
}

// function handleNutrifacts(data){
//     const price = data.cost;
//     const nutrients = data.nutrients;
//     $('#ing-details').append(`<p>Price for ${data.unit}: ${price}</p>`);
//     for(let obj of nutrients){
//         $('#ing-details').append(`<p>${obj.title} : ${obj.amount}</p>`);
//     }
// }

function nutritionObject(){
    return {
        nutrients:{
            "Calories":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Fat":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Trans Fat":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Saturated Fat":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Mono Unsaturated Fat":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Poly Unsaturated Fat":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Protein":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Cholesterol":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Carbohydrates":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Net Carbohydrates":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Alcohol":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Fiber":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Sugar":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Sodium":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Caffeine":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            }
        },
        vitamins:{
            "Potassium":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Calcium":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Copper":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Zinc":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Phosphorus":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Iron":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin A":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin B1":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin B2":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin B3":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin B5":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin B6":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin B12":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin C":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin D":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin E":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Vitamin K":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Folic Acid":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Selenium":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Iodine":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Choline":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            },
            "Magnesium":{
                "amount": 0,
                "unit": "",
                "percentOfDailyNeeds": 0
            }
        }
    }
}

function handleNutrifacts(data){
    //const price = data.cost;
    const nutrients = data.nutrients;
    for(let obj of nutrients){
        if(obj.title in nutriObject.nutrients){
            nutriObject.nutrients[obj.title].amount += obj.amount;
            nutriObject.nutrients[obj.title].unit = obj.unit;
            nutriObject.nutrients[obj.title].percentOfDailyNeeds += obj.percentOfDailyNeeds;
        } else if (obj.title in nutriObject.vitamins){
            nutriObject.vitamins[obj.title].amount += obj.amount;
            nutriObject.vitamins[obj.title].unit = obj.unit;
            nutriObject.vitamins[obj.title].percentOfDailyNeeds += obj.percentOfDailyNeeds;
        }
    }
    console.log(nutriObject);
    $('#ingredientModal').modal('hide');
}

function isFraction(val){
    return val.includes('/')?true:false;
}

function handleFraction(val){
    let split,
        result;
    if(val.includes(' ')){
        //split whole num and proper fraction
        let mixed_num = val.split(' ');
        split = [mixed_num[0],...mixed_num[1].split('/')]
        result = ((parseInt(split[0])*parseInt(split[2])+parseInt(split[1]))/parseInt(split[2])).toFixed(2);
    } else {
        //simple fractions
        split = val.split('/');
        result = (parseInt(split[0], 10) / parseInt(split[1], 10)).toFixed(2);
    }
    return result;
}

