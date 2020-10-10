# vtbhack2020-mobile

Когда на улице возникает порыв «купить такой же автомобиль», как было бы здорово навести камеру на авто – и получить топ-5 вариантов похожих автомобилей и кредитное предложение от ВТБ? Наше приложение позволяет сразу же рассчитать условия по автокредитованию на выбранный автомобиль и подать кредитную заявку «в один клик» через мобильное устройство.

# Возможности 

- Распознавание модели авто при помощи камеры, ML и AR (наведите камеру на понравившуюся машину и появится информация о модели авто, цене и количестве доступных предложений
- Распознавание модели авто по загруженному изображению из галереи (сделайте фото и загрузите его в приложение, чтобы узнать о модели авто, цене и количестве доступных предложений)
- Кредитный калькулятор (потрясите смартфон после распознавания авто и будет выполнен переход в кредитный калькулятор, где можно рассчитать условия по автокредиту)
- График платежей (после расчета условий по кредиту можно получить график платежей прямо в приложении)
- Оформление заявки на автокредит (оформите заявку на автокредит одним кликом после расчета условий и получите одобрение, после чего ожидайте звонок менеджера банка для оформления сделки)
- Раздел "Избранное" (понравившиеся автомобили сохраняются в избранном, для дальнейшей возможности рассчитать кредитные условия)
- Раздел "Маркетплейс" (ищите интересующие вас марки и модели автомобилей в отведенном для этого разделе приложения и рассчитайте кредитные условия по ним)

# Архитектура и стек технологий

**Мобильное приложение** 
- Swift (IOS)
- CoreML (IOS)

Приложение разработано под платформу IOS. Для реализации использовались язык программирования Swift и ядро CoreML. 
Так как мы используем ARkit (для распознавания авто достаточно навести на него камеру), нам потребовалось использование CoreML (Object Detection), чтобы не перегружать "мусором" API Car Recognition (т.е. в API не должны попадать кадры из потока в момент времени когда камера уже включена, но телефон еще не наведен на автомобиль). С помощью CoreML мы детектируем, что телефон наведен на автомобиль и можно делать вызов API Car Recognition. 

**API**

Использовались все предоставленные организаторами API (Car Recognition, Car Loan, Calculator, Marketplace). 

**Дизайн** 

Для отрисовки прототипа и дизайна экранов использовалась Figma. 
Ссылка на макет: 

**Machine Learning**

В рамках хакатона была решена опциональная задача по ML. Подробнее о ее решении рассказывается в отдельном репозитории. 

# Экраны приложений и методы API

## Распознавание модели машины 
Используется **API Car Recognition**, метод <a href="https://developer.hackathon.vtb.ru/vtb/hackathon/product/62/api/8" target="_blank">POST /car-recognize</a>.
На вход передается изображение в base64.</br>
Пример ответа: 
```
Код: 200 OK
Заголовки:
content-type: application/json
x-global-transaction-id: ebeabefd5f7f682100000502
x-ratelimit-limit: name=1persec,1;
x-ratelimit-remaining: name=1persec,0;
{
    "probabilities": {
        "Mazda 6": 0.0437,
        "Mazda 3": 0.0304,
        "Cadillac ESCALADE": 0.0154,
        "Jaguar F-PACE": 0.0028,
        "BMW 5": 0.0068,
        "KIA Sportage": 0.0077,
        "Chevrolet Tahoe": 0.0052,
        "KIA K5": 0.0657,
        "Hyundai Genesis": 0.0181,
        "Toyota Camry": 0.6595,
        "Mercedes A": 0.0576,
        "Land Rover RANGE ROVER VELAR": 0.0481,
        "BMW 3": 0.0122,
        "KIA Optima": 0.0268
    }
}
```
*Нужно подумать над весами (обрабатываем весь массив и по идее ищем максимум)*

## Получение списка предложений
Используется **API Marketplace**, метод <a href="https://developer.hackathon.vtb.ru/vtb/hackathon/product/62/api/9" target="_blank">GET /marketplace</a>. 
Обновляется при загрузке приложения (*возможно lazy loading какой-нибудь сделать, так как первоначально его не используем*)<br>
Пример ответа: 
```
{
    "list": [
        {
            "titleRus": "Кадиллак", 
            "country": {
                "code": "US",
                "id": 1,
                "title": "США"
            },
            "isOutbound": false,
            "alias": "cadillac",
            "logo": "http://tradeins.space/uploads/brand/6/0ec447411c90475a1fa9557d1ad64879347f7036.png",
            "id": 6,
            "title": "Cadillac",
            "absentee": true,
            "currentModelsTotal": 1,
            "currentCarCount": 14,
            "models": [
                {
                    "specmetallicPay": 0,
                    "prefix": "",
                    "bodies": [
                        {
                            "doors": 5,
                            "alias": "offroad",
                            "photo": "https://tradeins.space/uploads/photo/147093/escalade.jpg",
                            "typeTitle": "Внедорожник",
                            "type": "suv",
                            "title": "Внедорожник"
                        }
                    ],
                    "photo": "https://tradeins.space/uploads/photo/147093/escalade.jpg",
                    "title": "ESCALADE",
                    "absentee": false,
                    "titleRus": "Эскалейд",
                    "pearlPay": 0,
                    "alias": "escalade",
                    "renderPhotos": {
                        "main": {
                            "offroad": {
                                "path": "https://tradeins.space/uploads/photo/56923/escalade.jpg",
                                "width": 640,
                                "height": 430
                            }
                        },
                        "render_side": {
                            "offroad": {
                                "path": "https://tradeins.space/uploads/photo/20157/cadillac_esc_200x123.png",
                                "width": 200,
                                "height": 123
                            }
                        },
                        "render_widget_right": {
                            "offroad": {
                                "path": "https://tradeins.space/uploads/photo/147093/escalade.jpg",
                                "width": 960,
                                "height": 540
                            }
                        },
                        "front": {
                            "offroad": {
                                "path": "https://tradeins.space/uploads/photo/56972/silver-coast.jpg",
                                "width": 960,
                                "height": 540
                            }
                        },
                        "side": {
                            "offroad": {
                                "path": "https://tradeins.space/uploads/photo/56973/black-raven.jpg",
                                "width": 960,
                                "height": 540
                            }
                        },
                        "back": {
                            "offroad": {
                                "path": "https://tradeins.space/uploads/photo/56952/radiant-silver.jpg",
                                "width": 960,
                                "height": 540
                            }
                        },
                        "main_left": {
                            "offroad": {
                                "path": "https://tradeins.space/uploads/photo/6871171/6.png",
                                "width": 960,
                                "height": 540
                            }
                        }
                    },
                    "metallicPay": 0,
                    "model": {
                        "titleRus": "Эскалейд",
                        "prefix": "",
                        "alias": "escalade",
                        "id": 2679,
                        "title": "ESCALADE",
                        "absentee": false
                    },
                    "transportType": {
                        "alias": "cars",
                        "id": 1,
                        "title": "Легковые"
                    },
                    "id": 3567,
                    "ownTitle": "IV",
                    "brand": {
                        "titleRus": "Кадиллак",
                        "country": {
                            "code": "US",
                            "id": 1,
                            "title": "США"
                        },
                        "isOutbound": false,
                        "alias": "cadillac",
                        "logo": "http://tradeins.space/uploads/brand/6/0ec447411c90475a1fa9557d1ad64879347f7036.png",
                        "id": 6,
                        "title": "Cadillac",
                        "absentee": false
                    },
                    "minprice": 2733100,
                    "hasSpecialPrice": false,
                    "premiumPriceSpecials": [],
                    "count": 14,
                    "colorsCount": 3,
                    "carId": "n1648837",
                    "sizesPhotos": {
                        "width250": "https://207231.selcdn.ru/locator-media/models_desktop_250_q90/tradeins.space-uploads-photo-107107-larg_1.png"
                    }
                }
            ],
            "generations": []
        }
    ]
}
```

*Для поиска по Marketplace потребуются поля list.title и models.title (так как Car Recognition возвращает названия латиницей).*

**Экран "ARkit/UPLOAD"**

Для вывода на экран понадобятся:
- Марка (list.titleRus)
- Модель (list.models.titleRus)
- Страна-производитель (list.country.title)
- Тип кузова (list.models.bodies.typeTitle)
- Количество предложений (list.currentCarCount)
- Цена "От" (list.models.minprice)
- Есть спецпредложение (list.models.hasSpecialPrice)

**Экран "Кредитный калькулятор"**

Для вывода на экран понадобятся:
- Марка (list.titleRus)
- Модель (list.models.titleRus)
- Тип кузова (list.models.bodies.typeTitle)
- Фото тачки (list.models.bodies.photo)

**Экран "Маркетплейс 1 (список марок)"**

Для вывода на экран понадобятся:
- Логотип (list.logo)
- Марка (list.titleRus)
- Страна-производитель (list.country.title)

**Экран "Маркетплейс 2 (список моделей)"**

Для вывода на экран понадобятся:
- Логотип (list.logo)
- Марка (list.titleRus)
- Фото тачки (list.models.bodies.photo)
- Модель (list.models.titleRus)
- Тип кузова (list.models.bodies.typeTitle)
- Цена "От" (list.models.minprice)
- Количество предложений (list.currentCarCount)

**Экран "Мои авто"**

Для вывода на экран понадобятся:
- Марка (list.titleRus)
- Фото тачки (list.models.bodies.photo)
- Модель (list.models.titleRus)
- Тип кузова (list.models.bodies.typeTitle)
- Цена "От" (list.models.minprice)
- Количество предложений (list.currentCarCount)

*Остальные поля по желанию и если будем успевать*

## Заявка на кредит 
Используется **API Car Loan**, метод <a href="" target="_blank">POST /carloan</a>
Тело запроса:
```
{
  "comment": "Комментарий",
  "customer_party": {
    "email": "apetrovich@example.com",
    "income_amount": 140000,
    "person": {
      "birth_date_time": "1981-11-01",
      "birth_place": "г. Воронеж",
      "family_name": "Иванов",
      "first_name": "Иван",
      "gender": "female",
      "middle_name": "Иванович",
      "nationality_country_code": "RU"
    },
    "phone": "+99999999999"
  },
  "datetime": "2020-10-10T08:15:47Z",
  "interest_rate": 15.7,
  "requested_amount": 300000,
  "requested_term": 36,
  "trade_mark": "Nissan",
  "vehicle_cost": 600000
}
```
**Экран "Оформление заявки на кредит"** 

Заполняем из формы в приложении: 
- Email (customer_party.email)
- ФИО (customer_party.person.family_name, customer_party.person.first_name, customer_party.person.middle_name)
- Дата рождения (customer_party.person.birth_date_time)
- Телефон (customer_party.phone)
- Город (customer_party.birth_place)

Автоматом из предыдущего экрана подтягивается 
- Сколько денег в наличии (customer_party.income_amount) 
- Запрашиваемая сумма (requested_amount) *Высчитываем ПОЛНАЯ СТОИМОСТЬ - СКОЛЬКО ДЕНЕГ В НАЛИЧИИ + СТОИМОСТЬ КАСКО*
- Срок (requested_term) 
- Марка машины (trade_mark)
- Стоимость машины (vehicle_cost)
- Дата заполнения (datetime)
- Ставка (interest_rate) 

Пример ответа: 
```
Код: 200 OK
Заголовки:
content-type: application/json
x-global-transaction-id: ebeabefd5f7f8aee000277f3
{
    "datetime": "2020-10-08T21:55:58+00:00",
    "application": {
        "VTB_client_ID": 5067679726,
        "decision_report": {
            "application_status": "prescore_denied",
            "decision_date": "2020-10-08",
            "decision_end_date": "2021-04-08",
            "comment": "Комментарий",
            "monthly_payment": 8333.333333333334
        }
    }
}
```
Отсюда разбираем:
- Статус заявки (application.decision_report.application_status)
- Комментарий (comment)
- Ежемесячный платеж (monthly_payment)

## Программы кредитования и условия
Для получения списка условий используем **API Calculator**, метод <a href="https://developer.hackathon.vtb.ru/vtb/hackathon/product/62/api/24" target="_blank">GET /settings</a>.
На вход подаем name (Haval) и  language (ru-RU).
Пример ответа: 
```
Код: 200 OK
Заголовки:
content-type: application/json; charset=utf-8
x-global-transaction-id: ebeabefd5f803a3000002a35
{
    "name": "Haval",
    "language": "ru-RU",
    "programs": [
        "d3c2acc2-b91d-4a4e-b8cb-3be3d6d6d383",
        "f0694a0f-25da-48ce-adeb-6dd9009673cc"
    ],
    "clientTypes": [],
    "specialConditions": [
        {
            "name": "КАСКО",
            "language": "ru-RU",
            "excludingConditions": [
                "ba09cad6-c839-437f-98dc-5d2e9b8872ea"
            ],
            "id": "b907b476-5a26-4b25-b9c0-8091e9d5c65f",
            "isChecked": true
        },
        {
            "name": "Страхование жизни",
            "language": "ru-RU",
            "excludingConditions": [],
            "id": "57ba0183-5988-4137-86a6-3d30a4ed8dc9",
            "isChecked": true
        },
        {
            "name": "Я готов предоставить полный пакет документов",
            "language": "ru-RU",
            "excludingConditions": [],
            "id": "cbfc4ef3-af70-4182-8cf6-e73f361d1e68",
            "isChecked": true
        }
    ],
    "variant": {
        "id": "aa0f4c17-da62-4885-b27f-5cde7d12ec44",
        "name": "Лучшая ставка",
        "language": "ru-RU"
    },
    "cost": 2000000,
    "initialFee": 400000,
    "openInNewTab": false,
    "anchor": null,
    "kaskoDefaultValue": null
}
```
## Калькулятор
Для расчета используем **API Calculator**, метод <a href="https://developer.hackathon.vtb.ru/vtb/hackathon/product/62/api/24" target="_blank">POST /calculate</a>. 
Пример запроса:
```
{
  "clientTypes": [
  ],
  "cost": 850000,
  "initialFee": 200000,
  "kaskoValue": null,
  "language": "ru-RU",
  "residualPayment": 77.82549307,
  "settingsName": "Haval",
  "specialConditions": [
    "57ba0183-5988-4137-86a6-3d30a4ed8dc9"
  ],
  "term": 5
}
```

**Экран "Кредитный калькулятор"**
Заполняем из формы в приложении: 
- Первоначальный взнос (initialFee)
- Срок (term)
- Доп. условия (specialConditions)

Автоматически подтягивается:
- Полная стоимость автомобиля (cost)
- КАСКО (kaskoValue - при наличии 20% от стоимости автомобиля) 
- Остаточный платеж (residualPayment = cost - initialFee + kaskoValue)

Пример ответа: 
```
Код: 200 OK
Заголовки:
content-type: application/json; charset=utf-8
x-global-transaction-id: ebeabefd5f803bce0000e201
{
    "program": {
        "id": "d3c2acc2-b91d-4a4e-b8cb-3be3d6d6d383",
        "programName": "Haval",
        "programUrl": "/personal/avtokredity/legkovye-avtomobili/haval/",
        "requestUrl": "//anketa.vtb.ru/avtokredit/",
        "cost": {
            "min": 1500000,
            "max": 10000000,
            "filled": true
        }
    },
    "result": {
        "payment": 14558,
        "term": 5,
        "loanAmount": 650000,
        "residualPayment": null,
        "subsidy": null,
        "contractRate": 12.3,
        "lastPayment": null,
        "kaskoCost": null
    },
    "ranges": {
        "cost": {
            "min": 1000000,
            "max": 10000000,
            "filled": true
        },
        "initialFee": {
            "min": 20,
            "max": 100,
            "filled": true
        },
        "residualPayment": {
            "min": null,
            "max": null,
            "filled": false
        },
        "term": {
            "min": 1,
            "max": 5,
            "filled": true
        }
    }
}
```
**Экран "Расчет платежей"**

Для вывода на экран понадобятся:
- Размер ежемесячного платежа (payment)
- Сумма кредита (loanAmount)
- Ставка (contractRate)
- Срок (term)

## График платежей 
Для получения графика платежей используем **API Calculator**, <a href="https://developer.hackathon.vtb.ru/vtb/hackathon/product/62/api/24" target="_blank">POST /payments-graph</a>. 
Пример запроса: 
```
{
  "contractRate": 1,
  "lastPayment": 10000,
  "loanAmount": 3,
  "payment": 9500,
  "term": 1
}
```

**Экран "Расчет платежей"**

Автоматически подтягивается:
- Размер ежемесячного платежа (payment)
- Остаточный платеж (lastPayment)
- Сумма кредита (loanAmount)
- Ставка (contractRate)
- Срок (term)


Пример ответа:
```
{
    "payments": [
        {
            "order": 1,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 2,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 3,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 4,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 5,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 6,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 7,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 8,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 9,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 10,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 11,
            "percent": 0,
            "debt": 9500,
            "payment": 9500,
            "balanceOut": 0
        },
        {
            "order": 12,
            "percent": 9500,
            "debt": 0,
            "payment": 9500,
            "balanceOut": 0
        }
    ]
}
```

**Экран "Расчет платежей" (всплывашка/pdf)**

Для вывода на экран понадобятся: 
- Номер платежа (order)
- Сумма (payment)
- Долг(debt)
