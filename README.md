# vtbhack2020-mobile

Когда на улице возникает порыв «купить такой же автомобиль», как было бы здорово навести камеру на авто – и получить топ-5 вариантов похожих автомобилей и кредитное предложение от ВТБ? Наше приложение позволяет сразу же рассчитать условия по автокредитованию на выбранный автомобиль и подать кредитную заявку «в один клик» через мобильное устройство.

# Возможности 

Основной флоу:
<div display="inline">
<img src="https://github.com/IBISolutions/vtbhack2020-ml/blob/main/img/Мокап1.png" width="150px">
<img src="https://github.com/IBISolutions/vtbhack2020-ml/blob/main/img/Мокап2.png" width="150px">
<img src="https://github.com/IBISolutions/vtbhack2020-ml/blob/main/img/Мокап3.png" width="150px">
<img src="https://github.com/IBISolutions/vtbhack2020-ml/blob/main/img/Мокап4.png" width="150px">
<img src="https://github.com/IBISolutions/vtbhack2020-ml/blob/main/img/Мокап5.png" width="150px">
</div>
- Распознавание модели авто при помощи камеры, ML и AR (наведите камеру на понравившуюся машину и появится информация о модели авто, цене и количестве доступных предложений <br>
- Распознавание модели авто по загруженному изображению из галереи (сделайте фото и загрузите его в приложение, чтобы узнать о модели авто, цене и количестве доступных предложений) <br>
- Кредитный калькулятор (потрясите смартфон после распознавания авто и будет выполнен переход в кредитный калькулятор, где можно рассчитать условия по автокредиту) <br>
- График платежей (после расчета условий по кредиту можно получить график платежей прямо в приложении) <br>
- Оформление заявки на автокредит (оформите заявку на автокредит одним кликом после расчета условий и получите одобрение, после чего ожидайте звонок менеджера банка для оформления сделки) <br>

Дополнительно:
<div display="inline">
<img src="https://github.com/IBISolutions/vtbhack2020-ml/blob/main/img/Мокап6.png" width="150px">
<img src="https://github.com/IBISolutions/vtbhack2020-ml/blob/main/img/Мокап7.png" width="150px">
<img src="https://github.com/IBISolutions/vtbhack2020-ml/blob/main/img/Мокап8.png" width="150px">
</div>
- Раздел "Избранное" (понравившиеся автомобили сохраняются в избранном, для дальнейшей возможности рассчитать кредитные условия) <br>
- Раздел "Маркетплейс" (ищите интересующие вас марки и модели автомобилей в отведенном для этого разделе приложения и рассчитайте кредитные условия по ним) <br>

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
Ссылка на макет. 

**Machine Learning**

В рамках хакатона была решена опциональная задача по ML. Подробнее о ее решении рассказывается в <a hreg="https://github.com/IBISolutions/vtbhack2020-ml" target="_blank">отдельном репозитории</a>. 

# Экраны приложений и методы API

## Распознавание модели машины 
Используется **API Car Recognition**, метод <a href="https://developer.hackathon.vtb.ru/vtb/hackathon/product/62/api/8" target="_blank">POST /car-recognize</a>.
На вход передается изображение в base64.</br>


## Получение списка предложений
Используется **API Marketplace**, метод <a href="https://developer.hackathon.vtb.ru/vtb/hackathon/product/62/api/9" target="_blank">GET /marketplace</a>. 
Обновляется при загрузке приложения.<br>

*Для поиска по Marketplace потребуются поля list.title и models.title (так как Car Recognition возвращает названия латиницей).*

**Экран "ARkit/UPLOAD"**

Для вывода на экран понадобятся:
- Марка (list.titleRus)
- Модель (list.models.titleRus)
- Страна-производитель (list.country.title)
- Тип кузова (list.models.bodies.typeTitle)
- Количество предложений (list.currentCarCount)
- Цена "От" (list.models.minPrice)
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

*Обработка остальныз полей предусмотрена в дальнейшей разработке*

## Заявка на кредит 
Используется **API Car Loan**, метод <a href="" target="_blank">POST /carloan</a>

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

Из ответа разбираем:
- Статус заявки (application.decision_report.application_status)
- Комментарий (comment)
- Ежемесячный платеж (monthly_payment)

## Программы кредитования и условия
Для получения списка условий используем **API Calculator**, метод <a href="https://developer.hackathon.vtb.ru/vtb/hackathon/product/62/api/24" target="_blank">GET /settings</a>.
На вход подаем name (Haval) и  language (ru-RU). В ответе нас интересует раздел "specialConditions". 

## Калькулятор
Для расчета используем **API Calculator**, метод <a href="https://developer.hackathon.vtb.ru/vtb/hackathon/product/62/api/24" target="_blank">POST /calculate</a>. 

**Экран "Кредитный калькулятор"**
Заполняем из формы в приложении: 
- Первоначальный взнос (initialFee)
- Срок (term)
- Доп. условия (specialConditions)

Автоматически подтягивается:
- Полная стоимость автомобиля (cost)
- КАСКО (kaskoValue - при наличии 20% от стоимости автомобиля) 
- Остаточный платеж (residualPayment = cost - initialFee + kaskoValue)

**Экран "Расчет платежей"**

Для вывода на экран понадобятся:
- Размер ежемесячного платежа (payment)
- Сумма кредита (loanAmount)
- Ставка (contractRate)
- Срок (term)

## График платежей 
Для получения графика платежей используем **API Calculator**, <a href="https://developer.hackathon.vtb.ru/vtb/hackathon/product/62/api/24" target="_blank">POST /payments-graph</a>. 

**Экран "Расчет платежей"**

Автоматически подтягивается:
- Размер ежемесячного платежа (payment)
- Остаточный платеж (lastPayment)
- Сумма кредита (loanAmount)
- Ставка (contractRate)
- Срок (term)

**Экран "Расчет платежей" (всплывашка)**

Для вывода на экран понадобятся: 
- Номер платежа (order)
- Сумма (payment)
- Долг(debt)

# Команда 

Наша команда: 
- Иван Федоров (Product Owner )
- Виктор Волков (IOS Developer)
- Сергей Кудрявцев (Machine Learning)
- Наталья Федорова (Design)
