# vtbhack2020-mobile

# Используемые методы API 

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
Для поиска по Marketplace потребуются поля list.title и models.title (так как Car Recognition возвращает названия латиницей). 
Для вывода на экран понадобятся:
- Марка (list.titleRus)
- Модель (list.models.titleRus)
- Страна-производитель (list.country.title)
- Тип кузова (list.models.bodies.typeTitle)
- Фото тачки (list.models.bodies.photo)
- Количество машин в наличии (list.currentCarCount)
- Логотип (list.logo)
- Минимальная цена (list.models.minprice)
- Есть спецпредложение (list.models.hasSpecialPrice)

*Остальные поля по желанию и если будем успевать

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
Заполняем из формы в приложении: 
- Email (customer_party.email)
- ФИО (customer_party.person.family_name, customer_party.person.first_name, customer_party.person.middle_name)
- Пол (customer_party.person.gender)
- Дата рождения (customer_party.person.birth_date_time)
- Телефон (customer_party.phone)
- Сколько денег в наличии (customer_party.income_amount)
- Запрашиваемая сумма (requested_amount)
- Срок (requested_term)
Поля trade_mark, vehicle_cost, datetime заполняются автоматически. 

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
Для получения списка условий используем **API Calculator**, метод <a href="" target="_blank">GET /settings</a>.
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


