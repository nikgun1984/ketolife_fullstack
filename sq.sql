INSERT INTO units (name)
VALUES ('g'),
    ('mg'),
    ('µg'),
    ('%');
INSERT INTO nutrients (name, unit_id)
VALUES ('Calories', NULL),
    ('Fat', 1),
    ('Trans Fat', 1),
    ('Saturated Fat', 1),
    (
        'Mono Unsaturated Fat',
        1
    ),
    (
        'Poly Unsaturated Fat',
        1
    ),
    (
        'Cholesterol',
        2
    ),
    (
        'Sodium',
        2
    ),
    (
        'Carbohydrates',
        1
    ),
    (
        'Net Carbohydrates',
        1
    ),
    (
        'Fiber',
        1
    ),
    (
        'Sugar',
        1
    ),
    (
        'Sugar Alcohol',
        1
    ),
    (
        'Protein',
        1
    ),
    (
        'Caffeine',
        2
    ),
    (
        'Calcium',
        2
    ),
    (
        'Magnesium',
        3
    ),
    (
        'Potassium',
        2
    ),
    (
        'Copper',
        2
    ),
    (
        'Zinc',
        2
    ),
    (
        'Phosphorus',
        2
    ),
    (
        'Iron',
        2
    ),
    (
        'Vitamin A',
        3
    ),
    (
        'Vitamin B1',
        3
    ),
    (
        'Vitamin B2',
        3
    ),
    (
        'Vitamin B1',
        3
    ),
    (
        'Vitamin B1',
        3
    ),
    (
        'Vitamin B3',
        3
    ),
    (
        'Vitamin B5',
        3
    ),
    (
        'Vitamin B6',
        3
    ),
    (
        'Vitamin B12',
        3
    ),
    (
        'Vitamin C',
        3
    ),
    (
        'Vitamin D',
        3
    ),
    (
       'Vitamin E',
        3
    ),
    (
        'Vitamin K',
        3
    ),
    (
        'Folic Acid',
        3
    ),
    (
        'Selenium',
        3
    ),
    (
        'Choline',
        3
    ),
    (
        'Iodine',
        3
    ),
    (
        'Carbs',
        1
    ),
    (
        'Monounsaturated',
        1
    ),
    (
        'Polyunsaturated',
        1
    ),
    (
        'Saturated',
        3
    ),
    (
        'Trans',
        3
    ),
    (
        'Thiamin (B1)',
        2
    ),
    (
        'Riboflavin (B2)',
        2
    ),
    (
        'Niacin (B3)',
        2
    ),
    (
        'Niacin (B3)',
        2
    ),
    (
        'Folate equivalent (total)',
        2
    )

    ;


INSERT INTO products (name,image,net_carbs,product_type) VALUES
('jalapeno peppers','https://spoonacular.com/cdn/ingredients_250x250/jalapeno-pepper.jpg',3.7,'veggies'),
('portobello mushrooms','https://cdn-prod.medicalnewstoday.com/content/images/articles/278/278858/mushrooms-in-a-bowel-on-a-dark-table.jpg',2.6,'veggies'),
('white mushrooms','https://spoonacular.com/cdn/ingredients_100x100/mushrooms.jpg',2.3,'veggies'),
('beets','https://spoonacular.com/cdn/ingredients_100x100/beets.jpg',6.8,'veggies'),
('carrots','https://spoonacular.com/cdn/ingredients_100x100/carrots.jpg',6.8,'veggies'),
('red onions','https://spoonacular.com/cdn/ingredients_100x100/red-onion.jpg',6.5,'veggies'),
('artichokes','https://spoonacular.com/cdn/ingredients_100x100/artichokes.jpg',5.1,'veggies'),
('bluberries','https://spoonacular.com/cdn/ingredients_100x100/blueberries.jpg',9.7,'fruits'),
('blackberries','https://spoonacular.com/cdn/ingredients_100x100/blackberries.jpg',4.3,'fruits'),
('raspberries','https://spoonacular.com/cdn/ingredients_100x100/raspberries.jpg',5.4,'fruits'),
('strawberries','https://spoonacular.com/cdn/ingredients_100x100/strawberries.jpg',5.7,'fruits'),
('coconut','https://spoonacular.com/cdn/ingredients_100x100/coconut.jpg',6.2,'fruits'),
('avocado','https://spoonacular.com/cdn/ingredients_100x100/avocado.jpg',1.8,'fruits'),
('olives','https://www.healthdiaries.com/eatthis/wp-content/uploads/2012/08/olives-sm.jpg',0.1,'fruits'),
('watermelon','https://spoonacular.com/cdn/ingredients_100x100/watermelon.jpg',7.2,'fruits'),
('cantaloupe','https://spoonacular.com/cdn/ingredients_100x100/cantaloupe.jpg',7.3,'fruits'),
('honeydew','https://www.producemarketguide.com/sites/default/files/Commodities.tar/Commodities/honeydew_commodity-page.png',8.3,'fruits'),
('lemons','https://spoonacular.com/cdn/ingredients_100x100/lemon.jpg',9,'fruits'),
('limes','https://spoonacular.com/cdn/ingredients_100x100/lime.jpg',10,'fruits'),
('cranberries','https://spoonacular.com/cdn/ingredients_100x100/cranberries.jpg',8.4,'fruits'),
('blackcurrants','https://www.endurancesportsnutritionist.co.uk/wp-content/uploads/2019/10/Blackcurrants-300x214.jpg',6.6,'fruits'),
('peach','https://spoonacular.com/cdn/ingredients_100x100/peaches.jpg',8,'fruits'),
('almonds','https://spoonacular.com/cdn/ingredients_100x100/almonds.jpg',2.6,'nuts'),
('macadamias','https://foodtolive.com/wp-content/uploads/2014/02/Organic-Macadamia-Nuts.jpg',1.5,'nuts'),
('hazelnuts','https://spoonacular.com/cdn/ingredients_100x100/hazelnuts.jpg',2,'nuts'),
('brazil nuts','https://spoonacular.com/cdn/ingredients_100x100/brazil-nuts.jpg',1.4,'nuts'),
('pistachios','https://spoonacular.com/cdn/ingredients_100x100/pistachios',5,'nuts'),
('cashews','https://spoonacular.com/cdn/ingredients_100x100/cashews.jpg',7.6,'nuts'),
('pecans','https://spoonacular.com/cdn/ingredients_100x100/pecans.jpg',1.2,'nuts'),
('walnuts','https://spoonacular.com/cdn/ingredients_100x100/walnuts.jpg',2,'nuts'),
('chia seeds','https://spoonacular.com/cdn/ingredients_100x100/chia-seeds.jpg',1.4,'nuts'),
('sunflower seeds','https://spoonacular.com/cdn/ingredients_100x100/sunflower-seeds.jpg',3.2,'seeds'),
('flax seeds','https://spoonacular.com/cdn/ingredients_100x100/flax-seeds.jpg',0.4,'seeds'),
('sesame seeds','https://spoonacular.com/cdn/ingredients_100x100/sesame-seeds.jpg',3.3,'seeds'),
('pumpkin seeds','https://spoonacular.com/cdn/ingredients_100x100/pumpkin-seeds.jpg',1.3,'seeds'),
('pine seeds','https://nuts.com/images/rackcdn/ed910ae2d60f0d25bcb8-80550f96b5feb12604f4f720bfefb46d.ssl.cf1.rackcdn.com/3015_Pine+Nuts_Bowl-RK6ZXdMp-large.jpg',2.7,'seeds'),
('salmon','https://spoonacular.com/cdn/ingredients_100x100/salmon.jpg',0,'healthy fats'),
('sardines','https://images-na.ssl-images-amazon.com/images/I/71HI0NrRxuL._SX425_.jpg',0,'healthy fats'),
('herring','https://upload.wikimedia.org/wikipedia/commons/0/00/Haring_met_ui.jpg',0,'healthy fats'),
('pork','https://balidirectstore.com/wp-content/uploads/2019/10/Free-Range-Pork-Belly.jpg',0,'healthy fats'),
('lamb','https://desikasai.com.au/wp-content/uploads/2019/05/lamb-meat.jpg',0,'healthy fats'),
('beef','https://lh3.googleusercontent.com/proxy/QUNX7NFSG6DH3ijU3_a0DHtBvzP0KDsckg7nIaAu9yMfHYfLSGs7Ut0-FfLolD7Vp7cckhMDD7-fAjaylW2sz_qSFuijCTvT-HhS5RLMfE6_WEGa9yaIATse',0,'healthy fats'),
('duck','https://www.gourmetfoodstore.com/images/Product/large/rougie-flash-frozen-duck-breast-magret-moulard-1S-6177.jpg',0,'healthy fats'),
('butter','https://spoonacular.com/cdn/ingredients_100x100/butter',0,'healthy fats'),
('mayonnaise','https://spoonacular.com/cdn/ingredients_100x100/mayonnaise.jpg',0,'healthy fats'),
('egg yolks','https://spoonacular.com/cdn/ingredients_100x100/egg-yolk.jpg',0,'healthy fats'),
('avocado oil','https://spoonacular.com/cdn/ingredients_100x100/avocado-oil.jpg',0,'healthy oils'),
('olive oil (extra virgin)','https://spoonacular.com/cdn/ingredients_100x100/olive-oil.jpg',0,'healthy oils'),
('red palm oil','https://www.treehugger.com/thmb/E9z-elsd68qyE8JTCWwK6pVtGRU=/530x300/filters:fill(auto,1)/__opt__aboutcom__coeus__resources__content_migration__mnn__images__2013__01__palmoillarge-6f09ef1fc7d2488f8b736a4e1df01320.jpg',0,'healthy oils'),
('lard','https://spoonacular.com/cdn/ingredients_100x100/lard.jpg',0,'healthy oils'),
('almond oil','https://spoonacular.com/cdn/ingredients_100x100/almond-oil.jpg',0,'healthy oils'),
('flaxseed oil','https://spoonacular.com/cdn/ingredients_100x100/flaxseed-oil.jpg',0,'healthy oils'),
('allulose','https://shop.wholesomesweet.com/img/thumbs/whsm-958121.jpg',0,'sweetener'),
('monk fruit','https://images-na.ssl-images-amazon.com/images/I/81Sv8evUcJL._SL1500_.jpg',0,'sweetener'),
('stevia','https://images-na.ssl-images-amazon.com/images/I/610sJ%2BpVB8L._SX425_.jpg',0,'sweetener'),
('erythritol','https://images-na.ssl-images-amazon.com/images/I/91SjiTdl7LL._SL1500_.jpg',5,'sweetener'),
('xylitol','https://focusnutrition.com/wp-content/uploads/2019/06/xylitol-2.jpg',0,'sweetener'),
('chicory root','https://images-na.ssl-images-amazon.com/images/I/71vUAdCXh6L._SL1500_.jpg',0,'sweetener');

