USE [CDNXL_TESTOWA_2014]
GO
/****** Object:  Trigger [CDN].[Gaska_KntKarty_WymuszajTylkoCyfryWNumerachTelefonu]    Script Date: 2023.05.11 15:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [CDN].[Gaska_KntKarty_WymuszajTylkoCyfryWNumerachTelefonu]
   ON  [CDN].[KntKarty] 
   AFTER update, insert
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;
if update (Knt_Telefon1) -- Jeśli update Pola Telefon1
begin

if ISNUMERIC((select knt_telefon1 as telefon from inserted)) = 0 and (select knt_telefon1 as telefon from inserted) <> ''  -- Jeśli wpisany ciag znaków nie jest liczbą
begin
	declare @komunikat1 varchar(1000)
    set @komunikat1='#CDN_BLAD/# #CDN_1=Pole Telefon może zawierać tylko cyfry! '  + '#CDN_2=(Blokada założona przez dział IT) /# #CDN_3=Brak/#'
    RAISERROR(@komunikat1,16,1)
    rollback tran
    return
END
END

if update (Knt_Telefon2) -- Jeśli update Pola Telefon2
begin

if ISNUMERIC((select knt_telefon2 as telefon from inserted)) = 0 and (select knt_telefon2 as telefon from inserted) <> ''  -- Jeśli wpisany ciag znaków nie jest liczbą
begin
	declare @komunikat2 varchar(1000)
    set @komunikat2='#CDN_BLAD/# #CDN_1=Pole Telefon może zawierać tylko cyfry! '  + '#CDN_2=(Blokada założona przez dział IT) /# #CDN_3=Brak/#'
    RAISERROR(@komunikat2,16,1)
    rollback tran
    return 
END
END

if update (Knt_Email) --Jeśli update Emaila
begin

if (select knt_email from inserted) like ('%;%') --Jeśli email ma w sobie ;
begin
	declare @komunikat3 varchar(1000)
    set @komunikat3='#CDN_BLAD/# #CDN_1=Możesz wpisać tylko 1 adres E-mail! '  + '#CDN_2=(Blokada założona przez dział IT) /# #CDN_3=Brak/#'
    RAISERROR(@komunikat3,16,1)
    rollback tran
    return 

END
END
END
