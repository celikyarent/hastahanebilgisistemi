SELECT * FROM GELISLER
SELECT * FROM KIMLIK 
SELECT * FROM PARA
SELECT * FROM DOKTOR


--Serpil kullanıcı adı olan kişinin şifresi 
		SELECT * FROM KULLAN 
		WHERE KULLANICIAFI LIKE 'SERPİL%'


---Belirtilen faturaları iptal edebilir misiniz?
--AFT2022000001836
   	UPDATE F  SET  KIME ='İPTAL'
  	 --SELECT EFATURADURUM,*
  	 FROM FATBASLIK F
	WHERE EFATURANO ='AFT2022000001836'

  	 SELECT status, * FROM INVOICE 
   	WHERE InvoiceNo ='AFT2022000001836'
      	UPDATE  INVOICE   SET  STATUS ='1024'

---tarih arasında hasta giriş tutar bilgileri

SELECT P. DOSYANO, P. GELISNO, ADSOTAD = AD + ' ' +SOYAD, TARIH, PAKET, TUR, KOD, ACIKLAMA, TUTAR 
FROM PARA P INNER JOIN KIMLIK K ON P.DOSYANO=K.DOSYANO
WHERE TARIH BETWEEN '2022-05-01' AND '2022-05-18 23:59'

---bilginin belli bir kısmını yazacaksan or mantığı kullanılabilir 
(fıyatadı lıke 'üskü%' or fıyadadı lıke 'xx%') 


--DOKTOR İSMİ DR. İLE BAŞLAYAN HASTALARIN GELİŞ SAYISI 
SELECT  -- COUNT(GELISNO) 
* FROM GELISLER 
 WHERE DOKTOR LIKE 'DR%'
SELECT COUNT(GELISNO) FROM GELISLER G 
WHERE DOKTOR LIKE 'LEVENT%'

--GİRİŞ TARİHİ 11 MAYIS 2022  , DOSYANUMARASI 'GX0000106' olan hastanın 2.gelişinde hangi kurum hangi doktor ve  fiyatı ne olur 


SELECT G.DOSYANO , G.GELISNO, K.AD , K.SOYAD , G.KURUM, G.DOKTOR, TOPLAM = sum(T.TAHSIL) --T.TUR,  --T.ACIKLAMA 
FROM TAHSILAT T 
	INNER JOIN  GELISLER G   ON G.DOSYANO = T.DOSYANO AND G.GELISNO = T.GELISNO
	INNER JOIN KIMLIK K  ON G.DOSYANO = K.DOSYANO
WHERE 
	G.GIRISTARIH >='2022-05-11' AND G.GIRISTARIH <='2022-05-11 23:59'
	AND K.DOSYANO='GX0000106' AND G.GELISNO=2
	GROUP BY  G.DOSYANO , G.GELISNO, K.AD , K.SOYAD , G.KURUM, G.DOKTOR
--ORDER BY T.SIRANO


--- bir hasta geldiği günlerin tüm fiyat tutarlarını acık acık gör.

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

---(AD SOYAD BİRLEŞRTİRME)
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
-- deneme 2  olan işlemadı onko2  olan fiyatlara 10tl ekle 
SELECT F.KOD ,I.ISLEMADI , FIYATADI , katsayı FROM ISLEMLER I
INNER JOIN FIYATLAR F ON  I.KOD = f.KOD
WHERE I.ISLEMADI = 'DENEME İŞLEM-2' and FIYATADI = 'onko-c'


--- Kurumlara göre hasta sayısı
 SELECT   G.KURUM ,COUNT(G.DOSYANO) AS gelıssayısı
   FROM PARA P 
	INNER JOIN  GELISLER G   ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
	INNER JOIN KIMLIK K  ON G.DOSYANO = K.DOSYANO
   GROUP BY G.KURUM, KURUM
	
	
-- Nisan Ve mayıs aylarında gelen 25 yaşında olan   hastaların listesi 
   SELECT G.DOSYANO , G.GELISNO, G.GIRISTARIH, K.AD , K.SOYAD ,  YAS = Year(GETDATE( ) ) - Year ( k.DOGUMTARIH )   , G.KURUM
   FROM GELISLER G   
	INNER JOIN KIMLIK K  ON G.DOSYANO = K.DOSYANO
   WHERE 
	G.GIRISTARIH >='2022-04-01' AND G.GIRISTARIH <='2022-05-31 23:59' AND Year(GETDATE( ) ) - Year ( k.DOGUMTARIH ) = 26

-- Yaş hesaplama

							--Select Adi,Soyadi,Year(GETDATE( ) ) -Year( DogumTarihi ) as Yas from Calisanlar
							--•Year(GETDATE)( ) : Bugünün tarihini alır.
							--•Year(DogumTarihi) : Tabloda olusturduğumuz Doğum Tarihi alır.
							--•as Yas : Çıkan sonucu Yas isimli yeni bir sütuna yazdırdık. 

--25 ve 50 yaşınları arasındaki en çok gelen ilk 10 hasta 
 SELECT TOP 10 
	k.dosyano ,count (G.GELISNO ) AS SAYI ,  k.ad , k.soyad , Year(GETDATE( ) ) - Year ( k.DOGUMTARIH ) 
   FROM  GELISLER G
   INNER JOIN KIMLIK K  ON K.DOSYANO  = G.DOSYANO 
   WHERE Year(GETDATE( ) ) - Year ( k.DOGUMTARIH )  >  25 AND Year(GETDATE( ) ) - Year ( k.DOGUMTARIH ) < 50
  GROUP BY k.dosyano , k.ad , k.soyad , Year(GETDATE( ) ) - Year ( k.DOGUMTARIH ) 
  ORDER BY SAYI DESC 

-- işlem tanımı olup hiç fiyat tanımı yapılmamıl işlemler 
SELECT * FROM ISLEMLER
SELECT * FROM PARA 

SELECT  I.ISLEMADI , TUTAR  from  PARA  P 
  LEFT JOIN ISLEMLER I ON  P.KOD = I.KOD
  WHERE TUTAR IS NULL
   

--- Kurumlara göre hasta sayısı
 SELECT   G.KURUM ,COUNT(G.DOSYANO) AS gelıssayısı
   FROM PARA P 
	INNER JOIN  GELISLER G   ON G.DOSYANO = P.DOSYANO AND G.GELISNO = P.GELISNO
	INNER JOIN KIMLIK K  ON G.DOSYANO = K.DOSYANO
   GROUP BY G.KURUM, KURUM
	
	
	
 --İkinci harfi A olan hastaları listeleyiniz.

  select
      K.AD , K.SOYAD 
  from 
     GELISLER G
   INNER JOIN KIMLIK K  ON K.DOSYANO = G.DOSYANO
 where AD  like '_A%'

--Ogrenci tablosundan Rastgele bir öğrenci seçiniz.

SELECT  top 1  
    AD ,SOYAD , DOGUMTARIH ,  YAS = Year(GETDATE( ) ) - Year (DOGUMTARIH ) , VATANDASLIKNO 
FROM 
    KIMLIK
order by newid()

--Sistemde bulunan ‘B’ kodlu tüm işlemlerin ‘ÜSKÜDAR’ ve ‘KATKIÜSKÜDAR’ fiyatlarını 10 TL yükseltmenizi rica ederim.

SELECT KOD , FIYATADI , YENI = katsayı +10 FROM FIYATLAR
WHERE KOD LIKE 'B%' and FIYATADI IN ('ÜSKÜDAR','KATKIÜSKÜDAR')


--CİNSİYETİ ERKEK olan  en genç öğrenciyi listeyin.

SELECT  TOP 1 
AD ,SOYAD, DOGUMTARIH 
FROM
KIMLIK
WHERE CINSIYET='ERKEK'  and   DOGUMTARIH  IS NOT NULL
ORDER BY  DOGUMTARIH DESC



-- HASTA tablosundaki öğrencilerden adı A, D ve K ile başlayan öğrencileri listeleyiniz.
  SELECT AD, SOYAD from KIMLIK where AD like '[MY]%'



 --KIMLIK  tablosunDA  EBRU TAŞDELEN , LALE KURNAZ , KERİMAN ÇELİK HAKAN MELİKE VE  HATİCE YAYLA isimli HASTALARI  ekleyin.

 SELECT * FROM KIMLIK 
 
INSERT INTO  KIMLIK  (DOSYANO ,AD,SOYAD,CINSIYET) 
       values('Y01','EBRU','TAŞDELEN','KIZ'),('Y02','LALE','KURNAZ','KIZ'),('Y03','KERİMAN','ÇELİK ','KIZ'),('Y04','HAKAN','MELİKE','ERKEK'),('Y05','HATİCE','YAYLA','KIZ')




 --DOSYANO ='Y01' - DOSYANO ='Y05' arasındaki Hastanın  dogum tarihini güncelle.

update KIMLIK set DOGUMTARIH='2020-09-23' where DOSYANO ='Y01'
update KIMLIK set DOGUMTARIH='2020-09-15' where DOSYANO ='Y02'
update KIMLIK set DOGUMTARIH='2020-09-16' where DOSYANO ='Y03'
update KIMLIK set DOGUMTARIH='2020-09-17' where DOSYANO ='Y04'
update KIMLIK set DOGUMTARIH='2020-09-18' where DOSYANO ='Y05'



--GELISI OLMAYAN HASTALARIN LİSTESİ

 
SELECT K.AD ,K.SOYAD , G.GELISNO
FROM  KIMLIK K 
LEFT JOIN  GELISLER G  ON  G.DOSYANO = K.DOSYANO
WHERE  GELISNO  IS NULL 


--ŞUBAT ayında Tedavisi yatarak  olanları  listeleyin.

SELECT K.DOSYANO,  K.AD , K.SOYAD , MONTH(G.GIRISTARIH) AS AY ,G.TEDAVI , G.KURUM FROM GELISLER  G 
INNER JOIN  KIMLIK K on K.DOSYANO = G.DOSYANO
    WHERE   TEDAVI = 'Yatarak'  AND MONTH(G.GIRISTARIH) = 2


--HASTANIN  adını, soyadını ve yaşını listeleyin.

SELECT AD, SOYAD, YAS = DATEDIFF(year,DOGUMTARIH,GETDATE())  from KIMLIK

 --VATANDASLIKNO  null olan öğrencileri listeleyin. (insert sorgusu ile girilen 3 HASTA listelenecektir)

select * from KIMLIK where VATANDASLIKNO is null



 --DOSYANODAN KIMLIK İŞLEMİNİ SİLME 
DELETE FROM  KIMLIK where DOSYANO ='00000105'



--bir hasta aynı doktora kaç kere gelmiş 
select * from kımlık
select * from GELISLER
select * from doktor


--bir DOKTORA kaç kere gelinmiş 

select D.DOKTOR  , COUNT (G.GELISNO) AS GELISSAYISI from GELISLER G
INNER JOIN DOKTOR D ON D.DOKTORKOD = G.DOKTORKOD
GROUP BY D.DOKTOR


--0090098 dosya numarasının 8. Gelişinin 3. Faturasına ATA2022000002182 e-faturanın aktarımının yapılmasını rica ederim.
UPDATE FATBASLIK SET EFATURANO  =  'ATA2022000002182'
WHERE DOSYANO='0090098' AND GELISNO= 8  AND KARTNO = 3  

---1093732 dosya numarasının 20.gelişinin  1. Faturasına ATA2022000000195 eklenmesini rica ederim.

UPDATE FATBASLIK SET EFATURANO  =  'ATA2022000000195'
WHERE DOSYANO='1093732' AND GELISNO= 20  AND KARTNO = 20  ---(geliş no yu  kartno şeklinde yazacaksın )

--DOSYANO BİLİNEn BİR KİŞİNİN TÜM GELİŞLERİ  KARTNO DOSYANOSU göster
SELECT  EFATURANO , DOSYANO ,*  FROM FATBASLIK
WHERE DOSYANO = 'GX0000106'


