/*
=============================================
 Author:		Daniel Arroyo Alvarado
 Proyect:		Imtexa
 Description:	Graba Persona
=============================================
|2|96325874|Loc|LOc|TRE|M|F|987456321|aer@gmail.com|av. porte 586 - surqu|DARROYO
select * from General_Persona
*/

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'paPersonal_Grabar')
BEGIN
	DROP PROCEDURE paPersonal_Grabar
	PRINT 'SP DELETE: paPersonal_Grabar'
END
GO

CREATE PROCEDURE paPersonal_Grabar
(
	@pData VARCHAR(MAX)
)
AS
BEGIN
	Declare @vcSepRegistro varchar(1) = '¬';
	Declare @vcSepCampo varchar(1) = '|';
	Declare @vcSepTabla varchar(1) = '~';

	SET NOCOUNT ON;
	
	Declare @ePost1 INT
	Declare @ePost2 INT
	Declare @ePost3 INT
	Declare @ePost4 INT
	Declare @ePost5 INT
	Declare @ePost6 INT
	Declare @ePost7 INT
	Declare @ePost8 INT
	Declare @ePost9 INT
	Declare @ePost10 INT
	Declare @ePost11 INT

	Declare @eIdPersona			varchar(10)
	Declare @eIdTipoPersona		varchar(1)
	Declare @vDni				varchar(8)
	Declare @vNombre			varchar(100)
	Declare @vApePaterno		varchar(100)
	Declare @vApeMaterno		varchar(100)
	Declare @vSexo				varchar(1)
	Declare @vTelefono			varchar(9)
	Declare @vCorreo			varchar(100)
	Declare @vDireccion			varchar(100)
	Declare @vUsuario			varchar(100)

	Declare @vMensaje			varchar(100)

	SET @pData = LTRIM(RTRIM(@pData))
	SET @ePost1 = CHARINDEX('|',@pData,0)
	SET @eIdPersona = SUBSTRING(@pData,1,@ePost1-1)
	SET @ePost2 = CHARINDEX('|',@pData,@ePost1+1)
	SET @eIdTipoPersona = SUBSTRING(@pData,@ePost1+1,@ePost2-@ePost1-1)
	SET @ePost3 = CHARINDEX('|', @pData, @ePost2+1)
	SET @vDni = SUBSTRING(@pData,@ePost2+1, @ePost3-@ePost2-1)
	SET @ePost4 = CHARINDEX('|', @pData, @ePost3+1)
	SET @vNombre = SUBSTRING(@pData,@ePost3+1, @ePost4-@ePost3-1)
	SET @ePost5 = CHARINDEX('|', @pData, @ePost4+1)
	SET @vApePaterno = SUBSTRING(@pData,@ePost4+1, @ePost4-@ePost3-1)
	SET @ePost6 = CHARINDEX('|', @pData, @ePost5+1)
	SET @vApeMaterno = SUBSTRING(@pData,@ePost5+1, @ePost5-@ePost4-1)
	SET @ePost7 = CHARINDEX('|', @pData, @ePost6+1)
	SET @vSexo = SUBSTRING(@pData,@ePost6+1, @ePost6-@ePost5-1)
	SET @ePost8 = CHARINDEX('|', @pData, @ePost7+1)
	SET @vTelefono = SUBSTRING(@pData,@ePost7+1, @ePost7-@ePost6-1)
	SET @ePost9 = CHARINDEX('|', @pData, @ePost8+1)
	SET @vCorreo = SUBSTRING(@pData,@ePost8+1, @ePost8-@ePost7-1)
	SET @ePost10 = CHARINDEX('|', @pData, @ePost9+1)
	SET @vDireccion = SUBSTRING(@pData,@ePost9+1, @ePost9-@ePost8-1)
	SET @ePost11 = LEN(@pData)
	SET @vUsuario = SUBSTRING(@pData,@ePost10+1,@ePost11-@ePost10)


	IF @eIdPersona = ''
		BEGIN
			IF EXISTS (SELECT eIdPersona FROM General_Persona WHERE LTRIM(RTRIM(vDni)) = LTRIM(RTRIM(@vDni)))
				BEGIN
					SET @vMensaje = 'Duplicado'
					SELECT @vMensaje
					RETURN;
				END
			INSERT INTO General_Persona (eIdCatalogo, vDni, vNombre, vApellidoPaterno, vApellidoMaterno, vSexo, vTelefono, vCorreo, vDireccion, vArchivoFoto, dFechaRegistro, vUsuarioRegistro, vIdPcRegistro, dFechaActualiza, vUsuarioActualiza,vIdPcActualiza,bActivo)
			VALUES(@eIdTipoPersona, @vDni, @vNombre, @vApePaterno, @vApeMaterno, @vSexo, @vTelefono, @vCorreo, @vDireccion, '', GETDATE(), @vUsuario,'',GETDATE(), @vUsuario,'','1')
		END
	ELSE
		BEGIN
		IF EXISTS (SELECT eIdPersona FROM General_Persona WHERE eIdPersona = @eIdPersona AND LTRIM(RTRIM(vDni)) = LTRIM(RTRIM(@vDni)))
				BEGIN
					UPDATE General_Persona
					SET eIdCatalogo			= @eIdTipoPersona,
						vNombre				= @vNombre,
						vApellidoPaterno	= @vApePaterno,
						vApellidoMaterno	= @vApeMaterno,
						vSexo				= @vSexo,
						vTelefono			= @vTelefono,
						vCorreo				= @vCorreo,
						vDireccion			= @vDireccion,
						dFechaActualiza		= GETDATE(),
						vUsuarioActualiza	= @vUsuario
					WHERE eIdPersona = @eIdPersona
				END
		ELSE
			IF EXISTS (SELECT 1 FROM General_Persona WHERE LTRIM(RTRIM(vDni)) = LTRIM(RTRIM(@vDni)))
				BEGIN
					SET @vMensaje = 'Duplicado'
					SELECT @vMensaje
					RETURN;
				END
			ELSE
				BEGIN
					UPDATE General_Persona
					SET vDni		= @vDni,
						vNombre				= @vNombre,
						vApellidoPaterno	= @vApePaterno,
						vApellidoMaterno	= @vApeMaterno,
						vSexo				= @vSexo,
						vTelefono			= @vTelefono,
						vCorreo				= @vCorreo,
						vDireccion			= @vDireccion,
						dFechaActualiza		= GETDATE(),
						vUsuarioActualiza	= @vUsuario
					WHERE eIdPersona = @eIdPersona
				END
		END
END
GO