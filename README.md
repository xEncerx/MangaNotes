# MangaNotes

MangaNotes - это приложение для поиска и хранения информации о манге. Приложение позволяет пользователям находить мангу, отслеживать свой прогресс чтения и сохранять списки любимых произведений. Реализована синхронизация данных через аккаунт для удобного доступа с разных устройств.

---

## Описание и внешний вид
### Первый запуск приложения
![auth](https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/auth.png)

При первом запуске приложения/выходе из аккаунта необходимо авторизоваться в аккаунт или создать новый.
Данные пользователя хранятся в БазеДанных админа в хэшированном виде.
Если забыл пароль, то его можно восстановить, указав код восстановления, который дается при регистрации.

### Главный экран
![home](https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/main.png)

На главном экране будет показываться список из сохраненных ранее тайтлов. Они разделены на 3 раздела: **Прочитано, Читаю, На будущие**.

### Информация о манге
![manga_info](https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/manga_info.png)

Здесь можно просматривать подробную информацию о тайтле, удалять его, менять статус, переходить к чтению или изменять ссылку.
### История поиска
![history](https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/history.png)

### Результат поиска
![searching](https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/searching.png)

После ввода названия происходит поиск манги на 3 сервисах: Remanga, Shikimori, MangaOVH.
Данные поиска кэшируются, чтобы ускорить поиск. И избежать повторного обращения к api

### Настройки
![settings](https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/settings.png)

---
## Технологии и особенности
- **База данных**: Supabase для хранения данных о манге и пользователях.
- **API**: Данные о манге берутся с сервисов Remanga, Shikimori, MangaOVH.


