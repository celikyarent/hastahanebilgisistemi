# genotip
Alıştırma Serüvenim 

--Select  DOKTOR ,g.ıd, K.DOSYANO , GELISNO , AD +' '+ SOYAD AS ADSOYAD  from GELISLER G 
left outer JOIN KIMLIK K  ON K.DOSYANO = G.DOSYANO
WHERE DOKTOR LIKE 'DR.A.KADİR ŞENSES' 
order by g.ıd
--SELECT COUNT(DOKTOR) FROM GELISLER G 


--SELECT DOKTOR  , ıd,COUNT (ıd) FROM GELISLER G 
WHERE DOKTOR LIKE 'DR.A.KADİR ŞENSES' 
GROUP By DOKTOR  ,ıd
order by ıd


--select COUNT (DISTINCT DOKTOR) from DOKTOR
