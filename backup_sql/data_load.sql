INSERT INTO units (name)
VALUES ('g'),
    ('mg'),
    ('µg'),
    ('%');
INSERT INTO nutrients (name, unit_id, daily_value)
VALUES ('Calories', NULL, NULL),
    ('Fat', 1, 78),
    ('Trans Fat', 1, NULL),
    ('Saturated Fat', 1, 20),
    (
        'Mono Unsaturated Fat',
        1, NULL
    ),
    (
        'Poly Unsaturated Fat',
        1, NULL
    ),
    (
        'Cholesterol',
        2, 300
    ),
    (
        'Sodium',
        2, 2300
    ),
    (
        'Carbohydrates',
        1, 275
    ),
    (
        'Net Carbohydrates',
        1, NULL
    ),
    (
        'Fiber',
        1, 28
    ),
    (
        'Sugar',
        1, NULL
    ),
    (
        'Sugar Alcohol',
        1, NULL
    ),
    (
        'Sugar alcohols',
        1, NULL
    ),
        (
        'Sugars',
        1, NULL
    ),
    (
        'Carbs (net)',
        1, NULL
    ),
    (
        'Sugars, added',
        1, 50
    ),
    (
        'Protein',
        1, 50
    ),
    (
        'Caffeine',
        2, NULL
    ),
    (
        'Calcium',
        2, 1300
    ),
    (
        'Magnesium',
        3, 420
    ),
    (
        'Potassium',
        2, 4700
    ),
    (
        'Copper',
        2,0.9
    ),
    (
        'Zinc',
        2, 11
    ),
    (
        'Phosphorus',
        2, 1250
    ),
    (
        'Iron',
        2, 18
    ),
    (
        'Vitamin A',
        3, 900
    ),
    (
        'Vitamin B1',
        3, NULL
    ),
    (
        'Vitamin B2',
        3, NULL
    ),
    (
        'Vitamin B3',
        3, NULL
    ),
    (
        'Vitamin B5',
        3, NULL
    ),
    (
        'Vitamin B6',
        3, 1.7
    ),
    (
        'Vitamin B12',
        3, 2.4
    ),
    (
        'Vitamin C',
        3, 90
    ),
    (
        'Vitamin D',
        3, 20
    ),
    (
       'Vitamin E',
        3, 15
    ),
    (
        'Vitamin K',
        3, 120
    ),
    (
        'Folic Acid',
        3, 400
    ),
    (
        'Selenium',
        3, 55
    ),
    (
        'Choline',
        3, 550
    ),
    (
        'Iodine',
        3, 150
    ),
    (
        'Carbs',
        1, 275
    ),
    (
        'Monounsaturated',
        1, NULL
    ),
    (
        'Polyunsaturated',
        1, NULL
    ),
    (
        'Saturated',
        1, 20
    ),
    (
        'Trans',
        1, NULL
    ),
    (
        'Thiamin (B1)',
        2, 1.2
    ),
    (
        'Riboflavin (B2)',
        2, 1.3
    ),
    (
        'Niacin (B3)',
        2, 16
    ),
    (
        'Folate equivalent (total)',
        2, 400
    )
;


INSERT INTO products (name,image,net_carbs,product_type) VALUES
('spinach','https://spoonacular.com/cdn/ingredients_100x100/spinach.jpg',1.43,'veggies'),
('swiss chard','https://spoonacular.com/cdn/ingredients_100x100/swiss-chard.jpg',2.14,'veggies'),
('celery','https://spoonacular.com/cdn/ingredients_100x100/celery.jpg',1.37,'veggies'),
('kale','https://spoonacular.com/cdn/ingredients_100x100/kale.jpg',8.75,'veggies'),
('broccoli','https://spoonacular.com/cdn/ingredients_100x100/broccoli.jpg',4.04,'veggies'),
('greenbeans','https://spoonacular.com/cdn/ingredients_100x100/green-beans-or-string-beans.jpg',4.27,'veggies'),
('collards','https://spoonacular.com/cdn/ingredients_100x100/collard-greens.jpg',1.42,'veggies'),
('arugula','https://spoonacular.com/cdn/ingredients_100x100/arugula-or-rocket-salad.jpg',2.05,'veggies'),
('lettuce','https://spoonacular.com/cdn/ingredients_100x100/iceberg-lettuce.jpg',1.77,'veggies'),
('watercress','https://spoonacular.com/cdn/ingredients_100x100/watercress.jpg',0.79,'veggies'),
('beet greens','https://spoonacular.com/cdn/ingredients_100x100/beet-leaves.jpg',0.63,'veggies'),
('bok choy','https://spoonacular.com/cdn/ingredients_100x100/bok-choy.jpg',1.18,'veggies'),
('chicory','https://spoonacular.com/cdn/ingredients_100x100/escarole.jpg',0.25,'veggies'),
('green cabbage','https://spoonacular.com/cdn/ingredients_100x100/cabbage.jpg',3.3,'veggies'),
('cauliflower','https://spoonacular.com/cdn/ingredients_100x100/cauliflower.jpg',2.97,'veggies'),
('spring onion','https://spoonacular.com/cdn/ingredients_100x100/spring-onions.jpg',4.74,'veggies'),
('savoy cabbage','https://spoonacular.com/cdn/ingredients_100x100/savoy-cabbage.jpg',3,'veggies'),
('radicchio','https://spoonacular.com/cdn/ingredients_100x100/radicchio.jpg',3.58,'veggies'),
('mizuna','https://spoonacular.com/cdn/ingredients_100x100/mizuna.jpg',1.47,'veggies'),
('red cabbage','https://spoonacular.com/cdn/ingredients_100x100/red-cabbage.png',5.27,'veggies'),
('brussels sprouts','https://spoonacular.com/cdn/ingredients_100x100/brussels-sprouts.jpg',5.15,'veggies'),
('dandelion greens','https://spoonacular.com/cdn/ingredients_100x100/dandelion-greens.jpg',5.7,'veggies'),
('radishes','https://spoonacular.com/cdn/ingredients_100x100/radishes.jpg',1.8,'veggies'),
('mustard greens','https://spoonacular.com/cdn/ingredients_100x100/chinese-mustard-green.jpg',1.47,'veggies'),
('turnip','https://spoonacular.com/cdn/ingredients_100x100/turnips.png',4.63,'veggies'),
('zucchini','https://spoonacular.com/cdn/ingredients_100x100/zucchini.jpg',2.11,'veggies'),
('asparagus','https://cdn.shopify.com/s/files/1/2331/3573/products/asparagus.jpg?v=1505655052',1.78,'veggies'),
('fennel','https://www.gourmetsleuth.com/images/default-source/food/fennel_300-jpg.jpg?sfvrsn=4',4.2,'veggies'),
('eggplant','https://spoonacular.com/cdn/ingredients_100x100/eggplant.png',2.88,'veggies'),
('sugar snap peas','https://spoonacular.com/cdn/ingredients_100x100/sugar-snap-peas.jpg',4.95,'veggies'),
('bell peppers','https://spoonacular.com/cdn/ingredients_100x100/bell-pepper-orange.png',3.93,'veggies'),
('cucumber','https://spoonacular.com/cdn/ingredients_100x100/cucumber.jpg',1.46,'veggies'),
('tomatoes','https://spoonacular.com/cdn/ingredients_100x100/tomato.png',2.69,'veggies'),
('pumpkin','https://spoonacular.com/cdn/ingredients_100x100/pumpkin.png',6,'veggies'),
('butternut squash','https://spoonacular.com/cdn/ingredients_100x100/butternut-squash.jpg',9.69,'veggies'),
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
('hazelnuts','https://image.made-in-china.com/2f0j00GVORTZeKLNoM/Blanched-Roasted-Hazelnuts-Toasted-Hazelnut-Kernels-Inshell-Organic-Hazel-Nuts.jpg',2,'nuts'),
('brazil nuts','https://spoonacular.com/cdn/ingredients_100x100/brazil-nuts.jpg',1.4,'nuts'),
('pistachios','https://spoonacular.com/cdn/ingredients_100x100/pistachios',5,'nuts'),
('cashews','https://spoonacular.com/cdn/ingredients_100x100/cashews.jpg',7.6,'nuts'),
('pecans','https://spoonacular.com/cdn/ingredients_100x100/pecans.jpg',1.2,'nuts'),
('walnuts','https://spoonacular.com/cdn/ingredients_100x100/walnuts.jpg',2,'nuts'),
('chia seeds','https://spoonacular.com/cdn/ingredients_100x100/chia-seeds.jpg',1.4,'seeds'),
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
('beef','https://spoonacular.com/cdn/ingredients_250x250/beef-cubes-raw.png',0,'healthy fats'),
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
('allulose','https://shop.wholesomesweet.com/img/thumbs/whsm-958121.jpg',5,'sweetener'),
('monk fruit','https://images-na.ssl-images-amazon.com/images/I/81Sv8evUcJL._SL1500_.jpg',0,'sweetener'),
('stevia','https://images-na.ssl-images-amazon.com/images/I/610sJ%2BpVB8L._SX425_.jpg',0,'sweetener'),
('erythritol','https://images-na.ssl-images-amazon.com/images/I/91SjiTdl7LL._SL1500_.jpg',0,'sweetener'),
('xylitol','https://focusnutrition.com/wp-content/uploads/2019/06/xylitol-2.jpg',4,'sweetener'),
('chicory root','https://images-na.ssl-images-amazon.com/images/I/71vUAdCXh6L._SL1500_.jpg',5,'sweetener');