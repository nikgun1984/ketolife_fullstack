$("#add_links").on("submit",processForm);

async function processForm(evt) {
    evt.preventDefault();
    const ing = $('#text').val();
    console.log(ing)
    const response = await axios.post('/api/get-ingredient-info', {ing});
    handleResponse(response);
}

function handleResponse(res) {
    $('#modbod').empty()
    for(let val of Object.keys(res.data)){
        $('#modbod').append(`<div><a href="">${val}</a></div>`);
    }
}