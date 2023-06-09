## Задача

В этой лабораторной работе вам предлагается создать приложение, которое будет, используя API, загружать заголовки новостей и показывать их в виде списка. По тапу на новость из списка переходить к просмотру полной информации по выбранной новости.

## Источник данных

В качестве источника данных можно использовать <https://newsapi.org/>

## Основные требования

* **Приложение должно быть написано на Swift. Без использования SwiftUI. Без использования сторонних библиотек/подов.**
* Для UI можно использовать XIB и верстку кодом, не рекомендуется использовать Storyboard.
* Минимальная поддерживаемая версия приложения - iOS 14.
* Загружать не больше 20-ти новостей одномоментно.
* Предусмотреть возможность обновления списка новостей.
* На каждой ячейке должны отображаться:
  * заголовок,
  * картинка,
  * количество просмотров содержимого (переходов на экран деталей новости).
* При нажатии на каждую новость должен открываться новый экран и показывать ее краткое содержимое:
  * заголовок,
  * картинку,
  * описание,
  * дату публикации,
  * источник публикации,
  * кликабельную ссылку на полный текст новости.
* Полный текст новости должен открываться с использованием WebKit.
* Данные о новостях (заголовок, краткое содержание, ссылка на полную версию и тд.) и счетчик просмотров необходимо кэшировать каким-либо образом.
* Закэшированные данные отображаются перед отправлением запроса на обновление данных.
* Закэшированные данные доступны и после перезапуска приложения.

## Что можно улучшить

* Постраничная загрузка всех доступных новостей бесконечной лентой (пагинация по 20 новостей).
* Обновлять список новостей с помощью жеста pull-to-refresh.
* Обработка исключений. Например, отсутствие интернет-соединения.
* Предусмотреть возможность обновления списка новостей.

Скриншоты приложения

<img width="332" alt="image" src="https://user-images.githubusercontent.com/36266447/229368429-d8f9eba1-1b29-4c18-a06c-83891ebedb46.png">
<img width="332" alt="image" src="https://user-images.githubusercontent.com/36266447/229368465-7d72830c-1aa8-4b6d-beaf-4d9ad4f3481f.png">
<img width="332" alt="image" src="https://user-images.githubusercontent.com/36266447/229368472-6c243772-0988-4752-9226-ea30a25d99ad.png">

