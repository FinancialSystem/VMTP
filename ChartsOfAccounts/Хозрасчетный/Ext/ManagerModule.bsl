﻿Функция СчетаСНаборомВыбранныхСубконто(ВидыСубконто, ИсключаемыеСсылки=Неопределено) Экспорт
	
	ТипПараметра = ТипЗнч(ВидыСубконто);
	НесколькоСубконто = ((ТипПараметра = Тип("Массив")
		Или ТипПараметра = Тип("ФиксированныйМассив")
		Или ТипПараметра = Тип("СписокЗначений"))
			И ВидыСубконто.Количество()>1);
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ПланСчетовВидыСубконто.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ Счета
	|ИЗ
	|	ПланСчетов.Хозрасчетный.ВидыСубконто КАК ПланСчетовВидыСубконто
	|ГДЕ
	|	ПланСчетовВидыСубконто.ВидСубконто В(&ВидыСубконто)
	|	И НЕ ПланСчетовВидыСубконто.Ссылка В (&ИсключаемыеСсылки)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПланСчетовВидыСубконто.Ссылка КАК Ссылка
	|ИЗ
	|	Счета КАК Счета
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ПланСчетов.Хозрасчетный.ВидыСубконто КАК ПланСчетовВидыСубконто
	|		ПО Счета.Ссылка = ПланСчетовВидыСубконто.Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	ПланСчетовВидыСубконто.Ссылка
	| ";
	
	Запрос.УстановитьПараметр("КоличествоВидовСубконто", ?(НесколькоСубконто, ВидыСубконто.Количество(), 1));
	Запрос.УстановитьПараметр("ВидыСубконто", ВидыСубконто);
	Запрос.УстановитьПараметр("ИсключаемыеСсылки", ИсключаемыеСсылки);
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции
