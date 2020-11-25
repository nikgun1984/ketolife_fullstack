const BASE_IMG_LINK = 'https://spoonacular.com/cdn/ingredients_250x250';

$("#add_links").on("submit",processForm);

$("#modbod").on("click", "div[data-id]", getIngredientUnits);

$(".modal").on("hidden.bs.modal", function(){
    $(".modal-body").html("");
    $("#back").remove();
});


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
                    <p>Estimated price per ${units[0]}: $${price}</p>
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
    handleNutrifacts(response);
}