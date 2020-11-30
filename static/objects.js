class Recipe{
    constructor()

    static async getRecipe(keyWord){
        // first lets query our endpoint /api/get-recipe
        const response = await axios.get('/api/get-recipe', {params: {search: keyWord}});

    }
}