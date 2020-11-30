const BASE_IMG_LINK = 'https://spoonacular.com/cdn/ingredients_250x250';

$("#add_links").on("submit",processForm);

$("#modbod").on("click", "div[data-id]", getIngredientUnits);

$(".modal").on("hidden.bs.modal", function(){
    $(".modal-body").html("");
    $("#back").remove();
});

$("#search-recipe").on("submit",processRecipe);

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
    const response = await axios.post(`/api/get-instructions`,{url});
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
    const response = await axios.post('/api/get-ingredient', {ing});
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
    $('h5.modal-title').text(name.toUpperCase());
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
                     Would you like to find out Nutritional facts of this product?
                        <form id="units_form">
                            <label for="units">Choose a unit:</label>
                            <select name="units" id="units" data-id="${id}">
                            </select><br>
                            <label for="amount">Choose amount:</label>
                            <input type="number" id="amount" name="amount" min="1" max="200">
                            <button type="submit" class="btn btn-primary">Get Nutritional Facts</button>
                        </form>
                    </p>
                </div>
            </div>
        </div>
    `);
    $("#units_form").on("submit",getIngredientNutriFacts);
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
    const response = await axios.post(`/api/get-ingredient/${id}/nutrifacts`,{amount,unit});
    handleNutrifacts(response.data);
}

function handleNutrifacts(data){
    const price = data.cost;
    const nutrients = data.nutrients;
    $('#ing-details').append(`<p>Price for ${data.unit}: ${price}</p>`);
    for(let obj of nutrients){
        $('#ing-details').append(`<p>${obj.title} : ${obj.amount}</p>`);
    }
}