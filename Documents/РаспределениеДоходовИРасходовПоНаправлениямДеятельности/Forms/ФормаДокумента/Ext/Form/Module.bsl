﻿
&НаКлиенте
Процедура Расш1_РасходыАналитикаРасходовНачалоВыбораПосле(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтрокаТаблицы = Элементы.Расходы.ТекущиеДанные;
	СтатьяРасходов = СтрокаТаблицы.СтатьяРасходов;
	ПартииТМЦ = Расш1_ОпределениеТипаАналитики.Расш1_ОпределениеТипаАналитикиНаСервере(СтатьяРасходов);
	Если ПартииТМЦ Тогда
		СтандартнаяОбработка = Ложь;
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("ДатаДокумента",Объект.Дата);
		ПараметрыПодбора = Новый Структура("ЗакрыватьПриВыборе, МножественныйВыбор,РежимВыбора, ДополнительныеПараметры", Истина, Ложь, Истина, ДополнительныеПараметры);
		ОткрытьФорму("Справочник.ПартииТМЦВЭксплуатации.Форма.ФормаПодбора", ПараметрыПодбора, ЭтаФорма);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Расш1_ОбработкаВыбораПосле(ВыбранноеЗначение, ИсточникВыбора)
	
	СтрокаТаблицы = Элементы.Расходы.ТекущиеДанные;
	Если ТипЗнч(ВыбранноеЗначение) = Тип("ФиксированныйМассив") Тогда
		СтандартнаяОбработка = Ложь;
		Для Каждого Значение ИЗ ВыбранноеЗначение Цикл
			ЗаполнитьЗначенияСвойств(СтрокаТаблицы, Значение);
			СтрокаТаблицы.АналитикаРасходов = Значение.ПартияТМЦВЭксплуатации;
		КонецЦикла;
		Модифицированность = Истина;
	КонецЕсли;

КонецПроцедуры
