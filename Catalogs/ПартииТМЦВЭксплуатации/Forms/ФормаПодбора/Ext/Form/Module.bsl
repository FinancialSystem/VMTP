﻿&НаСервере
Процедура Расш1_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	Если Параметры.ДополнительныеПараметры.Количество()>0 Тогда
		ОтборДата = КонецДня(Параметры.ДополнительныеПараметры["ДатаДокумента"]);
		ЭтотОбъект.Список.Параметры.УстановитьЗначениеПараметра("Дата", КонецДня(ОтборДата));
		ЭтотОбъект.Список.Параметры.УстановитьЗначениеПараметра("ДатаУстановлена", ЗначениеЗаполнено(ОтборДата)); 
	КонецЕсли;

КонецПроцедуры


