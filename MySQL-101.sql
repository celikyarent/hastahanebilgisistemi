SELECT * FROM GELISLER
SELECT * FROM KIMLIK 
SELECT * FROM PARA
SELECT * FROM DOKTOR

SELECT G.DOSYANO , G.GELISNO, K.AD , K.SOYAD , G.KURUM, D.DOKTOR, Y = SUM(P.TUTAR)   --P.ACIKLAMA
FROM PARA P 
	INNER JOIN  GELISLER G   ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
	INNER JOIN KIMLIK K  ON G.DOSYANO = K.DOSYANO
	INNER JOIN DOKTOR D ON G.DOKTORKOD=D.DOKTORKOD
WHERE 
	G.GIRISTARIH >='2022-05-11' AND G.GIRISTARIH <='2022-05-11 23:59'
	AND K.DOSYANO='GX0000106' AND G.GELISNO=2
GROUP BY G.DOSYANO , G.GELISNO, K.AD , K.SOYAD , G.KURUM, D.DOKTOR
--ORDER BY P.SIRANO



SELECT G.DOSYANO , G.GELISNO, K.AD , K.SOYAD , G.KURUM, G.DOKTOR, TOPLAM = sum(T.TAHSIL) --T.TUR,  --T.ACIKLAMA 
FROM TAHSILAT T 
	INNER JOIN  GELISLER G   ON G.DOSYANO = T.DOSYANO AND G.GELISNO = T.GELISNO
	INNER JOIN KIMLIK K  ON G.DOSYANO = K.DOSYANO
WHERE 
	G.GIRISTARIH >='2022-05-11' AND G.GIRISTARIH <='2022-05-11 23:59'
	AND K.DOSYANO='GX0000106' AND G.GELISNO=2
	GROUP BY  G.DOSYANO , G.GELISNO, K.AD , K.SOYAD , G.KURUM, G.DOKTOR
--ORDER BY T.SIRANO



SELECT G.DOSYANO , G.GELISNO, K.AD , K.SOYAD , G.KURUM, D.DOKTOR, GELISDOKTORKOD=G.DOKTORKOD,P.DR,P.DR2 ,  P.ACIKLAMA, YAPANDR = D1.DOKTOR 
FROM PARA P 
	INNER JOIN  GELISLER G   ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
	INNER JOIN KIMLIK K  ON G.DOSYANO = K.DOSYANO
	left JOIN Doktor D1 ON D1.DOKTORKOD = P.DR2
	LEFT JOIN DOKTOR D ON G.DOKTORKOD=D.DOKTORKOD
WHERE 
	G.GIRISTARIH >='2022-05-11' AND G.GIRISTARIH <='2022-05-11 23:59'
	AND K.DOSYANO='GX0000106' AND G.GELISNO=2
ORDER BY P.SIRANO





SELECT  *  from DOKTOR
SELECT  *  from GELISLER 
SELECT  *  from PARA
SELECT  *  from FATBASLIK
SELECT  *  from KIMLIK
SELECT  *  from TAHSILAT


SELECT  G.DOSYANO , G.GELISNO , KURUM , TUR , ACIKLAMA 
 from PARA P
   INNER JOIN GELISLER G ON  G.DOSYANO = P.DOSYANO 
WHERE TUR = 'MUA'


Select T.SIRANO , K.DOSYANO , P.GELISNO , AD +' '+ SOYAD AS ADSOYAD , P.ACIKLAMA  , P.TUR , KURUM , G.SUBE
 from PARA P
   INNER JOIN GELISLER G ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
   INNER JOIN KIMLIK K ON P.DOSYANO = K.DOSYANO
   INNER JOIN TAHSILAT T ON T.TAHSIL = P.TAHSILAT 
WHERE P.TUR = 'MUA' AND KURUM = 'SSK'


Select SIRANO , K.DOSYANO , GELISNO , AD +' '+ SOYAD AS ADSOYAD , ACIKLAMA , TUR 
  from PARA P
   INNER JOIN KIMLIK K ON P.DOSYANO = K.DOSYANO
WHERE ACIKLAMA LIKE '%hemogram%' and TUR = 'LAB'
ORDER By SIRANO


Select SIRANO , K.DOSYANO , P.GELISNO , AD +' '+ SOYAD AS ADSOYAD , ACIKLAMA  , TUR , KURUM 
from PARA P
	INNER JOIN KIMLIK K ON P.DOSYANO = K.DOSYANO
	INNER JOIN GELISLER G ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
WHERE TUR = 'MUA' AND  NOT KURUM ='SSK'


--HASTA ADI Ü İLE BAŞLAYAN HASTALARIN GELİŞ SAYISI

Select  K.DOSYANO , P.GELISNO , AD , SOYAD , TOP 
from PARA P
    INNER JOIN GELISLER G ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
	INNER JOIN KIMLIK K ON P.DOSYANO = K.DOSYANO
WHERE AD LIKE 'Ü%' 
GROUP BY K.DOSYANO , AD , SOYAD 



--Tür MUA  
Select SIRANO , K.DOSYANO , P.GELISNO , AD +' '+ SOYAD AS ADSOYAD , ACIKLAMA  , TUR , KURUM  from PARA P
INNER JOIN KIMLIK K ON P.DOSYANO = K.DOSYANO
INNER JOIN GELISLER G ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
WHERE TUR = 'MUA' 



Select  K.DOSYANO , P.GELISNO , AD +' '+ SOYAD AS ADSOYAD , ACIKLAMA  , TUR , KURUM , GIRISTARIH from PARA P
INNER JOIN KIMLIK K ON P.DOSYANO = K.DOSYANO
INNER JOIN GELISLER G ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
WHERE TUR = 'Lab'

SELECT  *  from KULLAN
SELECT  *  from KULLANSUBELERI


SELECT  ISLEMYAPABILIR  , K.KULLANICIADI , SIFRE , sube , GRUP from KULLAN K
INNER JOIN KULLANSUBELERI KS ON KS.KULLANICIADI =K.KULLANICIADI
WHERE ISLEMYAPABILIR = 0 


--kımlık kaydı olup geliş kaydı olmayan hastaların listesi

SELECT  G.DOSYANO , AD ,SOYAD , GELISNO from  KIMLIK K 
  LEFT JOIN GELISLER G ON  K.DOSYANO = G.DOSYANO
  WHERE G.DOSYANO IS NULL
  
  --HASTA ADI Ü İLE BAŞLAYAN HASTALARIN GELİŞ SAYISI

Select  G.DOSYANO,AD , SOYAD ,MAX(G.GELISNO)
from GELISLER G INNER JOIN KIMLIK K ON G.DOSYANO = K.DOSYANO
WHERE AD LIKE 'Ü%' 
GROUP BY  G.DOSYANO, AD , SOYAD 

--
SELECT  *  FROM ISLEMLER
SELECT  * from FIYATLAR


--

SELECT F.KOD ,I.ISLEMADI , FIYATADI , katsayı FROM ISLEMLER I
INNER JOIN FIYATLAR F ON  I.KOD = f.KOD
WHERE I.ISLEMADI = 'DENEME İŞLEM-2' and FIYATADI = 'onko-c'


Sorular 
1. Nisan Ve mayıs aylarında 25 yaşında olan   hastaların listesi 
   SELECT G.DOSYANO , G.GELISNO, K.AD , K.SOYAD , CONVERT(INT,GETDATE()-'1997-01-01')/365 AS YAS , G.KURUM,  P.ACIKLAMA 
   FROM PARA P 
	INNER JOIN  GELISLER G   ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
	INNER JOIN KIMLIK K  ON G.DOSYANO = K.DOSYANO
	left JOIN Doktor D1 ON D1.DOKTORKOD = P.DR2
     WHERE 
	G.GIRISTARIH >='2022-04-01' AND G.GIRISTARIH <='2022-05-31 23:59' 

2. 25 ve 50 yaşınları arasındaki en çok gelen ilk 10 hasta 


3. işlem tanımı olup hiç fiyat tanımı yapılmamıl işlemler 
4. Kurumlara göre hasta sayısı

 SELECT  count (G.ID ) AS gelıssayısı,  K.AD , K.SOYAD , G.KURUM
   FROM PARA P 
	INNER JOIN  GELISLER G   ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
	INNER JOIN KIMLIK K  ON G.DOSYANO = K.DOSYANO
	left JOIN Doktor D1 ON D1.DOKTORKOD = P.DR2 

	GROUP BY G.DOSYANO  , K.AD , K.SOYAD ,  G.KURUM,  P.ACIKLAMA 
	orde




	

-- Kurumlara göre hasta sayısı

