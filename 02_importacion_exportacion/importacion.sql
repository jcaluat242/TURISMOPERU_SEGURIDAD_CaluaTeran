USE [TURISMOPERU_JECT];
GO
IF OBJECT_ID(N'JECT.cliente_importacion', N'U') IS NULL
BEGIN
    CREATE TABLE JECT.cliente_importacion (
        Documento VARCHAR(100) NULL,
        Nombres VARCHAR(200) NULL,
        ApellidoPaterno VARCHAR(200) NULL,
        ApellidoMaterno VARCHAR(200) NULL
    );
END;
GO
SELECT * FROM JECT.cliente_importacion;

SELECT Documento, COUNT(*) AS Repeticiones
FROM JECT.cliente_importacion
GROUP BY Documento
HAVING COUNT(*) > 1;

-- Validación e inserción de los datos de prueba.
USE [TURISMOPERU_JECT];
GO
SET XACT_ABORT ON;

SELECT
    LTRIM(RTRIM(Documento)) AS Documento,
    LTRIM(RTRIM(Nombres)) AS Nombres,
    LTRIM(RTRIM(ApellidoPaterno)) AS ApellidoPaterno,
    LTRIM(RTRIM(REPLACE(ApellidoMaterno, CHAR(13), ''))) AS ApellidoMaterno,
    COUNT(*) OVER (
        PARTITION BY LTRIM(RTRIM(Documento))
    ) AS Repeticiones
INTO #Carga
FROM JECT.cliente_importacion;

-- Mostrar registros rechazados.
SELECT *,
    CASE
        WHEN Repeticiones > 1 THEN 'Documento duplicado en CSV'
        ELSE 'Campos vacíos o longitud inválida'
    END AS Motivo
FROM #Carga
WHERE Repeticiones > 1
   OR NULLIF(Documento, '') IS NULL
   OR LEN(Documento) > 20
   OR NULLIF(Nombres, '') IS NULL OR LEN(Nombres) > 100
   OR NULLIF(ApellidoPaterno, '') IS NULL OR LEN(ApellidoPaterno) > 100
   OR NULLIF(ApellidoMaterno, '') IS NULL OR LEN(ApellidoMaterno) > 100;

DECLARE @Nuevos TABLE (id_persona INT);

BEGIN TRY
    BEGIN TRANSACTION;

    -- Valores de referencia observados para esta prueba:
    -- tipo_persona=N, id_tipo_documento=1, id_nacionalidad=142.
    INSERT INTO JECT.persona (
        tipo_persona, nombres, apaterno, amaterno,
        razon_social, id_tipo_documento,
        numero_documento, id_nacionalidad
    )
    OUTPUT inserted.id_persona INTO @Nuevos
    SELECT
        'N', C.Nombres, C.ApellidoPaterno, C.ApellidoMaterno,
        CONCAT(C.Nombres, ' ', C.ApellidoPaterno, ' ', C.ApellidoMaterno),
        1, C.Documento, 142
    FROM #Carga C
    WHERE C.Repeticiones = 1
      AND LEN(C.Documento) BETWEEN 1 AND 20
      AND LEN(C.Nombres) BETWEEN 1 AND 100
      AND LEN(C.ApellidoPaterno) BETWEEN 1 AND 100
      AND LEN(C.ApellidoMaterno) BETWEEN 1 AND 100
      AND NOT EXISTS (
          SELECT 1 FROM JECT.persona P WITH (UPDLOCK, HOLDLOCK)
          WHERE P.id_tipo_documento = 1
            AND P.numero_documento = C.Documento
      );

    INSERT INTO JECT.cliente (id_persona, fecha_nacimiento)
    SELECT id_persona, NULL FROM @Nuevos;

    COMMIT TRANSACTION;

    SELECT COUNT(*) AS ClientesInsertados FROM @Nuevos;

    SELECT P.id_persona, P.numero_documento, P.nombres
    FROM JECT.persona P
    JOIN JECT.cliente C ON C.id_persona = P.id_persona
    WHERE P.id_persona IN (SELECT id_persona FROM @Nuevos);
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    DROP TABLE #Carga;
    THROW;
END CATCH;

DROP TABLE #Carga;
GO
