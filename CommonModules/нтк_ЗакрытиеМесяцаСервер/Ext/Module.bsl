﻿Процедура Использование_НТК_ЗаполнениеКодовДеятельностиНДС(ПараметрыОбработчика) Экспорт
	ПараметрыРасчета = ПараметрыОбработчика.ПараметрыРасчета;
	
	ЗначениеПараметра = РегистрыСведений.НТК_ДопПараметрыСистемы.нтк_ПолучитьЗначениеПараметраСистемы(Перечисления.НТК_ВидПараметраСистемы.КодДеятельностиНДС,ПараметрыРасчета.ПериодРегистрации);

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("НачалоПериода",НачалоКвартала(ПараметрыРасчета.ПериодРегистрации));
	Запрос.УстановитьПараметр("КонецПериода",КонецКвартала(ПараметрыРасчета.ПериодРегистрации));
	Запрос.УстановитьПараметр("ЗначениеПараметра",ЗначениеПараметра);
	
	Запрос.Текст = "ВЫБРАТЬ
		|	РеализацияТоваровУслуг.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.РеализацияТоваровУслуг.ДополнительныеРеквизиты КАК РеализацияТоваровУслугДополнительныеРеквизиты
		|		ПО РеализацияТоваровУслуг.Ссылка = РеализацияТоваровУслугДополнительныеРеквизиты.Ссылка
		|			И (РеализацияТоваровУслугДополнительныеРеквизиты.Свойство = &ЗначениеПараметра)
		|ГДЕ
		|	РеализацияТоваровУслуг.НалогообложениеНДС = ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПродажаНаЭкспорт)
		|	И РеализацияТоваровУслуг.Проведен
		|	И РеализацияТоваровУслуг.Дата МЕЖДУ &НачалоПериода И &КонецПериода
		|	И (РеализацияТоваровУслугДополнительныеРеквизиты.Значение ЕСТЬ NULL
		|			ИЛИ РеализацияТоваровУслугДополнительныеРеквизиты.Значение = ЗНАЧЕНИЕ(Справочник.нтк_КодыДеятельностиНДС.ПустаяСсылка))";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		
		ЗакрытиеМесяцаСервер.УстановитьСостояниеНеТребуется(ПараметрыОбработчика);
		
	Иначе
		
		
		ТекстПояснения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Требуется выполнить обработку по заполнению кодов деятельности в РТУ (%1 шт.)'"),
			Результат.Выгрузить().Количество());
		
		ЗакрытиеМесяцаСервер.УстановитьСостояниеНеВыполнен(
			ПараметрыОбработчика,
			ТекстПояснения,
			,
			,
			Перечисления.ВариантыВажностиПроблемыСостоянияСистемы.Ошибка);

	КонецЕсли;
	

КонецПроцедуры	