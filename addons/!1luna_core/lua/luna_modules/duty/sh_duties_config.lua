--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

DUTIES_CONFIG = {}

DUTIES_CONFIG.default_map = "rp_arcanatura"

-- Точка в оружейной комнате (здесь получают и сдают оружие)
DUTIES_CONFIG.armory_point = Vector(7249.1225585938, -1012.9505615234, -15206.967773438)

-- Оружие, которое выдается в начале и забирается после патруля
DUTIES_CONFIG.weapon = "masita_dc15a"

----------------------------------------------------------------
-- ПАТРУЛЬ -----------------------------------------------------
----------------------------------------------------------------

-- Награда за патруль (деньги)
DUTIES_CONFIG.patrol_award_money = 550

-- Награда за патруль (опыт)
DUTIES_CONFIG.patrol_award_exp = 200

-- Сколько нужно пройти точек для выполнения
DUTIES_CONFIG.patrol_num_points = 3

-- Время ожидания на каждой точке
DUTIES_CONFIG.patrol_wait = 3

-- Необходимое расстояние от точки до бойца
DUTIES_CONFIG.patrol_point_dist = 150

-- Максимальное количество патрульных
DUTIES_CONFIG.max_patrol_units = 10

DUTIES_CONFIG.patrol_points = {
    Vector(7705.7124023438, -669.07562255859, -15206.967773438),
    Vector(7683.6811523438, -1424.0787353516, -15206.967773438),
    Vector(8596.1650390625, -1445.599609375, -15206.967773438),
    Vector(8585.888671875, -393.44943237305, -15206.967773438),
    Vector(7771.509765625, 54.356540679932, -15446.96875),
    Vector(7826.0307617188, -2088.1103515625, -15573.96875),
    Vector(8455.9033203125, -2134.7937011719, -15573.96875),
    Vector(8552.888671875, -27.557006835938, -15446.96875),
    Vector(8137.3354492188, -2527.3576660156, -15202.96875),
    Vector(9949.4931640625, -4298.25, -15206.967773438),
    Vector(10134.287109375, -2687.3557128906, -14906.96875),
    Vector(8268.8798828125, -1803.5821533203, -14790.96875),
    Vector(7297.8120117188, -843.86083984375, -14790.96875),
    Vector(6722.3759765625, -626.44366455078, -14958.96875),
    Vector(6744.0639648438, 1813.5711669922, -15206.967773438),
    Vector(8124.1030273438, -7508.2241210938, -15078.96875),
    Vector(4772.78515625, -4836.443359375, -15202.96875),
    Vector(7770.89453125, -1346.5706787109, -15446.96875),
    Vector(11674.536132812, -5101.98046875, -15206.967773438),
    Vector(9892.1484375, -6956.7060546875, -15078.96875),

} 

----------------------------------------------------------------
-- ПОСТЫ -------------------------------------------------------
----------------------------------------------------------------

-- Награда за пост (деньги)
DUTIES_CONFIG.station_award_money = 450

-- Награда за пост (опыт)
DUTIES_CONFIG.station_award_exp = 100

-- Время дежурства на посту (в секундах)
DUTIES_CONFIG.station_wait = 400

-- Допустимое время отсутствия на посту
DUTIES_CONFIG.station_leave_time = 30
-- Допустимое время на получение оружия, на выбор поста, на сдачу оружия
DUTIES_CONFIG.station_equip_time = 180

DUTIES_CONFIG.station_points = {
    Vector(8260.6962890625, -1327.2249755859, -15206.967773438),
    Vector(7995.1953125, -1322.5589599609, -15206.967773438),
    Vector(7533.6728515625, -863.95098876953, -15206.967773438),
    Vector(8732.29296875, -500.15502929688, -15206.967773438),
    Vector(9650.0322265625, -678.67321777344, -15207.96875),
    Vector(8128.58984375, -715.66619873047, -15443.96875),
    Vector(8340.666015625, -1947.6989746094, -15206.967773438),
    Vector(7918.82421875, -1942.9954833984, -15206.967773438),
    Vector(8127.033203125, -1962.3377685547, -15573.96875),
    Vector(7918.5854492188, -2232.5852050781, -15573.96875),
    Vector(8342.693359375, -2232.1791992188, -15573.96875),
    Vector(8407.068359375, -1829.8073730469, -14790.96875),
    Vector(10165.208007812, -2815.1267089844, -14906.96875),
    Vector(7343.1259765625, -1401.7796630859, -14790.96875),
    Vector(6772.2583007812, -1875.0565185547, -14958.96875),
    Vector(6652.6547851562, 436.26119995117, -15206.967773438),
    Vector(6851.5151367188, -426.03131103516, -15206.967773438),

}

----------------------------------------------------------------
-- ЛОГИСТИКА ---------------------------------------------------
----------------------------------------------------------------

-- Награда за 1 ящик (деньги)
DUTIES_CONFIG.logistics_award_money = 200

-- Награда за 1 ящик (опыт)
DUTIES_CONFIG.logistics_award_exp = 10

DUTIES_CONFIG.logistics_minimum = 1

DUTIES_CONFIG.storage_points = {
	Vector(9029.376953125, -3968.8947753906, -15206.967773438),
	Vector(4790.4604492188, -2707.8215332031, -15230.96875),
}

DUTIES_CONFIG.drop_points = {
	{Vector(7298.2846679688, -1377.5679931641, -15206.967773438), "Arsenal"},
	{Vector(7029.494140625, 445.01626586914, -15206.967773438), "Jadalnia"},
	{Vector(6563.9995117188, 1150.6768798828, -15205.953125), "Reaktor"},
	{Vector(7052.6079101562, -1204.6019287109, -15446.96875), "Galaktyczny market"},
    
}

DUTY_NONE = 0

DUTY_PATROL_PREPARING = 11 -- Получение оружия
DUTY_PATROL = 12 -- Активная фаза патруля
DUTY_PATROL_FINISH = 13 -- сдача оружия

DUTY_STATION_PREPARING = 21 -- Получение/сдача оружия
DUTY_STATION_CHOOSING = 22 -- Выбор точки поста
DUTY_STATION = 23 -- Активная фаза (стоит на посту)
DUTY_STATION_FINISH = 24 -- Закончил пост

DUTY_LOGISTICS = 31
DUTY_LOGISTICS_CARRY = 32

-- LANG
DUTY_STATUS_TEXTS = {}
DUTY_STATUS_TEXTS[DUTY_PATROL_PREPARING] = "Otrzymanie broni"
DUTY_STATUS_TEXTS[DUTY_PATROL] = "Na patrolu"
DUTY_STATUS_TEXTS[DUTY_PATROL_FINISH] = "Oddanie broni"
DUTY_STATUS_TEXTS[DUTY_STATION_PREPARING] = "Otrzymanie broni"
DUTY_STATUS_TEXTS[DUTY_STATION_CHOOSING] = "Wybór punktu posterunku"
DUTY_STATUS_TEXTS[DUTY_STATION] = "Pełnienie służby na posterunku"
DUTY_STATUS_TEXTS[DUTY_STATION_FINISH] = "Oddanie broni"
DUTY_STATUS_TEXTS[DUTY_LOGISTICS] = "Otrzymanie ładunku"
DUTY_STATUS_TEXTS[DUTY_LOGISTICS_CARRY] = "Przenoszenie ładunku"

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
