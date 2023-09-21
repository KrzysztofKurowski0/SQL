select distinct
 twr_kod [Kod]
,twr_waga [Waga]
,twr_objetoscL [Objętość]
,Atr_Wartosc [Typ towaru]
,Przyczyna = case when 
	(Atr_Wartosc = 'Standardowy' AND twr_waga not BETWEEN 0.000001 AND 12.00)
     OR (Atr_Wartosc = 'Delikatny' AND twr_waga not BETWEEN 0.0000001 AND 6.00)
     OR (Atr_Wartosc = 'Gabarytowy' AND twr_waga not BETWEEN 6.00 AND 120.00)
	 OR (Atr_Wartosc = 'Ciężki' AND twr_waga not BETWEEN 12.00 AND 120.00)
	 OR (Atr_Wartosc = 'Paletowy' AND twr_waga not BETWEEN 30.00 AND 400.00)
	 OR (Atr_Wartosc = 'Pół-paletowy' AND twr_waga not BETWEEN 30.00 AND 200.00)
	 OR (Atr_Wartosc = 'Długi do 2 mb' AND twr_waga not BETWEEN 1.00 AND 30.00)
	 OR (Atr_Wartosc = 'Długi do 3 mb' AND twr_waga not BETWEEN 4.00 AND 30.00)
	 OR (Atr_Wartosc = 'Niestandardowy' AND twr_waga not BETWEEN 6.00 AND 400.00)
	 then 'Waga'
	 else 'Objętość'
	 end
,[Sugerowana zmiana] =
                 (SELECT distinct case when twr_waga BETWEEN 0.000001 AND 12.00 AND case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end between 0.000001 and 500000 then 'Standardowy'
											when twr_waga BETWEEN 0.0000001 AND 6.00 AND case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end between 0.000001 and 500000 then 'Delikatny'
											when twr_waga BETWEEN 6.00 AND 120.00 AND case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end between 500000 and 1500000 then 'Gabarytowy'
											when twr_waga BETWEEN 12.00 AND 120.00 AND case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end between 500000 and 1500000 then 'Ciężki'
											when twr_waga BETWEEN 30.00 AND 400.00 AND case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end between 100000 and 1500000 then 'Paletowy'
											when twr_waga BETWEEN 30.00 AND 200.00 AND case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end between 50000 and 750000 then 'Pół-Paletowy'
											when twr_waga BETWEEN 1.00 AND 30.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end between 1000 and 245000 then 'Długi do 2mb'
											when twr_waga BETWEEN 4.00 AND 30.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end between 2000 and 125000 then 'Długi do 3mb'
											when twr_waga BETWEEN 6.00 AND 400.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end between 1000 and 6000000 then 'Niestandardowy'
											else ''
											end
								FROM cdn.TwrKarty ss
								where sa.Twr_GIDNumer = ss.Twr_GIDNumer)

from cdn.TwrKarty sa
join cdn.Atrybuty on Twr_GIDNumer = Atr_ObiNumer and Atr_OBITyp=16 and Atr_OBILp = 0 and Atr_AtkId = 148 and Atr_Wartosc <> ''--Typ towaru pack
join cdn.TwrZasoby on Twr_GIDNumer=TwZ_TwrNumer
WHERE (
	(Atr_Wartosc = 'Standardowy' AND (twr_waga not BETWEEN 0.000001 AND 12.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end not between 0.000001 and 500000))
     OR (Atr_Wartosc = 'Delikatny' AND (twr_waga not BETWEEN 0.0000001 AND 6.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end not between 0.000001 and 500000))
     OR (Atr_Wartosc = 'Gabarytowy' AND (twr_waga not BETWEEN 6.00 AND 120.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end not between 500000 and 1500000))
	 OR (Atr_Wartosc = 'Ciężki' AND (twr_waga not BETWEEN 12.00 AND 120.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end not between 500000 and 1500000))
	 OR (Atr_Wartosc = 'Paletowy' AND (twr_waga not BETWEEN 30.00 AND 400.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end not between 100000 and 1500000))
	 OR (Atr_Wartosc = 'Pół-paletowy' AND (twr_waga not BETWEEN 30.00 AND 200.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end not between 50000 and 750000))
	 OR (Atr_Wartosc = 'Długi do 2 mb' AND (twr_waga not BETWEEN 1.00 AND 30.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end not between 1000 and 245000))
	 OR (Atr_Wartosc = 'Długi do 3 mb' AND (twr_waga not BETWEEN 4.00 AND 30.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end not between 2000 and 125000))
	 OR (Atr_Wartosc = 'Niestandardowy' AND (twr_waga not BETWEEN 6.00 AND 400.00 OR case when Twr_WymJm = 'm' then twr_objetoscL * 1000000 when Twr_WymJm = 'mm' then twr_objetoscL / 1000 else twr_objetoscL end not between 1000 and 6000000)))

AND Twr_Archiwalny = 0 and Twr_Waga <> 0 and Twr_ObjetoscL <> 0 and TwZ_MagNumer = 1 and TwZ_IlMag <> 0
