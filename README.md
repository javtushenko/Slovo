# slovo

Привет😊  
Приложения написано для личного использования и не претендует на публикацию в AppStore,  
однако есть ссылка на *TestFlight* - https://testflight.apple.com/join/netvilij

![Интерфейс приложения](https://github.com/javtushenko/slovo/blob/origin/MarketingImages/git1.png)

В качестве архитектуры используется VIPER.  
Все сервисы и менеджеры находятся под фасадом DIContainer, и вызываются только в интеракторах.
+ ValetStorage - отвечает за баланс бонусных баллов.  
+ WinStreakStorage - отвечает за хранение информации о серии побед.  
+ KeyboardManager - отвечает за логику кастомной клавиатуры (например при использовании подсказок)  
+ GameBoardStorage - хранит информацию о наличии букв, цвете бэкграунда ячеек с кнопками.
![Общая архитектура](https://github.com/javtushenko/slovo/blob/origin/MarketingImages/git2.png)
