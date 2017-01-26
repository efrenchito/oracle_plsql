CREATE OR REPLACE PACKAGE "XXMU_DEV_REPORT_PK" AS
 --=================================================================
  --PROCEDIMIENTO
  --Almacena el inventario diario para la organizaci?n de inventario
  --Par?tros:
  --   errbuf: Control de ejecuci?n
  --   errcode: Control de error
  --   p_organization_code: Lista de unidades de Inventario a consultar (BODEGAS)
  --
  --Retorno:
    --errbuf: Control de ejecuci?n
    --errcode: Control de error
    --p_organization_code: C?digos de Unidades Operativas
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A.
  --Fecha de Creaci?n: 25-03-2008
  --
  --Actualizado en:
    --1: 30-04-2008
      --Se adiciona la conversi?n para CM3 calculandola a partir de las dimensiones
  PROCEDURE DEV_INVENTORY_ONHAND(
    errbuf      OUT NOCOPY VARCHAR2,
    errcode     OUT NOCOPY VARCHAR2,
    p_organization_code IN VARCHAR2
  );


--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Almacena el inventario a mano de los items en consignaci?n
  --Par?tros:
    --errbuf: Control de Ejecuci?n
    --errocode: Control de error
    --p_organization_code: C?digos de Unidades Operativas
    --p_is_consigned: Par?tro de estado en consignaci?n
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A
  --Fecha Creaci?n: 14-05-2008
  --
  --Actualizado en:
    --1:  28-01-2009
      --Modificaci?n en el Procedimiento y en tabla destino
  PROCEDURE DEV_INVENTORY_ONHAND_CONSIGN(
    errbuf OUT NOCOPY VARCHAR2,
    errcode OUT NOCOPY VARCHAR2
  );
--=================================================================
  --FUNCION
  --Realiza la conversi?n entre unidades de medida de un articulo
  --Par?tros:
  --   P_FROM_UOM: Unidad de Medida en la que se encuentra el articulo
  --   P_TO_UOM: Unidad de Medida a la que se desea llevar
  --   P_ITEM_ID: Id del articulo a procesar
  --
  --Retorno: X_CONVERT
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A.
  --Fecha de Creaci?n: 03-04-2008
  --
  --Actualizado en:
    --1:  24-04-2008
      -- Se adiciona el retorno en (X_CONVERT = 0) cuando no se encuntra la tasa de conversi?n


  FUNCTION CONVERT_UOM_ITEM (
    P_FROM_UNIT IN VARCHAR2
    ,P_TO_UNIT IN VARCHAR2
    ,P_ITEM_ID IN NUMBER
  ) RETURN NUMBER;

  --====================================================
--SOLO LAS TASAS DE CONVERSION PRINCIPALES DE ORACLE
  FUNCTION CONVERT_UOM_ITEM_SYS (
    P_FROM_UNIT IN VARCHAR2
    ,P_TO_UNIT IN VARCHAR2
    ,P_ITEM_ID IN NUMBER
  ) RETURN NUMBER;

--=================================================================
  --FUNCION
  --Determina si un String es Tipo N?mero
  --Par?tros:
  --   P_STRING: Cadena de caracteres
  --
  --Retorno: X_NUMBER
  --
  --Autor: Tomada de Internet - Pagina WEB  http://www.psoug.org/reference/functions.html
  --Fecha de Creaci?n: 23-07-2008
  --
  --Actualizado en:

  FUNCTION DEV_ISNUMBER(
    P_STRING IN VARCHAR2
  ) RETURN NUMBER;


--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Proceso que selecciona la fecha inicial para un periodo de aviso de consumos
  -- (emplea los datos almacenados en la tabla de control "bolinf.dev_control_aviso_consumo". Esta tabla almacena los datos de la ejecuci?n del concurrente de "Creaci?n de Aviso de Consumo" y sus par?tros)
  --Par?tros:
    --p_request_id: Id de ejecuci?n del concurrente actual de Aviso de Consumo
    --p_actual_completion_date: Fecha de ejecuci?n del concurrente actual de Aviso de Consumo
    --p_po_header_id: Id del acuerdo de compra
    --p_po_line_id: Id de la l?a del acuerdo de compra
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A
  --Fecha Creaci?n: 05-11-2008
  --
  --Actualizado en:
    --

  PROCEDURE DEV_FECHA_INICIO_AVISO_CONSUMO
  (
    p_request_id IN NUMBER
    ,p_actual_completion_date IN DATE
    ,p_po_header_id IN NUMBER
    ,p_po_line_id IN NUMBER
    ,x_request_id OUT NUMBER
    ,x_last_completion_date OUT DATE
    ,x_errcode OUT NOCOPY VARCHAR2
  );

--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Proceso que monitorea la ejecuci?n del concurrente de aviso de consumos y almacena los consumos, recepciones, fechas de ejecuci?n e inventario de los art?los en consignaci?n
  --Par?tros:
    --errbuf: Control de Ejecuci?n
    --errocode: Control de error
    --p_concurrent_program_name: Abreviatura del Ejecutable de Aviso de Consumo (INVCTXNM)
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A
  --Fecha Creaci?n: 05-11-2008
  --
  --Actualizado en:
    --

  PROCEDURE DEV_GUARDAR_AVISOS_DE_CONSUMO(
    errbuf OUT NOCOPY VARCHAR2
    ,errcode OUT NOCOPY VARCHAR2
    ,p_concurrent_program_name IN VARCHAR2
  );

--=================================================================
--=================================================================
  --FUNCION
  --Valida los permisos de acceso en los Libros Contables
  --Par?tros:
  --   P_LEDGER_ID: Id del libro contable
  --
  --Retorno: X_ACCESS
  --
  --Autor: Ricardo Orozco Agudelo
  --Fecha de Creaci?n: 15-12-2008
  --
  --Actualizado en:

  FUNCTION DEV_LEDGER_ACCESS(
    P_LEDGER_ID IN NUMBER
    , P_LEDGER_GROUP IN VARCHAR2 DEFAULT 'N'
  ) RETURN CHAR;

--=================================================================
--=================================================================
  --FUNCION
  --Valida los permisos de acceso en las Unidades Operativas
  --Par?tros:
  --   P_ORG_ID: Id de la Unidad Operativa
  --
  --Retorno: X_ACCESS
  --
  --Autor: Ricardo Orozco Agudelo
  --Fecha de Creaci?n: 15-12-2008
  --
  --Actualizado en:

  FUNCTION DEV_ORG_ACCESS(
    P_ORG_ID IN NUMBER
  ) RETURN CHAR;

--=================================================================
--=================================================================
  --FUNCION
  --Valida si la responsabilidad tienen acceso total en las funciones de vaildaci?n de Acceso
  --Par?tros:
  --
  --Retorno: X_ALL_ACCESS
  --
  --Autor: Ricardo Orozco Agudelo
  --Fecha de Creaci?n: 16-12-2008
  --
  --Actualizado en:

  FUNCTION DEV_ALL_ACCESS(P_RESP_APPL_ID IN NUMBER
    , P_RESP_ID IN NUMBER
  ) RETURN CHAR;

--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Procedimiento para generar el reporte de contabilidad detallada por art?lo
  --Par?tros:
    --errbuf: Control de Ejecuci?n
    --errocode: Control de error
    --
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A
  --Fecha Creaci?n: 19-12-2008
  --
  --Actualizado en:
    --1: 06-01-2009
      --Se crearon los cursores por art?lo y libro contable
    --2: 04_02_2009
      --Se elimina la tabla "xla_acct_line_types_fvl" por duplicidad de registros

  PROCEDURE DEV_CONTABILIDAD_DET_ITEM(
    errbuf      OUT NOCOPY VARCHAR2
    , errcode     OUT NOCOPY VARCHAR2
    , p_ledger_name IN VARCHAR2
    , p_gl_organization_code IN VARCHAR2
    , p_item_code IN VARCHAR2
    , p_start_date IN VARCHAR2
    , p_end_date IN VARCHAR2
  );

--=================================================================
--=================================================================
  --FUNCION
  --Valida los permisos de acceso en las Organizaciones de Inventario
  --Par?tros:
  --   P_ORG_ID: Id de la Organizaci?n de Inventario
  --
  --Retorno: X_ACCESS
  --
  --Autor: Ricardo Orozco Agudelo
  --Fecha de Creaci?n: 08-01-2009
  --
  --Actualizado en:
    --1 : 23-01-2009
      --Se deactiva el acceso a todas las organizaciones de inventario para la responsabilidad GM_ZZ_BI_REPORTES_SUPER_USUARIO
    --2 : 28-01-2009
      --Se adiciona el m?do de validaci?n

  FUNCTION DEV_ORG_INV_ACCESS(
    P_ORG_ID IN NUMBER
    , P_METHOD IN VARCHAR2 DEFAULT 'ORG_ACCESS'
  ) RETURN CHAR;

--=================================================================
--=================================================================
  --FUNCION
  --Obtiene el nombre del negocio a partir de la responsabilidad
  --Par?tros:
  --
  --Retorno: X_HIERARCHY_CODE
  --
  --Autor: Ricardo Orozco Agudelo
  --Fecha de Creaci?n: 30-01-2009
  --
  --Actualizado en:

  FUNCTION DEV_HIERARCHY_CODE
  RETURN VARCHAR2;

--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Reporte de Saldos y Consumos en Consignaci?n
  --Par?tros:
    --errbuf: Control de Ejecuci?n
    --errocode: Control de error
    --
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A
  --Fecha Creaci?n: 05-02-2009
  --
  --Actualizado en:
    --1: 12-02-2009
      --Instrucci?n en c?ulo de inventario con filtro por owning_organization_id

  PROCEDURE DEV_REP_CONSUMOS_CONSIGNACION(
    errbuf OUT NOCOPY VARCHAR2
    , errcode OUT NOCOPY VARCHAR2
    , p_start_date IN VARCHAR2 --Fecha Inicial (OBLIGATORIO)
    , p_end_date IN VARCHAR2 --Fecha Final (OBLIGATORIO)
    , p_op_number VARCHAR2 --N?mero de Acuerdo
    , p_supplier_name IN VARCHAR2 --Nombre del Proveedor
    , p_organization_code IN VARCHAR2 --C?digo de la Organizaci?n de Inventario
    , p_item_code IN VARCHAR2 --C?digo de Art?lo

  );

  --=================================================================
  --=================================================================
  --FUNCION XXMU_DEV_IS_NUMBER
  --Valida si la cadena de caracteres es num?ca o no
  --Par?tros:
  --  strNumber IN VARCHAR2
  --Retorno:
  --
  --Autor: Camilo Andr?Cardona Arango
  --Fecha de Creaci?n: 28-JUL-2009
  --
  --Actualizado en:

  FUNCTION DEV_IS_NUMBER(strNumber IN VARCHAR2) RETURN VARCHAR2;

  --=================================================================
--=================================================================
  --FUNCION DIAS_DOMINGOS_FESTIVOS_F
  --Retorna el n?mero de dias domingo y festivos de un rango de fechas
  --Par?tros:
  --  fecha_inicial DATE
  --  fecha_final DATE
  --Retorno:
  -- l_cont_dom_fest
  --Autor: Camilo Andr?Cardona Arango
  --Fecha de Creaci?n: 17-FEB-2010
  --
  --Actualizado en:

  FUNCTION DIAS_DOMINGOS_FESTIVOS_F(fecha_inicial DATE, fecha_final DATE) RETURN NUMBER;

   --=================================================================
--=================================================================
  --FUNCION DIAS_FESTIVOS_F
  --Retorna el n?mero de dias domingo y festivos de un rango de fechas
  --Par?tros:
  --  fecha_inicial DATE
  --  fecha_final DATE
  --Retorno:
  -- l_cont_dom_fest
  --Autor: Camilo Andr?Cardona Arango
  --Fecha de Creaci?n: 17-FEB-2010
  --
  --Actualizado en:

  FUNCTION DIAS_FESTIVOS_F(fecha_inicial DATE, fecha_final DATE) RETURN NUMBER;

  --=================================================================
  --=================================================================
  --FUNCTION INV_EN_MANO_X_ARTICULO
  --Obtiene el inventario a la mano por articulo, organizacion, subinventario, lote o localizador
  FUNCTION INV_EN_MANO_X_ARTICULO (
      p_inventory_item_id IN NUMBER
    , p_organization_id IN NUMBER
    , p_subinventory_code IN VARCHAR2 DEFAULT NULL
    , p_lot_number IN VARCHAR2 DEFAULT NULL
    , p_locator_id IN NUMBER DEFAULT 0
  ) RETURN NUMBER;

  --=================================================================
  --=================================================================
  --FUNCTION INV_EN_MANO_X_ARTICULO
  --Obtiene el inventario a la mano por articulo, organizacion, subinventario, lote o localizador
  FUNCTION INV_EN_TRANSITO_ARTICULO (
      p_inventory_item_id IN NUMBER
    , p_from_org_id IN NUMBER DEFAULT 0 --Organizacion origen
    , p_to_org_id IN NUMBER DEFAULT 0 --Organizacion destino
  ) RETURN NUMBER;

  --=================================================================
  --=================================================================
  --Obtiene la cantidad en produccion por articulo, organizacion y estado del batch
  FUNCTION CANT_EN_PRODUCCION_ARTICULO (
      p_inventory_item_id IN NUMBER
    , p_organization_id IN NUMBER --Organizacion
    , p_batch_status IN NUMBER --estado del batch
  ) RETURN NUMBER;


  --=================================================================
  --=================================================================
  /*
  * PROCEDURE              : IMPRIME_TEXTO
  * Descripcion            : Proceso Para impresion por PANTALLA o DEBUG
  * Parametros De Entrada  : p_cadena  : texto a mostrar
  *                          p_tipo    : P Pantalla (FND_FILE.PUT_LINE)
  *                                      D Debug    (DBMS_OUTPUT.PUT_LINE)
  *                                      A Ambos    (FND_FILE.PUT_LINE y DBMS_OUTPUT.PUT_LINE)
  * Parametros De Salida   : N.A.
  * Creado por             : Alejandro Pavony M - Interfaces
  * Fecha                  : 14-Oct-2010
  * Historia de modificaciones
  * Fecha       Autor   Modificacion
  * -           -       -
  */

  PROCEDURE IMPRIME_TEXTO ( p_tipo   IN VARCHAR2
    , p_cadena IN VARCHAR2 );

  --=================================================================
  --=================================================================
  /*FUNCTION - BATCH_CANTIDAD_X_FORMULA
    Descripci?n:
        -OBTIENE POR INGREDIENTE DE BATCH LA CANTIDAD PLANEADA A PARTIR DE LA FORMULA Y LA CANTIDAD REAL CONSUMIDA
        -Consulta la cantidad real producida en el batch y calcula para un ingrediente la cantidad
        que por formula se debe utilizar en la elaboraci?n del producto
    Parametros:
        p_batch_id: Id del Batch de Producci?n
        p_organization_id: Id de la organizaci?n
        p_formulaline_id: Id de la l?a en la formula
    Autor: Ricardo Orozco - 20101217
  */

  FUNCTION BATCH_CANTIDAD_X_FORMULA(
      p_batch_id IN NUMBER
    , p_organization_id IN NUMBER
    , p_formulaline_id IN NUMBER
  )
  RETURN NUMBER;
  --=================================================================
  --=================================================================
  /*PROCEDIMIENTO - XXMU_HIST_NIVEL_SERIVICIO
    Descripci?n:
      -- OBTIENE LA INFORMACI? DE PEDIDOS Y NOTAS DE ENTREGAS POR PERIODO NECESARIOS PARA EL CALCULO DE NIVEL DE SERVICIO
      -- Realiza en proceso en dos etapas
        --primero obtiene la informaci?n de los pedidos y los almacena en la tabla BOLINF.XXMU_NIVEL_SERVICIO_PEDIDO (Solo almacena los ?ltimos 3 periodos)
        --segundo obtine la informaci?n de Notas de Entrega relacionadas con los Pedidos
    Par?tros:
      errbuf: String con mensaje de resultado de ejecuci?n
      errcode: C?digo del error de resultado de ejecuci?n (NULL si finaliza correctamente)
      p_periodo: C?digo del periodo a calcular (Si no se especifica, se calcula por defecto el periodo correspondiente al mes anterior a la fecha de ejecuci?n del procedimiento)
  */

  PROCEDURE HIST_NIVEL_SERIVICIO_OM(
      errbuf OUT NOCOPY VARCHAR2
    , errcode OUT NOCOPY VARCHAR2
    , p_periodo IN VARCHAR2 DEFAULT NULL
  );
  --=================================================================
  --=================================================================
  /*FUNCION - GET_COSTO_TOTAL
    Descripci?n:
      --CALCULA EL COSTO PROMEDIO PARA UN ARTICULO DE INVENTARIO EN UNA FECHA Y TIPO DE COSTO ESPECIFICO
    Par?tros:
      p_inventory_item_id: Id del art?lo
      p_organization_id: Id de la organizaci?n de Inventario
      p_transaction_date: Fecha para la cual se calcula el costo
      p_cost_method: C?digo para el tipo de costo (COPM, IFRS)

  */

  FUNCTION GET_COSTO_TOTAL(
      p_inventory_item_id NUMBER
    , p_organization_id NUMBER
    , p_transaction_date DATE
    , p_cost_method VARCHAR2
  ) RETURN NUMBER;

  --=================================================================
  --=================================================================
  /*FUNCION - GET_CATEGORIA_COSTOS
    Descripci?n:
      --OBTIENE LA CATEGORIA DE COSTOS ASOCIADA A UN ARTICULO Y ORGANIZACION
    Par?tros:
      p_inventory_item_id: Id del art?lo
      p_organization_id: Id de la organizaci?n de Inventario
      p_segmento: Segmento a obtener de la categoria
        '1' : segment1
        '2' : segment2
        '3' : segment3

  */
  FUNCTION GET_CATEGORIA_COSTOS(
      p_inventory_item_id NUMBER
    , p_organization_id NUMBER
    , p_segmento VARCHAR2
  ) RETURN VARCHAR2;


  --=================================================================
  --=================================================================
  /*PROCEDIMIENTO - ACT_HIST_NIVEL_SERVICIO_OM
    Descripci?n:
      -- ACTUALIZA LA INFORMACI? PARA EL CALCULO DE NIVEL DE SERVICIO (PEDIDOS Y ENTREGAS)
      -- Se actualizan los campos para el periodo inmediatamente anterior a la fecha de ejecuci?n del PL/SQL.
        -- Campos - Pedidos
          -- Cantidad NC
          -- Numero NC
          -- Causal NC
        -- Campos - Entregas
          -- Fecha de Llegada Real

    Par?tros:
      errbuf: String con mensaje de resultado de ejecuci?n
      errcode: C?digo del error de resultado de ejecuci?n (NULL si finaliza correctamente)

  */

  PROCEDURE ACT_HIST_NIVEL_SERVICIO_OM(
      errbuf OUT NOCOPY VARCHAR2
    , errcode OUT NOCOPY VARCHAR2
    , p_operating_unit_id IN NUMBER DEFAULT NULL
  );

  --=================================================================
  --=================================================================
  /*FUNCION - AR_DESCUENTO_FACTURA
    Descripci?n:
      --Obtiene los descuentos por factura de AR cargados desde el pedido OM
    Par?tros:
      p_order_number: Numero del Pedido en OM
      p_trx_number: Numero de la factura en AR
      p_org_id: Id de la unidad operativa
  */

  FUNCTION AR_DESCUENTO_FACTURA(
      p_order_number NUMBER
    , p_trx_number VARCHAR2
    , p_org_id NUMBER
  ) RETURN NUMBER;

  --=================================================================
  --=================================================================

  PROCEDURE INVENTARIO_DIARIO_MLS(
      errbuf OUT NOCOPY VARCHAR2
    , errcode OUT NOCOPY VARCHAR2
  );

  --=================================================================
  --=================================================================

/*=================================================================
  =================================================================
  FUNCION GET_CATEGORIA_MERCADEO

  Descripci?n:
    Esta funci?n permite obtener un segmento de la categoria de mercadeo de un art?lo.

  Par?tros:
     - p_inventory_item_id: id del art?lo
     - p_segmento: n?mero del segmento de la categoria de mercadeo que se desea retornar.
     - p_campo: determina si se retorna el c?digo o la descripci?n del segemnto - 'C' ? 'D'

  Retorno: x_segemento

  Autor: Camilo Andr?Cardona Arango - Centro de Servicios Mundial S.A.
  Fecha de Creaci?n: 08-JUL-2011

  Actualizado en:

  =================================================================
  =================================================================
*/
 FUNCTION GET_CATEGORIA_MERCADEO(p_inventory_item_id  IN NUMBER
                                , p_segmento          IN NUMBER
                                , p_campo             IN CHAR
                                 )
  RETURN VARCHAR2;

  --=================================================================
  --=================================================================
  --FUNCION LEAD TIME

  --SUMA N DIAS A UNA FECHA Y RETORNA LA CANTIDAD DE DIAS REALMENTE LABORALES
  --CALCULA LOS DIAS EN TRANSITO INCLUYENDO DIAS NO HABILES
  --Creada por:
    --Camilo Cardona, Ricardo Orozco - 26-JUL-2011
  --Parametros:
    -- p_fecha_inicial : Es la fecha base
    -- p_dias : Cantidad de dias habiles o laborales a sumar
    -- p_dias_no_laborales : cadena de caracteres separados por coma con los dias de la semana considerados como no logisticos o no laborales
      --1 : DOMINGO
      --2 : LUNES
      --3 : MARTES
      --4 : MIERCOLES
      --5 : JUEVES
      --6 : VIERNES
      --7 : SABADO

  FUNCTION LEAD_TIME(
    p_fecha_inicial IN DATE
    , p_dias IN NUMBER
    , p_dias_no_laborales IN VARCHAR2
  )RETURN NUMBER;

/*=================================================================
  =================================================================
  FUNCION GET_ITEM_COST

  Descripci?n:
    Esta funci?n busca el costo de un art?lo. Considera el tipo
    de bodega para buscar costo discreto o continuo.

  Par?tros:
     - p_inventory_item_id: id del art?lo
     - p_organization_id  : id de la organizaci?n de inventario
     - p_transaction_date : fecha para buscar el costo
     - p_cost_method      : Metodo de Costo, Ej: COPM, IFRS.
                            Puede enviarse en NULL y el sistema
                            devuelve segun metodo predefinido.

  Retorno: v_costo

  Autor: Andr?Correa - Centro de Servicios Mundial S.A.
  Fecha de Creaci?n: 29-JUL-2011

  Actualizado en:

  =================================================================
  =================================================================
*/
  FUNCTION GET_ITEM_COST (p_organization_id   IN NUMBER
                        , p_inventory_item_id IN NUMBER
                        , p_transaction_date  IN DATE
                        , p_cost_method       IN VARCHAR2) RETURN NUMBER;

/*=================================================================
  =================================================================
  FUNCION GET_KIT_OR_ITEM_COST

  Descripci?n:
    Esta funci?n busca el costo de un art?lo, sea o no kit.
    Hace uso de la funcion GET_ITEM_COST .

  Par?tros:
     - p_inventory_item_id: id del art?lo
     - p_organization_id  : id de la organizaci?n de inventario
     - p_transaction_date : fecha para buscar el costo
     - p_cost_method      : Metodo de Costo, Ej: COPM, IFRS.
                            Puede enviarse en NULL y el sistema
                            devuelve segun metodo predefinido.

  Retorno: v_costo

  Autor: Andr?Correa - Centro de Servicios Mundial S.A.
  Fecha de Creaci?n: 29-JUL-2011

  Actualizado en:

  =================================================================
  =================================================================
*/
  FUNCTION GET_KIT_OR_ITEM_COST  (p_organization_id   IN NUMBER
                                , p_inventory_item_id IN NUMBER
                                , p_transaction_date  IN DATE
                                , p_cost_method       IN VARCHAR2) RETURN NUMBER;

/*=================================================================
  =================================================================
  FUNCION get_org_id_for_last_transfer

  Descripci?n:
    Devuelve la ultima organizacion continua desde la cual fue
    trasladado el articulo.

  Par?tros:
     - p_inventory_item_id: id del art?lo
     - p_organization_id  : id organizaci?n de inventario discreta que
                            recibio el traslado
     - p_date             : fecha maxima de consulta

  Retorno: x_org_id

  Autor: Andr?Correa - Centro de Servicios Mundial S.A.
  Fecha de Creaci?n: ACORREA 05-AGO-2011

  Actualizado en:

  =================================================================
  =================================================================
*/
  FUNCTION get_org_id_for_last_transfer(p_inventory_item_id NUMBER, p_organization_id NUMBER, p_date DATE) RETURN NUMBER;

/*=================================================================
  =================================================================
  FUNCION GET_COMPANY_CODE_FOR_ORG_ID

  Descripci?n:
    Devuelve codigo de compania para el id organizacion.

  Par?tros:
     - p_org_id  : id organizaci?n unidad operativa

  Retorno: x_company_code

  Autor: Andr?Correa - Centro de Servicios Mundial S.A.
  Fecha de Creaci?n: ACORREA 08-AGO-2011

  Actualizado en:

  =================================================================
  =================================================================
*/
  FUNCTION GET_COMPANY_CODE_FOR_ORG_ID (p_org_id NUMBER) RETURN VARCHAR2;

  FUNCTION GET_VALIDATION_ORG_ID (p_org_id NUMBER) RETURN NUMBER;

  FUNCTION GET_BUSINESS_CODE (p_ord_code VARCHAR2) RETURN VARCHAR2;

  FUNCTION get_discrt_org_item_sales_cost(p_line_id NUMBER
                                         ,p_org_id  NUMBER) RETURN NUMBER;

  FUNCTION get_item_sales_cost(p_organization_id   IN NUMBER
                              ,p_inventory_item_id IN NUMBER
                              ,p_transaction_date  IN DATE
                              ,p_cost_method       IN VARCHAR2
                              ,p_order_line_id     IN NUMBER := NULL) RETURN NUMBER;

  FUNCTION get_kit_or_item_sales_cost(p_organization_id   IN NUMBER
                                     ,p_inventory_item_id IN NUMBER
                                     ,p_transaction_date  IN DATE
                                     ,p_cost_method       IN VARCHAR2
                                     ,p_validation_org_id IN NUMBER
                                     ,p_header_id         IN NUMBER := NULL
                                     ,p_order_line_id     IN NUMBER := NULL) RETURN NUMBER;

END XXMU_DEV_REPORT_PK;
/
CREATE OR REPLACE PACKAGE BODY XXMU_DEV_REPORT_PK AS

--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Almacena el inventario diario para la organizaci?n de inventario
  --Par?tros:
  --   errbuf: Control de ejecuci?n
  --   errcode: Control de error
  --   p_organization_code: Lista de unidades de Inventario a consultar (BODEGAS)
  --
  --Retorno: N/A
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A.
  --Fecha de Creaci?n: 25-03-2008
  --
  --Actualizado en:
    --1: 30-04-2008
      --Se adiciona la conversi?n para CM3 calculandola a partir de las dimensiones

  PROCEDURE DEV_INVENTORY_ONHAND( errbuf      OUT NOCOPY VARCHAR2,
                                                  errcode     OUT NOCOPY VARCHAR2,
                                                  p_organization_code IN VARCHAR2
  )

  IS

    PESO NUMBER;
    GAL NUMBER;
    CM3 NUMBER;
    R_CONVERT NUMBER;
    INV_DAY VARCHAR2(10) := TO_CHAR(SYSDATE,'DD-MM-YYYY');
    PROC_DATE VARCHAR2(20) := TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS');
    RESERVATION_UOM VARCHAR2(3);
    RESERVATION_QUANT NUMBER;
    RESERVATION_PESO NUMBER;
    RESERVATION_GAL NUMBER;
    RESERVATION_CM3 NUMBER;
    X_UNIT_LENGTH NUMBER;
    X_UNIT_WIDTH NUMBER;
    X_UNIT_HEIGHT NUMBER;

    err_msg VARCHAR2(2000);
    err_num NUMBER;

    CURSOR cr_inventory_mls
    IS SELECT SYSDATE AS FECHA
      ,moq.ORGANIZATION_ID
      ,ood.ORGANIZATION_CODE
      ,moq.TRANSACTION_QUANTITY
      ,moq.TRANSACTION_UOM_CODE
      ,REGEXP_SUBSTR(cat_gl.DESCRIPTION,'[^/]+',1,2) AS MARCA
      ,msi.SEGMENT1
      ,msi.INVENTORY_ITEM_ID
      ,msi.UNIT_WEIGHT
      ,msi.UNIT_VOLUME
      ,moq.SUBINVENTORY_CODE
      ,moq.LOCATOR_ID
      ,moq.LOT_NUMBER
      ,moq.ONHAND_QUANTITIES_ID
    FROM INV.MTL_ONHAND_QUANTITIES_DETAIL moq
      ,INV.MTL_SYSTEM_ITEMS_B msi
      , (SELECT DISTINCT gcc.SEGMENT2, msib.INVENTORY_ITEM_ID, hoiv.ORGANIZATION_ID, (SELECT ffvv.DESCRIPTION FROM APPS.FND_FLEX_VALUES_VL ffvv WHERE ffvv.FLEX_VALUE_SET_ID = (SELECT FLEX_VALUE_SET_ID FROM APPS.FND_FLEX_VALUE_SETS WHERE FLEX_VALUE_SET_NAME = 'GM_ZZ_GL_NEGOCIOS') AND ffvv.FLEX_VALUE = gcc.SEGMENT2) AS DESCRIPTION
        FROM INV.MTL_SYSTEM_ITEMS_B msib,
          APPS.HR_ORGANIZATION_INFORMATION_V hoiv,
          APPS.GL_CODE_COMBINATIONS gcc
        WHERE hoiv.ORG_INFORMATION2 = (SELECT glnsv.LEGAL_ENTITY_ID
            FROM APPS.XLE_FIRSTPARTY_INFORMATION_V xfi,  APPS.GL_LEDGER_NORM_SEG_VALS glnsv,  APPS.GL_LEDGERS gl
            WHERE xfi.LEGAL_ENTITY_ID = glnsv.LEGAL_ENTITY_ID
              AND gl.LEDGER_CATEGORY_CODE = 'PRIMARY'
              AND gl.LEDGER_ID = glnsv.LEDGER_ID
              AND glnsv.SEGMENT_VALUE = 'CGP'
            )
          AND gcc.CODE_COMBINATION_ID = msib.SALES_ACCOUNT
          AND hoiv.ORG_INFORMATION_CONTEXT = 'Accounting Information'
          AND msib.ORGANIZATION_ID = hoiv.ORGANIZATION_ID
      ) cat_gl --CATEGORIAL CONTABLE - DE NEGOCIO
      ,APPS.ORG_ORGANIZATION_DEFINITIONS ood
    WHERE moq.ORGANIZATION_ID IN (SELECT ORGANIZATION_ID FROM APPS.ORG_ORGANIZATION_DEFINITIONS WHERE INSTR(p_organization_code,ORGANIZATION_CODE) > 0)
    AND moq.INVENTORY_ITEM_ID = msi.INVENTORY_ITEM_ID
    AND moq.ORGANIZATION_ID = msi.ORGANIZATION_ID
    AND moq.INVENTORY_ITEM_ID = cat_gl.INVENTORY_ITEM_ID
    AND moq.ORGANIZATION_ID = cat_gl.ORGANIZATION_ID
    AND moq.ORGANIZATION_ID = ood.ORGANIZATION_ID
    ORDER BY moq.ORGANIZATION_ID;

    INV_REPORT cr_inventory_mls%ROWTYPE;

  BEGIN

    errcode := 0;

    fnd_file.put_line(fnd_file.output,'***********************************************************************************');
    fnd_file.put_line(fnd_file.output,'**********************INICIO PROCESO DE INVENTARIO DIARIO MLS**********************');
    fnd_file.put_line(fnd_file.output,'***********************************************************************************');

    fnd_file.put_line(fnd_file.output,'Hora de Inicio: ' || PROC_DATE);
    fnd_file.put_line(fnd_file.output,'Organizaciones de Inventario: ' || p_organization_code);

    fnd_file.put_line(fnd_file.output,CHR(10));
    fnd_file.put_line(fnd_file.output,'**********************************************');

    --============================================================================
    --SE LIMPIA LA TABLA TEMPORAL ANTES DE INICIAR EL PROCESO
    DELETE FROM APPS.TMP_INV_MLS;
    COMMIT;

    fnd_file.put_line(fnd_file.output,'LECTURA DE REGISTROS DE INVENTARIO A LA MANO');

    --SE CALCULAN LAS CONVERSIONES Y SE ALMACENAN EN UNA TABLA TEMPORAL
    OPEN cr_inventory_mls;
    LOOP
      FETCH cr_inventory_mls INTO INV_REPORT;
      EXIT WHEN cr_inventory_mls%NOTFOUND;

      PESO := 0;
      GAL := 0;
      CM3 := 0;

      --===================================================================
      --CONVERSION A KG
      R_CONVERT := 1;
      IF UPPER(INV_REPORT.TRANSACTION_UOM_CODE) = 'KG' THEN
        PESO := INV_REPORT.TRANSACTION_QUANTITY;
      ELSE
        APPS.INV_CONVERT.INV_UM_CONVERSION(
          FROM_UNIT => INV_REPORT.TRANSACTION_UOM_CODE
          ,TO_UNIT => 'kg'
          ,ITEM_ID => INV_REPORT.INVENTORY_ITEM_ID
          ,UOM_RATE => R_CONVERT
        );

        IF R_CONVERT <> -99999 THEN
          PESO := INV_REPORT.TRANSACTION_QUANTITY * R_CONVERT;
        ELSE
          errcode := 1;
        END IF;

      END IF;

      --=========================================================================
      --CONVERSION A GAL
      R_CONVERT := 1;
      IF UPPER(INV_REPORT.TRANSACTION_UOM_CODE) = 'GAL' THEN
        GAL := INV_REPORT.TRANSACTION_QUANTITY;
      ELSE
        APPS.INV_CONVERT.INV_UM_CONVERSION(
          FROM_UNIT => INV_REPORT.TRANSACTION_UOM_CODE
          ,TO_UNIT => 'gal'
          ,ITEM_ID => INV_REPORT.INVENTORY_ITEM_ID
          ,UOM_RATE => R_CONVERT
        );

        IF R_CONVERT <> -99999 THEN
          GAL := NVL(INV_REPORT.TRANSACTION_QUANTITY * R_CONVERT,0);
        ELSE
          errcode := 1;
        END IF;

      END IF;

      --==========================================================================
      --CONVERSION A CM3
      R_CONVERT := 1;
      IF UPPER(INV_REPORT.TRANSACTION_UOM_CODE) = 'CM3' THEN
        CM3 := INV_REPORT.TRANSACTION_QUANTITY;
      ELSE
        APPS.INV_CONVERT.INV_UM_CONVERSION(
          FROM_UNIT => INV_REPORT.TRANSACTION_UOM_CODE
          ,TO_UNIT => 'cm3'
          ,ITEM_ID => INV_REPORT.INVENTORY_ITEM_ID
          ,UOM_RATE => R_CONVERT
        );

        IF R_CONVERT <> -99999 THEN
          CM3 := NVL(INV_REPORT.TRANSACTION_QUANTITY * R_CONVERT,0);
        ELSE

          --SEGUNDA OPCION PARA CONVERSION A CM3
            --SE BUSCAN LAS DIMENSIONES DEL ITEM
          BEGIN
            SELECT UNIT_LENGTH, UNIT_WIDTH, UNIT_HEIGHT
              INTO X_UNIT_LENGTH, X_UNIT_WIDTH, X_UNIT_HEIGHT
            FROM APPS.MTL_SYSTEM_ITEMS_B
            WHERE INVENTORY_ITEM_ID = INV_REPORT.INVENTORY_ITEM_ID
              AND ORGANIZATION_ID = INV_REPORT.ORGANIZATION_ID
              AND UNIT_LENGTH IS NOT NULL
              AND UNIT_WIDTH IS NOT NULL
              AND UNIT_HEIGHT IS NOT NULL;

              IF UPPER(INV_REPORT.TRANSACTION_UOM_CODE) = 'UND' THEN
                CM3 := (X_UNIT_LENGTH * X_UNIT_WIDTH *  X_UNIT_HEIGHT) * INV_REPORT.TRANSACTION_QUANTITY;
              ELSE
                errcode := 1;
              END IF;

            EXCEPTION
              WHEN OTHERS THEN
                errcode := 1;
          END;
        END IF;

      END IF;

      --=========================================================================
      --CONVERSION A UNIDADES
      R_CONVERT := 1;
      IF UPPER(INV_REPORT.TRANSACTION_UOM_CODE) != 'UND' THEN
        APPS.INV_CONVERT.INV_UM_CONVERSION(
          FROM_UNIT => INV_REPORT.TRANSACTION_UOM_CODE
          ,TO_UNIT => 'und'
          ,ITEM_ID => INV_REPORT.INVENTORY_ITEM_ID
          ,UOM_RATE => R_CONVERT
        );

        IF R_CONVERT <> -99999 THEN
          INV_REPORT.TRANSACTION_QUANTITY := NVL(INV_REPORT.TRANSACTION_QUANTITY * R_CONVERT,0);
          INV_REPORT.TRANSACTION_UOM_CODE := 'und';
        ELSE
          errcode := 1;
        END IF;

      END IF;

      --==========================================================================
      --SE CALCULAN LAS RESERVAS DE ITEMS

      RESERVATION_QUANT := 0;
      RESERVATION_UOM := '';
      RESERVATION_PESO := 0;
      RESERVATION_GAL := 0;
      RESERVATION_CM3 := 0;

      --==========================================================================
      --SE ALMACENAN EN LA TABLE TEMPORAL LOS REGISTROS CON LAS CONVERSIONES DE UNIDADES
      INSERT INTO APPS.TMP_INV_MLS (ORGANIZATION_ID
        ,ORGANIZATION_CODE
        ,INVENTORY_ITEM_ID
        ,SEGMENT1
        ,TRANSACTION_QUANTITY
        ,TRANSACTION_UOM_CODE
        ,PESO_KG
        ,VOLUMEN_GAL
        ,VOLUMEN_CM3
        ,RESERVATION_UOM_CODE
        ,RESERVATION_QUANTITY
        ,CAT_DESCRIPTION
        ,CREATION_DATE
        ,SUBINVENTORY_CODE
        ,LOCATOR_ID
        ,LOT_NUMBER
        ,ONHAND_QUANTITIES_ID)
      VALUES(
        INV_REPORT.ORGANIZATION_ID
        ,INV_REPORT.ORGANIZATION_CODE
        ,INV_REPORT.INVENTORY_ITEM_ID
        ,INV_REPORT.SEGMENT1
        ,ABS(INV_REPORT.TRANSACTION_QUANTITY)
        ,INV_REPORT.TRANSACTION_UOM_CODE
        ,ABS(PESO)
        ,ABS(GAL)
        ,ABS(CM3)
        ,RESERVATION_UOM
        ,RESERVATION_QUANT
        ,INV_REPORT.MARCA
        ,SYSDATE
        ,INV_REPORT.SUBINVENTORY_CODE
        ,INV_REPORT.LOCATOR_ID
        ,INV_REPORT.LOT_NUMBER
        ,INV_REPORT.ONHAND_QUANTITIES_ID
      );

    END LOOP;

    IF errcode = 1 THEN
      fnd_file.put_line(fnd_file.output,'ALGUNOS ARTICULOS NO TIENEN UNIDAD DE CONVERSION A (KG, GAL, CM3 o UND)');
    END IF;

    --SE AGRUPAN LOS REGISTROS POR BODEGA Y UNIDADES DE MEDIDA

    fnd_file.put_line(fnd_file.output,CHR(10));
    fnd_file.put_line(fnd_file.output,'******************************************************');
    fnd_file.put_line(fnd_file.output,'SE CONSOLIDAN LOS REGISTROS POR ORGANIZACION, MARCA Y UNIDAD DE MEDIDA');

    INSERT INTO APPS.DEV_REPORT_INVENTORY_MLS
    SELECT ORGANIZATION_CODE
      ,SUBSTR(INV_DAY,1,2) AS DIA
      ,SUBSTR(INV_DAY,4,2) AS MES
      ,SUBSTR(INV_DAY,7,4) AS ANO
      ,ROUND(SUM(TRANSACTION_QUANTITY),0) AS CANTIDAD
      ,TRANSACTION_UOM_CODE AS UOM
      ,ROUND(SUM(PESO_KG),0) AS PESO_KG
      ,ROUND(SUM(VOLUMEN_GAL),0) AS VOLUMEN_GAL
      ,ROUND(SUM(VOLUMEN_CM3),0) AS VOLUMEN_CM3
      ,CAT_DESCRIPTION
    FROM APPS.TMP_INV_MLS
    WHERE CREATION_DATE BETWEEN TO_DATE(INV_DAY||' 00:00:00', 'DD-MM-YYYY HH24:MI:SS') AND TO_DATE(INV_DAY||' 23:59:59', 'DD-MM-YYYY HH24:MI:SS')
    group by ORGANIZATION_CODE, SUBSTR(INV_DAY,1,2), SUBSTR(INV_DAY,4,2), SUBSTR(INV_DAY,7,4), TRANSACTION_UOM_CODE, CAT_DESCRIPTION
    ORDER BY 4,3,2,1;

    COMMIT;
    fnd_file.put_line(fnd_file.output,'PROCESO TERMINADO SATISFACTORIAMENTE');


    --============================================================================
    --SE LIBERAN LOS REGISTROS TEMPORALES AL TERMINAR EL PROCESO
    DELETE FROM APPS.TMP_INV_MLS;
    COMMIT;

  EXCEPTION
    WHEN OTHERS THEN
      err_num := SQLCODE;
      err_msg := SUBSTR(SQLERRM, 1, 2000);
      dbms_output.put_line('Error  # ' || err_num || ' - ' || err_msg);
      errcode := 2; --Marca error

      ROLLBACK;
  END DEV_INVENTORY_ONHAND;

--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Almacena el inventario a mano de los items en consignaci?n
  --Par?tros:
    --errbuf: Control de Ejecuci?n
    --errocode: Control de error
    --p_organization_code: C?digos de Unidades Operativas
    --p_is_consigned: Par?tro de estado en consignaci?n
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A
  --Fecha Creaci?n: 14-05-2008
  --
  --Actualizado en:
    --1:  28-01-2009
      --Modificaci?n en el Procedimiento y en tabla destino

  PROCEDURE DEV_INVENTORY_ONHAND_CONSIGN(
    errbuf OUT NOCOPY VARCHAR2,
    errcode OUT NOCOPY VARCHAR2
  )
  IS

    l_inv_date DATE := SYSDATE;
    err_num NUMBER;
    err_msg VARCHAR2(2000);
    X_CONVERT NUMBER;
    l_inv_qty NUMBER := 0;


  BEGIN

    errcode := 0;

    fnd_file.put_line(fnd_file.output,'***********************************************************************************');
    fnd_file.put_line(fnd_file.output,'**********************INICIO PROCESO DE INVENTARIO EN CONSIGNACION**********************');
    fnd_file.put_line(fnd_file.output,'***********************************************************************************');

    fnd_file.put_line(fnd_file.output,'Hora de Inicio: ' || TO_CHAR(SYSDATE,'DD-MON-YYYY HH24:MI:SS'));

    fnd_file.put_line(fnd_file.output,CHR(10));
    fnd_file.put_line(fnd_file.output,'**********************************************');

    --Por cada l?a de los acuerdos de Compra
    FOR cr_inventory_consigned IN
      (
      SELECT   pha.PO_HEADER_ID
        , pha.segment1 AS header_num
        , pla.po_line_id
        , pla.line_num
        , pasl.USING_ORGANIZATION_ID AS ORGANIZATION_ID
        , mp.organization_code
        , pasl.VENDOR_ID
        , pv.vendor_name
        , pasl.VENDOR_SITE_ID
        , pasl.ITEM_ID AS INVENTORY_ITEM_ID
        , msi.primary_unit_of_measure AS UOM
        , msi.segment1
        FROM PO_APPROVED_SUPPLIER_LIST pasl
        , PO_ASL_ATTRIBUTES paa
        , PO_ASL_DOCUMENTS pad
        , PO_HEADERS_ALL pha
        , PO_LINES_ALL pla
        , PO_VENDORS pv
        , mtl_system_items_b msi
        , mtl_parameters mp
      WHERE pasl.ASL_ID = paa.ASL_ID
        AND paa.ASL_ID = pad.ASL_ID
        AND (pasl.DISABLE_FLAG IS NULL OR pasl.DISABLE_FLAG = 'N')
        AND paa.CONSIGNED_FROM_SUPPLIER_FLAG = 'Y' --EN CONSIGNACION
        AND pad.DOCUMENT_HEADER_ID = pha.PO_HEADER_ID
        AND pha.PO_HEADER_ID = pla.PO_HEADER_ID
        AND pv.vendor_id = pha.vendor_id
        AND pad.DOCUMENT_LINE_ID = pla.PO_LINE_ID
        AND msi.inventory_item_id = pasl.ITEM_ID
        AND msi.organization_id = pasl.USING_ORGANIZATION_ID
        AND mp.organization_id = pasl.USING_ORGANIZATION_ID
      )
    LOOP

      l_inv_qty := 0;


      --Consulta el inventario  a mano para el art?lo
      BEGIN

        SELECT SUM(XXMU_DEV_REPORT_PK.CONVERT_UOM_ITEM(transaction_uom_code, cr_inventory_consigned.uom, inventory_item_id) * transaction_quantity) INTO l_inv_qty
        FROM mtl_onhand_quantities_detail
        WHERE inventory_item_id = cr_inventory_consigned.Inventory_item_id
          AND organization_id = cr_inventory_consigned.organization_id
          AND owning_organization_id = cr_inventory_consigned.VENDOR_SITE_ID
          AND is_consigned = 1;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          l_inv_qty := 0;
        WHEN OTHERS THEN
          fnd_file.put_line(fnd_file.output,'Error obteniendo Inventario a mano del art?lo ('|| cr_inventory_consigned.segment1 ||') - organizacion ( ' || cr_inventory_consigned.organization_code || ') - Proveedor (' || cr_inventory_consigned.vendor_name || ') en consignaci?n');
          fnd_file.put_line(fnd_file.output,'Nro Acuerdo : ' || cr_inventory_consigned.header_num || ' - L?a : '|| cr_inventory_consigned.line_num);
          fnd_file.put_line(fnd_file.output,'Error : ' ||SQLCODE || ' - ' ||SQLERRM);
          l_inv_qty := -1;
      END;

      IF l_inv_qty >= 0 THEN

        BEGIN
          --Se elimina el registro que coincida con los datos del registro
          DELETE FROM BOLINF.XXMU_HIST_INVENTORY_CONSIGNED
          WHERE TRUNC(inventory_date) = TRUNC(l_inv_date - 1)
            AND inventory_item_id = cr_inventory_consigned.Inventory_item_id
            AND organization_id = cr_inventory_consigned.organization_id
            AND po_header_id = cr_inventory_consigned.po_header_id
            AND po_line_id = cr_inventory_consigned.po_line_id
            AND vendor_site_id = cr_inventory_consigned.vendor_site_id;

          --Se almacena el inventario
          INSERT INTO BOLINF.XXMU_HIST_INVENTORY_CONSIGNED (
            inventory_item_id
            , organization_id
            , inventory_date
            , po_header_id
            , po_line_id
            , supplier_id
            , vendor_site_id
            , inventory_quantity
            , uom
            , created_by
            , creation_date
          )
          VALUES(
            cr_inventory_consigned.Inventory_item_id
            , cr_inventory_consigned.organization_id
            , TRUNC(l_inv_date - 1)
            , cr_inventory_consigned.po_header_id
            , cr_inventory_consigned.po_line_id
            , cr_inventory_consigned.vendor_id
            , cr_inventory_consigned.vendor_site_id
            , l_inv_qty
            , cr_inventory_consigned.uom
            , NVL(FND_GLOBAL.USER_ID,-1)
            , SYSDATE
          );
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            fnd_file.put_line(fnd_file.output,'Error obteniendo Inventario a mano del art?lo ('|| cr_inventory_consigned.segment1 ||') - organizacion ( ' || cr_inventory_consigned.organization_code || ') - Proveedor (' || cr_inventory_consigned.vendor_name || ') en consignaci?n');
            fnd_file.put_line(fnd_file.output,'Nro Acuerdo : ' || cr_inventory_consigned.header_num || ' - L?a : '|| cr_inventory_consigned.line_num);
            fnd_file.put_line(fnd_file.output,'Error : ' ||SQLCODE || ' - ' ||SQLERRM);
        END;
      END IF;

      fnd_file.put_line(fnd_file.output,CHR(10));

    END LOOP;

    fnd_file.put_line(fnd_file.output,'Proceso Finalizado');

  EXCEPTION
    WHEN OTHERS THEN
      err_num := SQLCODE;
      err_msg := SUBSTR(SQLERRM, 1, 2000);
      fnd_file.put_line(fnd_file.output,'Error  # ' || TO_CHAR(err_num) || ' - ' || err_msg);
      errcode := 2; --Marca error

      ROLLBACK;

  END DEV_INVENTORY_ONHAND_CONSIGN;

--=================================================================
--=================================================================
  --FUNCION
  --Realiza la conversi?n entre unidades de medida de un articulo
  --Par?tros:
  --   P_FROM_UOM: Unidad de Medida en la que se encuentra el articulo
  --   P_TO_UOM: Unidad de Medida a la que se desea llevar
  --   P_ITEM_ID: Id del articulo a procesar
  --
  --Retorno: X_CONVERT
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A.
  --Fecha de Creaci?n: 03-04-2008
  --
  --Actualizado en:
    --1:  24-04-2008
      -- Se adiciona el retorno en (X_CONVERT = 0) cuando no se encuntra la tasa de conversi?n
    --2: 16-05-2008
      --Se utiliza una tabla secundaria para tasas de conversi?n - Se prioriza el valor de la tabla secundaria

  FUNCTION CONVERT_UOM_ITEM (
    P_FROM_UNIT IN VARCHAR2
    ,P_TO_UNIT IN VARCHAR2
    ,P_ITEM_ID IN NUMBER
  ) RETURN NUMBER IS

  X_CONVERT NUMBER;

  BEGIN

    IF P_FROM_UNIT = P_TO_UNIT THEN
      X_CONVERT := 1;

    ELSE

      BEGIN
        SELECT CONVERSION_RATE INTO X_CONVERT
        FROM BOLINF.DEV_MTL_UOM_CLASS_CONV
        WHERE INVENTORY_ITEM_ID = P_ITEM_ID
          AND FROM_UOM_CODE = P_FROM_UNIT
          AND TO_UOM_CODE = P_TO_UNIT
          AND NVL(DISABLED,'N') != 'Y' ;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN

          APPS.INV_CONVERT.INV_UM_CONVERSION(
            FROM_UNIT => P_FROM_UNIT
            ,TO_UNIT => P_TO_UNIT
            ,ITEM_ID => P_ITEM_ID
            ,UOM_RATE => X_CONVERT
          );

          IF X_CONVERT = -99999 THEN
            X_CONVERT := 0;
          END IF;
      END;
    END IF;

    RETURN X_CONVERT;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END CONVERT_UOM_ITEM;

--====================================================
--SOLO LAS TASAS DE CONVERSION PRINCIPALES DE ORACLE

  FUNCTION CONVERT_UOM_ITEM_SYS (
    P_FROM_UNIT IN VARCHAR2
    ,P_TO_UNIT IN VARCHAR2
    ,P_ITEM_ID IN NUMBER
  ) RETURN NUMBER IS

  X_CONVERT NUMBER;

  BEGIN

    APPS.INV_CONVERT.INV_UM_CONVERSION(
      FROM_UNIT => P_FROM_UNIT
      ,TO_UNIT => P_TO_UNIT
      ,ITEM_ID => P_ITEM_ID
      ,UOM_RATE => X_CONVERT
    );

    IF X_CONVERT = -99999 THEN
      X_CONVERT := 0;
    END IF;

    RETURN X_CONVERT;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END CONVERT_UOM_ITEM_SYS;

--=================================================================
  --FUNCION
  --Determina si un String es Tipo N?mero
  --Par?tros:
  --   P_STRING: Cadena de caracteres
  --
  --Retorno: X_NUMBER
  --
  --Autor: Tomada de Internet - Pagina WEB  http://www.psoug.org/reference/functions.html
  --Fecha de Creaci?n: 23-07-2008
  --
  --Actualizado en:

  FUNCTION DEV_ISNUMBER(
    P_STRING IN VARCHAR2
  ) RETURN NUMBER IS

  ISNUMBER NUMBER;
  X_NUMBER NUMBER(1) := 0;

  BEGIN

  ISNUMBER := TO_NUMBER(P_STRING);
  X_NUMBER := 1;

  RETURN X_NUMBER;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN X_NUMBER;

  END DEV_ISNUMBER;

--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Proceso que selecciona la fecha inicial para un periodo de aviso de consumos
  -- (emplea los datos almacenados en la tabla de control "bolinf.dev_control_aviso_consumo". Esta tabla almacena los datos de la ejecuci?n del concurrente de "Creaci?n de Aviso de Consumo" y sus par?tros)
  --Par?tros:
    --p_request_id: Id de ejecuci?n del concurrente actual de Aviso de Consumo
    --p_actual_completion_date: Fecha de ejecuci?n del concurrente actual de Aviso de Consumo
    --p_po_header_id: Id del acuerdo de compra
    --p_po_line_id: Id de la l?a del acuerdo de compra
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A
  --Fecha Creaci?n: 05-11-2008
  --
  --Actualizado en:
    --

  PROCEDURE DEV_FECHA_INICIO_AVISO_CONSUMO
  (
    p_request_id IN NUMBER
    ,p_actual_completion_date IN DATE
    ,p_po_header_id NUMBER
    ,p_po_line_id NUMBER
    ,x_request_id OUT NUMBER
    ,x_last_completion_date OUT DATE
    ,x_errcode OUT NOCOPY VARCHAR2
  )
  IS

    l_request_id fnd_concurrent_requests.request_id%TYPE;
    l_vendor_id po_headers_all.vendor_id%TYPE;
    l_vendor_site_id po_approved_supplier_list.vendor_site_id%TYPE;
    l_inventory_item_id po_approved_supplier_list.item_id%TYPE;
    l_organization_id po_approved_supplier_list.using_organization_id%TYPE;
    l_last_request_date fnd_concurrent_requests.actual_completion_date%TYPE;
    l_status bolinf.dev_control_aviso_consumo.status%TYPE;
    dummy PLS_INTEGER;
    err_num NUMBER;
    err_msg VARCHAR2(2000);

    --Lista de concurrentes (Aviso de Consumo) que se encuentren en la tabla de control
    CURSOR cr_control_search
    IS
    SELECT request_id, vendor_id, vendor_site_id, inventory_item_id, organization_id, last_request_date, status
    FROM bolinf.dev_control_aviso_consumo
    WHERE request_id != p_request_id
      AND last_request_date < p_actual_completion_date
    ORDER BY last_request_date DESC;

    --Busca si el registro de Acuerdo y l?a fue modificado por la solicitud
    CURSOR cr_match_request (c_vendor_id NUMBER, c_vendor_site_id NUMBER, c_inventory_item_id NUMBER, c_organization_id NUMBER, c_po_header_id NUMBER, c_po_line_id NUMBER)
    IS
    SELECT 1
    FROM PO_APPROVED_SUPPLIER_LIST pasl
      ,PO_ASL_ATTRIBUTES paa
      ,PO_ASL_DOCUMENTS pad
      ,PO_HEADERS_ALL pha
      ,PO_LINES_ALL pla
    WHERE pasl.ASL_ID = paa.ASL_ID
      AND paa.ASL_ID = pad.ASL_ID
      AND (pasl.DISABLE_FLAG IS NULL OR pasl.DISABLE_FLAG = 'N')
      AND paa.CONSIGNED_FROM_SUPPLIER_FLAG = 'Y' --EN CONSIGNACION
      AND pad.DOCUMENT_HEADER_ID = pha.PO_HEADER_ID
      AND pha.PO_HEADER_ID = pla.PO_HEADER_ID
      AND pad.DOCUMENT_LINE_ID = pla.PO_LINE_ID
      --SE ANEXAN LOS PARAMETROS DEL CONCURRENTE DE AVISO DE CONSUMOS
      AND pha.VENDOR_ID = NVL(c_vendor_id, pha.VENDOR_ID)
      AND pasl.USING_ORGANIZATION_ID = NVL(c_organization_id, pasl.USING_ORGANIZATION_ID)
      AND pasl.ITEM_ID = NVL(c_inventory_item_id, pasl.ITEM_ID)
      AND pasl.VENDOR_SITE_ID = NVL(c_vendor_site_id, pasl.VENDOR_SITE_ID)
      AND pha.po_header_id = NVL(c_po_header_id, pha.po_header_id)
      AND pad.document_line_id = NVL(c_po_line_id, pad.document_line_id);

  BEGIN

    x_request_id := NULL;
    x_errcode := 0;

    --SE BUSCA EN LOS REGISTROS DE CONCURRENTES PROCESADOS
    OPEN cr_control_search;
    LOOP
    FETCH cr_control_search INTO l_request_id, l_vendor_id, l_vendor_site_id, l_inventory_item_id, l_organization_id, l_last_request_date, l_status;
    EXIT WHEN cr_control_search%NOTFOUND OR x_request_id IS NOT NULL;

      --Si el concurrente no tiene asignados par?tros se asume que dicho concurrente trabajo con todos los acuerdos de compra
      IF NVL(l_vendor_id,0) = 0 AND NVL(l_vendor_site_id,0) = 0 AND NVL(l_inventory_item_id,0) = 0 AND NVL(l_organization_id,0) = 0 THEN
        x_request_id := l_request_id;
        x_last_completion_date := l_last_request_date;
      ELSE
        --SE SELECCIONA EL DE MAYOR FECHA EN EL QUE SE MODIFIQUE LA LINEA DEL ACUERDO
        OPEN cr_match_request (l_vendor_id, l_vendor_site_id, l_inventory_item_id, l_organization_id, p_po_header_id, p_po_line_id);
        FETCH cr_match_request INTO dummy;
        IF cr_match_request%FOUND THEN
          x_request_id := l_request_id;
          x_last_completion_date := l_last_request_date;
        END IF;

        CLOSE cr_match_request;
      END IF;

    END LOOP;
    CLOSE cr_control_search;

    EXCEPTION
      WHEN OTHERS THEN
        err_num := SQLCODE;
        err_msg := SUBSTR(SQLERRM, 1, 2000);
        fnd_file.put_line(fnd_file.output,'Error  # ' || TO_CHAR(err_num) || ' - ' || err_msg);
        x_errcode := 2;

  END DEV_FECHA_INICIO_AVISO_CONSUMO;

--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Proceso que monitorea la ejecuci?n del concurrente de aviso de consumos y almacena los consumos, recepciones, fechas de ejecuci?n e inventario de los art?los en consignaci?n
  --Par?tros:
    --errbuf: Control de Ejecuci?n
    --errocode: Control de error
    --p_concurrent_program_name: Abreviatura del Ejecutable de Aviso de Consumo (INVCTXNM)
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A
  --Fecha Creaci?n: 05-11-2008
  --
  --Actualizado en:
    --1: 06-11-2008
      --Se adicionaron las transacciones de TRANSFERIR A CONSIGNACION en los consumos
      --Se toman los consumos y recepciones durante el periodo de terminaci?n del concurrente [crear de aviso de consumo] y la ejecuci?n del concurrente [XXMU - Almacenar Reporte de Acuerdos de Compra] en el calculo del inventario inicial y final para dicho periodo

  PROCEDURE DEV_GUARDAR_AVISOS_DE_CONSUMO(
    errbuf OUT NOCOPY VARCHAR2,
    errcode OUT NOCOPY VARCHAR2,
    p_concurrent_program_name IN VARCHAR2
  )
  IS
    l_concurrent_program_id NUMBER;
    l_application_id NUMBER;
    l_request_id fnd_concurrent_requests.request_id%TYPE;
    l_request_start_id fnd_concurrent_requests.request_id%TYPE;
    l_actual_completion_date fnd_concurrent_requests.actual_completion_date%TYPE;
    l_argument1 fnd_concurrent_requests.argument1%TYPE; --Tama?o Lote
    l_argument2 fnd_concurrent_requests.argument2%TYPE; --Procesos M?mo
    l_argument3 fnd_concurrent_requests.argument3%TYPE; --Proveedor
    l_argument4 fnd_concurrent_requests.argument4%TYPE; --Sucursal Proveedor
    l_argument5 fnd_concurrent_requests.argument5%TYPE; --Art?lo
    l_argument6 fnd_concurrent_requests.argument6%TYPE; --Organizaci?n
    l_start_date_concurrent DATE := to_date('01-06-2008 00:00:00', 'DD-MM-YYYY HH24:MI:SS'); --Fecha inicial para proceso de concurrentes de aviso de consumo
    l_start_date DATE; --Fecha inicial periodo consumo
    l_end_date DATE; --Fecha final periodo consumo
    l_inventario_consumido NUMBER; --Consolidado de materia prima consumida (Salidas)
    l_inventario_recibido NUMBER; --Consolidado de materia prima puesta en consignaci?n (Entradas) por el proveedor
    l_inventario_consumido_nc NUMBER; --Consolidado de materia prima consumida (Salidas) NO CONTABLE DENTRO DEL PERIODO
    l_inventario_recibido_nc NUMBER; --Consolidado de materia prima puesta en consignaci?n (Entradas) por el proveedor NO CONTABLE DENTRO DEL PERIODO
    l_inventario_inicial NUMBER; --Inventario correspondiente a la fecha l_start_date
    l_inventario_final NUMBER; --Invenatario correspondiente a la fecha l_end_date
    l_primary_unit_of_measure CHAR(3);

    dummy PLS_INTEGER;

    CURSOR cr_concurrent_program IS
    SELECT concurrent_program_id, application_id
    FROM fnd_concurrent_programs
    WHERE concurrent_program_name = p_concurrent_program_name;

    CURSOR cr_request (p_concurrent_program_id NUMBER, p_application_id NUMBER)
    IS
    SELECT request_id
      , actual_completion_date
      , argument1
      , argument2
      , argument3
      , argument4
      , argument5
      , argument6
    FROM fnd_concurrent_requests
    WHERE concurrent_program_id = p_concurrent_program_id
      AND program_application_id = p_application_id
      AND request_id NOT IN (SELECT request_id FROM bolinf.dev_control_aviso_consumo)
      AND phase_code = 'C'
      AND status_code = 'C'
      AND actual_completion_date >= l_start_date_concurrent
    ORDER BY actual_completion_date ASC;

    NO_DATA_FOUND_CONCURRENT EXCEPTION;

  BEGIN
    errcode := 0;
    fnd_file.put_line(fnd_file.output,'***************************************************************************************');
    fnd_file.put_line(fnd_file.output,'Ejecuci?n procedimiento (DEV_GUARDAR_AVISOS_DE_CONSUMO) - ' || sysdate);
    fnd_file.put_line(fnd_file.output,'-------------------------------------------------------------------------');
    fnd_file.put_line(fnd_file.output,'');

    --SE BUSCA EL ID DEL PROGRAMA CONCURRENTE DE CREACION DE AVISOS DE CONSUMOS
    OPEN cr_concurrent_program;
    FETCH cr_concurrent_program INTO l_concurrent_program_id, l_application_id;
    IF cr_concurrent_program%NOTFOUND THEN
      CLOSE cr_concurrent_program;
      RAISE NO_DATA_FOUND_CONCURRENT;
    END IF;

    CLOSE cr_concurrent_program;

    fnd_file.put_line(fnd_file.output,'Juego de solicitudes halladas');
    fnd_file.put_line(fnd_file.output,'=');

    --PARA TODOS LAS SOLICITUDES ENCONTRADAS
    OPEN cr_request (l_concurrent_program_id, l_application_id);
    LOOP
    FETCH cr_request INTO l_request_id, l_actual_completion_date, l_argument1, l_argument2, l_argument3, l_argument4, l_argument5, l_argument6;
    EXIT WHEN cr_request%NOTFOUND;

      --SE ALMACENA EL REGISTRO DEL CONCURRENTE EN LA TABLA DE CONTROL
      INSERT INTO bolinf.dev_control_aviso_consumo (request_id, vendor_id, vendor_site_id, inventory_item_id, organization_id, last_request_date)
      VALUES (l_request_id, TO_NUMBER(l_argument3), TO_NUMBER(l_argument4), TO_NUMBER(l_argument5), TO_NUMBER(l_argument6), l_actual_completion_date);
      fnd_file.put_line(fnd_file.output,'');
      fnd_file.put_line(fnd_file.output,'Request_id = '||l_request_id||' - Vendor_id = '||l_argument3||' - Vendor_site_id = '||l_argument4||' - Inventory_item_id = '||l_argument5||' - Organization_id = '||l_argument6||' - Completion_date = '||l_actual_completion_date);
      dbms_output.put_line('Request_id = '||l_request_id||' - Vendor_id = '||l_argument3||' - Vendor_site_id = '||l_argument4||' - Inventory_item_id = '||l_argument5||' - Organization_id = '||l_argument6||' - Completion_date = '||l_actual_completion_date);
      COMMIT;

      --SE OBTIENEN LAS FECHAS INICIAL Y FINAL PARA EL PERIODO DEL CONSUMO
      l_end_date := l_actual_completion_date;

      --SE BUSCAN LOS ACUERDOS DE COMPRA QUE CUMPLAN CON LOS PARAMETROS DEL CONCURRENTE
      FOR cr_acuerdos_de_compra IN
        (SELECT   pha.PO_HEADER_ID
          ,pha.SEGMENT1 AS N_ACUERDO
          ,pla.LINE_NUM AS LINEA
          ,pla.po_line_id
          ,pasl.USING_ORGANIZATION_ID AS ORGANIZATION_ID
          ,pasl.VENDOR_ID
          ,pasl.VENDOR_SITE_ID
          ,pasl.ITEM_ID
        FROM PO_APPROVED_SUPPLIER_LIST pasl
          ,PO_ASL_ATTRIBUTES paa
          ,PO_ASL_DOCUMENTS pad
          ,PO_HEADERS_ALL pha
          ,PO_LINES_ALL pla
        WHERE pasl.ASL_ID = paa.ASL_ID
          AND paa.ASL_ID = pad.ASL_ID
          AND (pasl.DISABLE_FLAG IS NULL OR pasl.DISABLE_FLAG = 'N')
          AND paa.CONSIGNED_FROM_SUPPLIER_FLAG = 'Y' --EN CONSIGNACION
          AND pad.DOCUMENT_HEADER_ID = pha.PO_HEADER_ID
          AND pha.PO_HEADER_ID = pla.PO_HEADER_ID
          AND pad.DOCUMENT_LINE_ID = pla.PO_LINE_ID
          --SE ANEXAN LOS PARAMETROS DEL CONCURRENTE DE AVISO DE CONSUMOS
          AND pha.VENDOR_ID = NVL(TO_NUMBER(l_argument3), pha.VENDOR_ID)
          AND pasl.USING_ORGANIZATION_ID = NVL(TO_NUMBER(l_argument6), pasl.USING_ORGANIZATION_ID)
          AND pasl.ITEM_ID = NVL(TO_NUMBER(l_argument5), pasl.ITEM_ID)
          AND pasl.VENDOR_SITE_ID = NVL(TO_NUMBER(l_argument4), pasl.VENDOR_SITE_ID)
        ORDER BY N_ACUERDO, LINEA
        )
      LOOP

        --SE OBTIENE LA FECHA INICIAL, ID DE SOLICITUD POR CADA LINEA DEL ACUERDO
        DEV_FECHA_INICIO_AVISO_CONSUMO
        (
          l_request_id
          ,l_actual_completion_date
          ,cr_acuerdos_de_compra.po_header_id
          ,cr_acuerdos_de_compra.po_line_id
          ,l_request_start_id
          ,l_start_date
          ,errcode
        );

        fnd_file.put_line(fnd_file.output,'');
        fnd_file.put_line(fnd_file.output,'Acuerdo = '|| cr_acuerdos_de_compra.n_acuerdo ||' - L?a = '|| cr_acuerdos_de_compra.linea || ' - Fecha Inicial = ' || l_start_date || ' - Fecha Final = ' || l_end_date || ' - Item id = ' || cr_acuerdos_de_compra.item_id || ' - Organization Id = ' ||  cr_acuerdos_de_compra.organization_id);
        dbms_output.put_line('Acuerdo = '|| cr_acuerdos_de_compra.n_acuerdo ||' - L?a = '|| cr_acuerdos_de_compra.linea || ' - Fecha Inicial = ' || l_start_date || ' - Fecha Final = ' || l_end_date || ' - Item id = ' || cr_acuerdos_de_compra.item_id || ' - Organization Id = ' ||  cr_acuerdos_de_compra.organization_id);

        --SE OBTIENEN LOS CONSOLIDADOS PARA CONSUMOS, RECEPCIONES, INVENTARIO FINAL E INVENTARIO INICIAL

        SELECT PRIMARY_UNIT_OF_MEASURE INTO l_primary_unit_of_measure
        FROM mtl_system_items_b
        WHERE inventory_item_id = cr_acuerdos_de_compra.item_id
          AND organization_id = cr_acuerdos_de_compra.organization_id;

        --RECIBIDO DURANTE EL PERIODO
        SELECT NVL(SUM(XXMU_DEV_REPORT_PK.CONVERT_UOM_ITEM(mmt.TRANSACTION_UOM, l_primary_unit_of_measure , mmt.inventory_item_id) *  mmt.TRANSACTION_QUANTITY ),0) INTO l_inventario_recibido
        FROM mtl_material_transactions mmt
        WHERE mmt.inventory_item_id = cr_acuerdos_de_compra.item_id
          AND mmt.organization_id = cr_acuerdos_de_compra.organization_id
          AND mmt.transaction_type_id IN (18,36) --RECEPCION DE ORDEN DE COMPRA, DEVOLUCION A PROVEEDOR
          AND EXISTS
            (SELECT 1
            FROM po_headers_all pha
              , po_lines_all pla
              , po_line_locations_all pll
            WHERE mmt.transaction_source_id = pha.po_header_id
              AND pha.vendor_id = cr_acuerdos_de_compra.vendor_id
              AND pha.po_header_id = pla.po_header_id
              AND pla.item_id = mmt.inventory_item_id
              AND pla.po_header_id = pll.po_header_id
              AND pla.po_line_id = pll.po_line_id
              AND pll.consigned_flag = 'Y'
            )
          AND mmt.creation_date BETWEEN l_start_date AND l_end_date;

        --RECIBIDO DESPUES DE LA EJECUCION DEL CONCURRENTE DE CREACION DE AVISO DE CONSUMO
        SELECT NVL(SUM(XXMU_DEV_REPORT_PK.CONVERT_UOM_ITEM(mmt.TRANSACTION_UOM, l_primary_unit_of_measure , mmt.inventory_item_id) *  mmt.TRANSACTION_QUANTITY ),0) INTO l_inventario_recibido_nc
        FROM mtl_material_transactions mmt
        WHERE mmt.inventory_item_id = cr_acuerdos_de_compra.item_id
          AND mmt.organization_id = cr_acuerdos_de_compra.organization_id
          AND mmt.transaction_type_id IN (18,36) --RECEPCION DE ORDEN DE COMPRA, DEVOLUCION A PROVEEDOR
          AND EXISTS
            (SELECT 1
            FROM po_headers_all pha
              , po_lines_all pla
              , po_line_locations_all pll
            WHERE mmt.transaction_source_id = pha.po_header_id
              AND pha.vendor_id = cr_acuerdos_de_compra.vendor_id
              AND pha.po_header_id = pla.po_header_id
              AND pla.item_id = mmt.inventory_item_id
              AND pla.po_header_id = pll.po_header_id
              AND pla.po_line_id = pll.po_line_id
              AND pll.consigned_flag = 'Y'
            )
          AND mmt.creation_date > l_end_date;

        --CONSUMIDO DURANTE EL PERIODO
        SELECT ABS(NVL(SUM(XXMU_DEV_REPORT_PK.CONVERT_UOM_ITEM(mmt.TRANSACTION_UOM, l_primary_unit_of_measure, mmt.INVENTORY_ITEM_ID) * mmt.TRANSACTION_QUANTITY),0)) INTO l_inventario_consumido
        FROM mtl_material_transactions mmt
          , mtl_consumption_transactions mct
        WHERE mmt.inventory_item_id = cr_acuerdos_de_compra.item_id
          AND mmt.organization_id = cr_acuerdos_de_compra.organization_id
          AND mmt.transaction_type_id IN (74,75)
          AND mmt.owning_organization_id = cr_acuerdos_de_compra.vendor_site_id
          AND mmt.transaction_id = mct.transaction_id(+)
          AND mct.creation_date BETWEEN l_start_date AND l_end_date;

        --CONSUMIDO DESPUES DE LA EJECUCION DEL CONCURRENTE DE CREACION DE AVISO DE CONSUMO
        SELECT ABS(NVL(SUM(XXMU_DEV_REPORT_PK.CONVERT_UOM_ITEM(mmt.TRANSACTION_UOM, l_primary_unit_of_measure, mmt.INVENTORY_ITEM_ID) * mmt.TRANSACTION_QUANTITY),0)) INTO l_inventario_consumido_nc
        FROM mtl_material_transactions mmt
          , mtl_consumption_transactions mct
        WHERE mmt.inventory_item_id = cr_acuerdos_de_compra.item_id
          AND mmt.organization_id = cr_acuerdos_de_compra.organization_id
          AND mmt.transaction_type_id IN (74,75)
          AND mmt.owning_organization_id = cr_acuerdos_de_compra.vendor_site_id
          AND mmt.transaction_id = mct.transaction_id(+)
          AND mct.creation_date > l_end_date;

        --INVENTARIO FINAL
        SELECT NVL(SUM(XXMU_DEV_REPORT_PK.CONVERT_UOM_ITEM(moq.TRANSACTION_UOM_CODE, l_primary_unit_of_measure,moq.INVENTORY_ITEM_ID) * moq.TRANSACTION_QUANTITY),0) INTO l_inventario_final
        FROM mtl_onhand_quantities_detail moq
        WHERE moq.inventory_item_id = cr_acuerdos_de_compra.item_id
          AND moq.organization_id = cr_acuerdos_de_compra.organization_id
          AND moq.is_consigned = 1
          AND moq.owning_organization_id = cr_acuerdos_de_compra.vendor_site_id;

        --INVENTARIO INICIAL
        l_inventario_final := l_inventario_final + ABS(l_inventario_consumido_nc) - ABS(l_inventario_recibido_nc); --Se considera que el concurrente [XXMU - Almacenar Reporte de Acuerdos de Compra] puede tener un desfase entre la ejecuci?n del concurrente [crear aviso de consumo] y ?
        l_inventario_inicial := l_inventario_final  + ABS(l_inventario_consumido) - ABS(l_inventario_recibido);

        --SE ALMACENA LA INFORMACION PARA LA LINEA DEL ACUERDO DE COMPRA
        BEGIN
          INSERT INTO BOLINF.DEV_PO_CONSUMPTION_REPORT(request_id, po_header_id, po_header_num, po_line_id, po_line_num, vendor_id, vendor_side_id, inventory_item_id, organization_id, start_date, end_date, creation_date, actual_completion_date, reception_qty, consumption_qty, start_onhand_qty, end_onhand_qty, uom)
          VALUES(l_request_id, cr_acuerdos_de_compra.po_header_id, cr_acuerdos_de_compra.n_acuerdo, cr_acuerdos_de_compra.po_line_id, cr_acuerdos_de_compra.linea, cr_acuerdos_de_compra.vendor_id, cr_acuerdos_de_compra.vendor_site_id, cr_acuerdos_de_compra.item_id, cr_acuerdos_de_compra.organization_id, l_start_date, l_end_date, SYSDATE, l_actual_completion_date, l_inventario_recibido, l_inventario_consumido, l_inventario_inicial, l_inventario_final, l_primary_unit_of_measure);

        EXCEPTION
          WHEN OTHERS THEN
            fnd_file.put_line(fnd_file.output,'ERROR N?= ' || SQLCODE);
            fnd_file.put_line(fnd_file.output,'ERROR = ' || SUBSTR(SQLERRM, 1, 2000));
            errcode := 2;
        END;
        dbms_output.put_line('RECIBIDO = ' || l_inventario_recibido || ' - CONSUMIDO = ' || l_inventario_consumido || ' - INVENTARIO INICIAL = ' ||l_inventario_inicial || ' - INVENTARIO FINAL = '||l_inventario_final || ' - RECIBIDO_NC = ' || l_inventario_recibido_nc || ' - CONSUMIDO_NC = ' || l_inventario_consumido_nc);

      END LOOP;

      fnd_file.put_line(fnd_file.output,'');
      dbms_output.put_line('');

      UPDATE bolinf.dev_control_aviso_consumo
      SET status = 'Y'
      WHERE request_id = l_request_id;

    END LOOP;
    CLOSE cr_request;


  EXCEPTION
    WHEN NO_DATA_FOUND_CONCURRENT THEN
      fnd_file.put_line(fnd_file.output,'*************************************************************************');
      fnd_file.put_line(fnd_file.output,'NO SE ENCONTRO EL PROGRAMA CONCURRENTE QUE CONCUERDE CON LA ABREVIATURA ('|| p_concurrent_program_name ||')');
      dbms_output.put_line('NO SE ENCONTRO EL PROGRAMA CONCURRENTE QUE CONCUERDE CON LA ABREVIATURA ('|| p_concurrent_program_name ||')');
      errcode := 2;
    WHEN OTHERS THEN
      fnd_file.put_line(fnd_file.output,'ERROR N?= ' || SQLCODE);
      fnd_file.put_line(fnd_file.output,'ERROR = ' || SUBSTR(SQLERRM, 1, 2000));
      dbms_output.put_line('ERROR N?= ' || SQLCODE);
      dbms_output.put_line('ERROR = ' || SUBSTR(SQLERRM, 1, 2000));
      errcode := 2;
  END DEV_GUARDAR_AVISOS_DE_CONSUMO;

--=================================================================
--=================================================================
  --FUNCION
  --Valida los permisos de acceso en los Libros Contables
  --Par?tros:
  --   P_LEDGER_ID: Id del libro contable
  --   P_LEDGER_GROUP: Determina si la validaci?n se hace a nivel de Grupo de Libros o a nivel de ID ('Y' nivel grupo, 'N' nivel de ID)
  --
  --Retorno: X_ACCESS
  --
  --Autor: Ricardo Orozco Agudelo
  --Fecha de Creaci?n: 15-12-2008
  --
  --Actualizado en:
    --1 : 23-01-2009
      --Se deactiva el acceso a todos los libros contables para la responsabilidad GM_ZZ_BI_REPORTES_SUPER_USUARIO

  FUNCTION DEV_LEDGER_ACCESS(
    P_LEDGER_ID IN NUMBER
    , P_LEDGER_GROUP IN VARCHAR2 DEFAULT 'N'
  ) RETURN CHAR IS

    X_ACCESS CHAR(1) := 'N';
  BEGIN

    IF FND_GLOBAL.RESP_ID = -1 THEN
      RETURN 'N';
    END IF;

    --IF NVL(DEV_ALL_ACCESS(FND_GLOBAL.RESP_APPL_ID, FND_GLOBAL.RESP_ID),'N') = 'Y' THEN
      --RETURN 'Y';
    --END IF;

    IF NVL(P_LEDGER_GROUP,'N') = 'Y' THEN
      --Se valida el Acceso a nivel de Grupo de Libros
      SELECT 'Y' INTO X_ACCESS
      FROM gl_ledgers gl
        , gl_ledger_norm_seg_vals gln
      WHERE gln.segment_value = (
          SELECT gln2.segment_value
          FROM gl_ledgers gl2
          , gl_ledger_norm_seg_vals gln2
          WHERE gl2.ledger_id = gln2.ledger_id
            AND gl2.ledger_id = NVL(FND_PROFILE.VALUE('GL_SET_OF_BKS_ID'),0)
            AND rownum = 1
        )
        AND gl.ledger_id = gln.ledger_id
        AND gl.ledger_id = P_LEDGER_ID;
    ELSE
      --Se valida el Acceso a nivel de Id de Libro
      IF P_LEDGER_ID = NVL(FND_PROFILE.VALUE('GL_SET_OF_BKS_ID'),0) THEN
        X_ACCESS := 'Y';
      END IF;

    END IF;

    RETURN X_ACCESS;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';

  END DEV_LEDGER_ACCESS;

--=================================================================
--=================================================================
  --FUNCION
  --Valida los permisos de acceso en las Unidades Operativas
  --Par?tros:
  --   P_ORG_ID: Id de la Unidad Operativa
  --
  --Retorno: X_ACCESS
  --
  --Autor: Ricardo Orozco Agudelo
  --Fecha de Creaci?n: 15-12-2008
  --
  --Actualizado en:
    --1 : 23-01-2009
      --Se deactiva el acceso a todas las unidades operativas para la responsabilidad GM_ZZ_BI_REPORTES_SUPER_USUARIO

 FUNCTION DEV_ORG_ACCESS(
    P_ORG_ID IN NUMBER
  ) RETURN CHAR IS

    X_ACCESS CHAR(1) := 'N';

  BEGIN

    --IF DEV_ALL_ACCESS(FND_GLOBAL.RESP_APPL_ID, FND_GLOBAL.RESP_ID) = 'Y' THEN
      --RETURN 'Y';
    --END IF;
    /*
    SELECT 'Y' INTO X_ACCESS
    FROM DUAL
    WHERE EXISTS (SELECT 1
        FROM mo_glob_org_access_tmp
        WHERE organization_id = P_ORG_ID
      );*/

    IF FND_GLOBAL.ORG_ID = P_ORG_ID THEN
      RETURN 'Y';
    END IF;

    RETURN 'N';

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';

END DEV_ORG_ACCESS;


--=================================================================
--=================================================================
  --FUNCION
  --Valida si la responsabilidad tienen acceso total en las funciones de vaildaci?n de Acceso
  --Par?tros:
  --
  --Retorno: X_ALL_ACCESS
  --
  --Autor: Ricardo Orozco Agudelo
  --Fecha de Creaci?n: 16-12-2008
  --
  --Actualizado en:

  FUNCTION DEV_ALL_ACCESS( P_RESP_APPL_ID IN NUMBER
    , P_RESP_ID IN NUMBER
  )RETURN CHAR IS

    X_ALL_ACCESS CHAR(1) := 'N';
    L_RESPONSABILITY_KEY VARCHAR2(50) := 'GM_ZZ_BI_REPORT_SUPER_USUARIO';

  BEGIN

    SELECT 'Y' INTO X_ALL_ACCESS
    FROM fnd_responsibility
    WHERE application_id = P_RESP_APPL_ID
      AND responsibility_id = P_RESP_ID
      AND responsibility_key = L_RESPONSABILITY_KEY;

    RETURN X_ALL_ACCESS;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';

  END DEV_ALL_ACCESS;

--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Procedimiento para generar el reporte de contabilidad detallada por art?lo
  --Par?tros:
    --errbuf: Control de Ejecuci?n
    --errocode: Control de error
    --
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A
  --Fecha Creaci?n: 19-12-2008
  --
  --Actualizado en:
    --1: 06-01-2009
      --Se crearon los cursores por art?lo y libro contable
    --2: 04_02_2009
      --Se elimina la tabla "xla_acct_line_types_fvl" por duplicidad de registros
    --3: 26_03_2009
      --Se corrigen los formatos de fecha entrados por el juego de datos FND_STANDAR_DATE

  PROCEDURE DEV_CONTABILIDAD_DET_ITEM(
    errbuf      OUT NOCOPY VARCHAR2
    , errcode     OUT NOCOPY VARCHAR2
    , p_ledger_name IN VARCHAR2
    , p_gl_organization_code IN VARCHAR2
    , p_item_code IN VARCHAR2
    , p_start_date IN VARCHAR2
    , p_end_date IN VARCHAR2
  ) IS

    err_num NUMBER;
    err_msg VARCHAR2(2000);
    p_inventory_item_id mtl_system_items_b.inventory_item_id%TYPE;
    p_ledger_id gl_ledgers.ledger_id%TYPE;
    p_name gl_ledgers.name%TYPE;
    x_item_code mtl_system_items_b.segment1%TYPE;
    x_item_id mtl_system_items_b.inventory_item_id%TYPE;
    x_id_transaction gmf_xla_extract_headers.transaction_id%TYPE;
    x_event_class_name xla_event_classes_tl.name%TYPE;
    x_event_type_code xla_ae_headers.event_type_code%TYPE;
    x_accounting_class_code xla_ae_lines.accounting_class_code%TYPE;
    --x_line_name xla_acct_line_types_fvl.name%TYPE;
    x_accounted_dr xla_ae_lines.accounted_dr%TYPE;
    x_accounted_cr xla_ae_lines.accounted_cr%TYPE;
    x_gcc_segment5 gl_code_combinations.segment5%TYPE;
    x_gcc_segment6 gl_code_combinations.segment6%TYPE;
    x_gl_transfer_status_code xla_ae_headers.gl_transfer_status_code%TYPE;
    x_accounting_date xla_ae_lines.accounting_date%TYPE;
    lx_start_date VARCHAR2(20);
    lx_end_date VARCHAR2(20);

    --ARTICULOS
    CURSOR cr_items_search(
      l_item_code VARCHAR2
    )
    IS
    SELECT inventory_item_id
    FROM mtl_system_items_b
    WHERE organization_id = 107
      AND INSTR(l_item_code, segment1) > 0;

    --LIBROS CONTABLES
    CURSOR cr_ledger_search(
      p_ledger_name VARCHAR2
    )
    IS
    SELECT gl.ledger_id, gl.name
    FROM gl_ledgers gl
    WHERE INSTR(p_ledger_name,gl.name) > 0
      AND XXMU_DEV_REPORT_PK.DEV_LEDGER_ACCESS(gl.ledger_id) = 'Y';

    --CONTABILIDAD POR ARTICULO
    CURSOR cr_contabilidad_detallada_item (
      l_ledger_id NUMBER
      , l_gl_organization_code VARCHAR2
      , l_item_id NUMBER
      , l_start_date DATE
      , l_end_date DATE
    )
    IS
    SELECT msi.SEGMENT1 --AS ARTICULO
      , xlaext.INVENTORY_ITEM_ID --AS ITEM_ID
      , xlaext.TRANSACTION_ID --AS ID_TRANSACCION
      , evcla.NAME --AS CLASE_EVENTO
      , xah.event_type_code --AS TIPO_EVENTO
      , xal.ACCOUNTING_CLASS_CODE --AS CLASE_CONTABILIDAD
      --, xaly.NAME --AS LINEA_ASIENTO
      , xal.accounted_dr --AS DEBITO_CONTABILIZADO
      , xal.accounted_cr --AS CREDITO_CONTABILIZADO
      , gcc.segment5 --AS CUENTA
      , gcc.segment6 --AS SUBCUENTA
      , xah.GL_TRANSFER_STATUS_CODE --AS TRANSFERIDO_A_GL
      , xal.ACCOUNTING_DATE --AS FECHA_CONTABLE

    FROM xla_ae_headers xah
      , xla_ae_lines xal
      , gmf_xla_extract_headers xlaext
      , gl_code_combinations gcc
      , xla_event_classes_tl evcla
      --, xla_acct_line_types_fvl xaly --:2
      , mtl_system_items_b msi
      , mtl_parameters mp

    WHERE xah.application_id = 555
      AND xal.ae_header_id = xah.ae_header_id
      AND xal.application_id = xah.application_id
      AND xal.ledger_id = xah.ledger_id
      AND xlaext.event_id (+) = xah.event_id
      AND xal.code_combination_id = gcc.code_combination_id
      AND evcla.application_id = xah.application_id
      --AND xah.application_id = xaly.application_id --:2
      --AND evcla.entity_code = xaly.entity_code --:2
      --AND evcla.event_class_code = xaly.event_class_code --:2
      --AND xal.accounting_class_code = xaly.accounting_class_code --:2
      AND evcla.event_class_code = xlaext.event_class_code
      AND xlaext.inventory_item_id = msi.inventory_item_id
      AND msi.organization_id = mp.organization_id
      AND msi.organization_id = mp.master_organization_id
      AND evcla.LANGUAGE = 'ESA'
      AND evcla.source_lang = 'ESA'
      --AND xaly.ACCOUNTING_LINE_TYPE_DSP = 'Oracle' --:2
      AND xah.ledger_id = l_ledger_id
      AND TRUNC(xal.accounting_date) BETWEEN l_start_date AND l_end_date
      AND gcc.segment5 IN ('14050500','14100505','14101500','14300500','14350500','14550500','14600500', '14551000')
      AND INSTR(l_gl_organization_code, gcc.segment6)  > 0
      AND msi.inventory_item_id = l_item_id
    ORDER BY xal.ACCOUNTING_DATE;

  BEGIN

    FND_GLOBAL.APPS_INITIALIZE(FND_GLOBAL.USER_ID, FND_GLOBAL.RESP_ID, FND_GLOBAL.RESP_APPL_ID);

    errcode := 0;
    fnd_file.put_line(fnd_file.output,'CONTABILIDAD DETALLADA POR ARTICULO - [' || SYSDATE||']');
    fnd_file.put_line(fnd_file.output,'');
    dbms_output.put_line('CONTABILIDAD DETALLADA POR ARTICULO - [' || SYSDATE||']');
    dbms_output.put_line('');

    BEGIN
      lx_start_date := TO_CHAR(TO_DATE(p_start_date,'RRRR/MM/DD HH24:MI:SS'),'DD-MON-YYYY');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      lx_start_date := p_start_date;
    END;

    BEGIN
      lx_end_date := TO_CHAR(TO_DATE(p_end_date,'RRRR/MM/DD HH24:MI:SS'),'DD-MON-YYYY');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      lx_end_date := p_end_date;
    END;

    --SE REALIZA LA BUSQUEDA POR CADA ARTICULO
    OPEN cr_items_search (p_item_code);
    LOOP
    FETCH cr_items_search INTO p_inventory_item_id;
    EXIT WHEN cr_items_search%NOTFOUND;

      fnd_file.put_line(fnd_file.output,'');
      fnd_file.put_line(fnd_file.output,'');
      --fnd_file.put_line(fnd_file.output,'ARTICULO'||CHR(9)||'ITEM ID'||CHR(9)||'LIBRO CONTABLE'||CHR(9)||'ID TRANSACCION'||CHR(9)||'CLASE EVENTO'||CHR(9)||'TIPO EVENTO'||CHR(9)||'CLASE CONTABILIDAD'||CHR(9)||'LINEA ASIENTO'||CHR(9)||'DEBITO CONTABILIZADO'||CHR(9)||'CREDITO CONTABILIZADO'||CHR(9)||'CUENTA'||CHR(9)||'SUBCUENTA'||CHR(9)||'TRANSFERIDO A GL'||CHR(9)||'FECHA CONTABLE'); --:2
      fnd_file.put_line(fnd_file.output,'ARTICULO'||CHR(9)||'ITEM ID'||CHR(9)||'LIBRO CONTABLE'||CHR(9)||'ID TRANSACCION'||CHR(9)||'CLASE EVENTO'||CHR(9)||'TIPO EVENTO'||CHR(9)||'CLASE CONTABILIDAD'||CHR(9)||'DEBITO CONTABILIZADO'||CHR(9)||'CREDITO CONTABILIZADO'||CHR(9)||'CUENTA'||CHR(9)||'SUBCUENTA'||CHR(9)||'TRANSFERIDO A GL'||CHR(9)||'FECHA CONTABLE');
      dbms_output.put_line('');
      dbms_output.put_line('');
      --dbms_output.put_line('ARTICULO'||CHR(9)||'ITEM ID'||CHR(9)||'LIBRO CONTABLE'||CHR(9)||'ID TRANSACCION'||CHR(9)||'CLASE EVENTO'||CHR(9)||'TIPO EVENTO'||CHR(9)||'CLASE CONTABILIDAD'||CHR(9)||'LINEA ASIENTO'||CHR(9)||'DEBITO CONTABILIZADO'||CHR(9)||'CREDITO CONTABILIZADO'||CHR(9)||'CUENTA'||CHR(9)||'SUBCUENTA'||CHR(9)||'TRANSFERIDO A GL'||CHR(9)||'FECHA CONTABLE'); --:2
      dbms_output.put_line('ARTICULO'||CHR(9)||'ITEM ID'||CHR(9)||'LIBRO CONTABLE'||CHR(9)||'ID TRANSACCION'||CHR(9)||'CLASE EVENTO'||CHR(9)||'TIPO EVENTO'||CHR(9)||'CLASE CONTABILIDAD'||CHR(9)||'DEBITO CONTABILIZADO'||CHR(9)||'CREDITO CONTABILIZADO'||CHR(9)||'CUENTA'||CHR(9)||'SUBCUENTA'||CHR(9)||'TRANSFERIDO A GL'||CHR(9)||'FECHA CONTABLE');

      --POR CADA LIBRO CONTABLE
      OPEN cr_ledger_search(p_ledger_name);
      LOOP
      FETCH cr_ledger_search INTO p_ledger_id, p_name;
      EXIT WHEN cr_ledger_search%NOTFOUND;

        --INFORMACION CONTABLE
        OPEN cr_contabilidad_detallada_item (p_ledger_id, p_gl_organization_code, p_inventory_item_id, TO_DATE(lx_start_date,'DD-MM-YYYY'), TO_DATE(lx_end_date,'DD-MM-YYYY'));
        LOOP
        --FETCH cr_contabilidad_detallada_item INTO x_item_code, x_item_id, x_id_transaction, x_event_class_name, x_event_type_code, x_accounting_class_code, x_line_name, x_accounted_dr, x_accounted_cr, x_gcc_segment5, x_gcc_segment6, x_gl_transfer_status_code, x_accounting_date; --:2
        FETCH cr_contabilidad_detallada_item INTO x_item_code, x_item_id, x_id_transaction, x_event_class_name, x_event_type_code, x_accounting_class_code, x_accounted_dr, x_accounted_cr, x_gcc_segment5, x_gcc_segment6, x_gl_transfer_status_code, x_accounting_date;
        EXIT WHEN cr_contabilidad_detallada_item%NOTFOUND;

          --fnd_file.put_line(fnd_file.output,x_item_code||CHR(9)||x_item_id||CHR(9)||p_name||CHR(9)||x_id_transaction||CHR(9)||x_event_class_name||CHR(9)||x_event_type_code||CHR(9)||x_accounting_class_code||CHR(9)||x_line_name||CHR(9)||x_accounted_dr||CHR(9)||x_accounted_cr||CHR(9)||x_gcc_segment5||CHR(9)||x_gcc_segment6||CHR(9)||x_gl_transfer_status_code||CHR(9)||x_accounting_date);  --:2
          --dbms_output.put_line(x_item_code||CHR(9)||x_item_id||CHR(9)||p_name||CHR(9)||x_id_transaction||CHR(9)||x_event_class_name||CHR(9)||x_event_type_code||CHR(9)||x_accounting_class_code||CHR(9)||x_line_name||CHR(9)||x_accounted_dr||CHR(9)||x_accounted_cr||CHR(9)||x_gcc_segment5||CHR(9)||x_gcc_segment6||CHR(9)||x_gl_transfer_status_code||CHR(9)||x_accounting_date); --:2
          fnd_file.put_line(fnd_file.output,x_item_code||CHR(9)||x_item_id||CHR(9)||p_name||CHR(9)||x_id_transaction||CHR(9)||x_event_class_name||CHR(9)||x_event_type_code||CHR(9)||x_accounting_class_code||CHR(9)||x_accounted_dr||CHR(9)||x_accounted_cr||CHR(9)||x_gcc_segment5||CHR(9)||x_gcc_segment6||CHR(9)||x_gl_transfer_status_code||CHR(9)||x_accounting_date);
          dbms_output.put_line(x_item_code||CHR(9)||x_item_id||CHR(9)||p_name||CHR(9)||x_id_transaction||CHR(9)||x_event_class_name||CHR(9)||x_event_type_code||CHR(9)||x_accounting_class_code||CHR(9)||x_accounted_dr||CHR(9)||x_accounted_cr||CHR(9)||x_gcc_segment5||CHR(9)||x_gcc_segment6||CHR(9)||x_gl_transfer_status_code||CHR(9)||x_accounting_date);

        END LOOP;
        CLOSE cr_contabilidad_detallada_item;

      END LOOP;
      CLOSE cr_ledger_search;

    END LOOP;
    CLOSE cr_items_search;



  EXCEPTION
    WHEN OTHERS THEN
      err_num := SQLCODE;
      err_msg := SUBSTR(SQLERRM, 1, 2000);
      fnd_file.put_line(fnd_file.output,'Error  # ' || TO_CHAR(err_num) || ' - ' || err_msg);
      errcode := 1;

  END DEV_CONTABILIDAD_DET_ITEM;

--=================================================================
--=================================================================
  --FUNCION
  --Valida los permisos de acceso en las Organizaciones de Inventario
  --Par?tros:
  --   P_ORG_ID: Id de la Organizaci?n de Inventario
  --   P_METHOD: M?do de validaci?n de organizaciones
  --      -> ORG_ACCESS : Valida por los permisos asigandos en la opci?n "Acceso a organizaciones de Inventario"
  --      -> LEDGER : Valida por organizaciones de inventarioa asociadas a los libros contables
  --
  --Retorno: X_ACCESS
  --
  --Autor: Ricardo Orozco Agudelo
  --Fecha de Creaci?n: 08-01-2009
  --
  --Actualizado en:
    --1 : 23-01-2009
      --Se deactiva el acceso a todas las organizaciones de inventario para la responsabilidad GM_ZZ_BI_REPORTES_SUPER_USUARIO
    --2 : 28-01-2009
      --Se adiciona el m?do de validaci?n

  FUNCTION DEV_ORG_INV_ACCESS(
    P_ORG_ID IN NUMBER
    , P_METHOD IN VARCHAR2 DEFAULT 'ORG_ACCESS'
  ) RETURN CHAR IS

    X_ACCESS CHAR(1) := 'N';

  BEGIN

    --FND_GLOBAL.APPS_INITIALIZE(FND_GLOBAL.USER_ID, FND_GLOBAL.RESP_ID, FND_GLOBAL.RESP_APPL_ID);
    --MO_GLOBAL.init('M');

    --IF DEV_ALL_ACCESS(FND_GLOBAL.RESP_APPL_ID, FND_GLOBAL.RESP_ID) = 'Y' THEN
      --RETURN 'Y';
    --END IF;

    IF P_METHOD = 'ORG_ACCESS' THEN
      SELECT 'Y' INTO X_ACCESS
      FROM mtl_parameters
      WHERE organization_id IN ( SELECT organization_id FROM org_access oa WHERE responsibility_id = FND_GLOBAL.RESP_ID AND resp_application_id = FND_GLOBAL.RESP_APPL_ID AND NVL(disable_date,SYSDATE+1) >= SYSDATE)
        AND organization_id = P_ORG_ID;
    END IF;

    IF P_METHOD = 'LEDGER' THEN
      SELECT 'Y' INTO X_ACCESS
      FROM hr_organization_information hoi
        , mtl_parameters mp
      WHERE mp.organization_id = P_ORG_ID
        AND mp.organization_id = hoi.organization_id
        AND hoi.org_information_context = 'Accounting Information'
        AND XXMU_DEV_REPORT_PK.DEV_LEDGER_ACCESS(TO_NUMBER(hoi.org_information1),'Y') = 'Y'
        AND mp.organization_code != '0MA'
        AND ( hoi.org_information1 != '2023' OR (hoi.org_information1 = '2023' AND mp.organization_code NOT LIKE 'E%'));
    END IF;

    RETURN X_ACCESS;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';

  END DEV_ORG_INV_ACCESS;

--=================================================================
--=================================================================
  --FUNCION
  --Obtiene el nombre del negocio a partir de la responsabilidad
  --Par?tros:
  --
  --Retorno: X_HIERARCHY_CODE
  --
  --Autor: Ricardo Orozco Agudelo
  --Fecha de Creaci?n: 30-01-2009
  --
  --Actualizado en:

  FUNCTION DEV_HIERARCHY_CODE
  RETURN VARCHAR2 IS

    l_flex_value_set_id FND_FLEX_VALUE_SETS.flex_value_set_id%TYPE;
    l_parent_flex_value fnd_flex_value_hierarchies.parent_flex_value%TYPE;
    l_structured_hierarchy_level FND_FLEX_VALUES.structured_hierarchy_level%TYPE;
    l_hierarchy_code FND_FLEX_HIERARCHIES.hierarchy_code%TYPE;

  BEGIN


    SELECT flex_value_set_id  INTO l_flex_value_set_id
    FROM FND_FLEX_VALUE_SETS
    WHERE flex_value_set_name = 'GM_ZZ_GL_COMPANIA';

    SELECT parent_flex_value INTO l_parent_flex_value
    FROM fnd_flex_value_hierarchies
    WHERE flex_value_set_id = l_flex_value_set_id
      AND length(parent_flex_value) = 3
      AND child_flex_value_high = substr(FND_GLOBAL.RESP_NAME,1,3);

    SELECT structured_hierarchy_level INTO l_structured_hierarchy_level
    FROM FND_FLEX_VALUES_VL
    WHERE flex_value_set_id = l_flex_value_set_id
     AND flex_value = l_parent_flex_value;

    SELECT hierarchy_code INTO l_hierarchy_code
    FROM FND_FLEX_HIERARCHIES
    WHERE flex_value_set_id = l_flex_value_set_id
     AND hierarchy_id = l_structured_hierarchy_level;


    RETURN l_hierarchy_code;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN '';

  END DEV_HIERARCHY_CODE;

--=================================================================
--=================================================================
  --PROCEDIMIENTO
  --Reporte de Saldos y Consumos en Consignaci?n
  --Par?tros:
    --errbuf: Control de Ejecuci?n
    --errocode: Control de error
    --
  --
  --Autor: Ricardo Orozco Agudelo - Centro de Servicios Mundial S.A
  --Fecha Creaci?n: 05-02-2009
  --
  --Actualizado en:
    --1: 12-02-2009
      --Instrucci?n en c?ulo de inventario con filtro por owning_organization_id

  PROCEDURE DEV_REP_CONSUMOS_CONSIGNACION(
    errbuf OUT NOCOPY VARCHAR2
    , errcode OUT NOCOPY VARCHAR2
    , p_start_date IN VARCHAR2 --Fecha Inicial (OBLIGATORIO)
    , p_end_date IN VARCHAR2 --Fecha Final (OBLIGATORIO)
    , p_op_number VARCHAR2 --N?mero de Acuerdo
    , p_supplier_name IN VARCHAR2 --Nombre del Proveedor
    , p_organization_code IN VARCHAR2 --C?digo de la Organizaci?n de Inventario
    , p_item_code IN VARCHAR2 --C?digo de Art?lo

  ) IS

    l_start_qty_inventory NUMBER; --Almacena el inventario inicial por art?lo
    l_qty_onhand NUMBER; --Inventario a Mano
    l_qty_receive NUMBER; --Cantidad Recibida
    l_qty_consumption NUMBER; --Cantidad Consumida
    l_qty_not_consumption NUMBER; --Cantidad Pendiente
    l_end_qty_inventory NUMBER; --Calculo Inventario Final
    l_start_date DATE; --Fecha base para calculo de inventario inicial
    l_start_qty_inventory0 NUMBER; --Cantidad base para el calculo de inventario inicial
    p_start_date2 VARCHAR2(20);
    p_end_date2 VARCHAR2(20);

  BEGIN

    --Para controlar formato de fecha

    BEGIN
      p_start_date2 := TO_CHAR(TO_DATE(p_start_date,'YYYY/MM/DD HH24:MI:SS'),'DD-MON-YYYY HH24:MI:SS');
    EXCEPTION
      WHEN OTHERS THEN
        p_start_date2 := p_start_date;
    END;

    BEGIN
      p_end_date2 := TO_CHAR(TO_DATE(p_end_date,'YYYY/MM/DD HH24:MI:SS'),'DD-MON-YYYY HH24:MI:SS');
    EXCEPTION
      WHEN OTHERS THEN
        p_end_date2 := p_end_date;
    END;


    dbms_output.put_line('***************************************      REPORTE AVISO DE CONSUMOS     *******************************************');
    fnd_file.put_line(fnd_file.output,'***************************************      REPORTE AVISO DE CONSUMOS     *******************************************');
    dbms_output.put_line('');
    fnd_file.put_line(fnd_file.output,'');
    dbms_output.put_line('Fecha desde = '|| p_start_date2);
    fnd_file.put_line(fnd_file.output,'Fecha Reporte desde = '|| p_start_date2);
    dbms_output.put_line('Fecha hasta = '|| p_end_date2);
    fnd_file.put_line(fnd_file.output,'Fecha hasta = '|| p_end_date2);
    fnd_file.put_line(fnd_file.output,'Fecha generaci?n de reporte = '|| TO_CHAR(sysdate,'DD-MON-RRRR HH24:MI:SS'));

    IF p_op_number IS NOT NULL THEN
      dbms_output.put_line('Acuerdos de Compra = ' || p_op_number);
      fnd_file.put_line(fnd_file.output,'Acuerdos de Compra = ' || p_op_number);
    END IF;

    IF p_supplier_name IS NOT NULL THEN
      dbms_output.put_line('Proveedores = ' || p_supplier_name);
      fnd_file.put_line(fnd_file.output,'Proveedores = ' || p_supplier_name);
    END IF;

    IF p_organization_code IS NOT NULL THEN
      dbms_output.put_line('Organizaciones de Inventario = ' || p_organization_code);
      fnd_file.put_line(fnd_file.output,'Organizaciones de Inventario = ' || p_organization_code);
    END IF;

    IF p_item_code IS NOT NULL THEN
      dbms_output.put_line('Art?los = ' || p_item_code);
      fnd_file.put_line(fnd_file.output,'Art?los = ' || p_item_code);
    END IF;

    dbms_output.put_line('Hora Arranque = '|| TO_CHAR(sysdate,'DD-MON-RRRR HH24:MI:SS'));
    fnd_file.put_line(fnd_file.output,'Hora Arranque = '|| TO_CHAR(sysdate,'DD-MON-RRRR HH24:MI:SS'));
    dbms_output.put_line('');
    fnd_file.put_line(fnd_file.output,'');
    dbms_output.put_line('CODIGO PROVEEDOR'||CHR(9)||'PROVEEDOR'||CHR(9)||'ORGANIZACION DE INVENTARIO'||CHR(9)||'FECHA INICIAL'||CHR(9)||'FECHA FINAL'||CHR(9)||'# ACUERDO'||CHR(9)||'# LINEA ACUERDO'||CHR(9)||'COSTO'||CHR(9)||'MONEDA'||CHR(9)||'CODIGO PRODUCTO'||CHR(9)||'DESCRIPCION'||CHR(9)||'UDM'||CHR(9)||'INVENTARIO INICIAL'||CHR(9)||'RECIBOS'||CHR(9)||'CONSUMOS'||CHR(9)||'INVENTARIO FINAL'||CHR(9)||'CONSUMOS PENDIENTES'||CHR(9)||'INVENTARIO EN MANO');
    fnd_file.put_line(fnd_file.output,'CODIGO PROVEEDOR'||CHR(9)||'PROVEEDOR'||CHR(9)||'ORGANIZACION DE INVENTARIO'||CHR(9)||'FECHA INICIAL'||CHR(9)||'FECHA FINAL'||CHR(9)||'# ACUERDO'||CHR(9)||'# LINEA ACUERDO'||CHR(9)||'COSTO'||CHR(9)||'MONEDA'||CHR(9)||'CODIGO PRODUCTO'||CHR(9)||'DESCRIPCION'||CHR(9)||'UDM'||CHR(9)||'INVENTARIO INICIAL'||CHR(9)||'RECIBOS'||CHR(9)||'CONSUMOS'||CHR(9)||'INVENTARIO FINAL'||CHR(9)||'CONSUMOS PENDIENTES'||CHR(9)||'INVENTARIO EN MANO');


    FOR cr_acuerdos_de_compra IN
      (SELECT   pha.PO_HEADER_ID
        , pha.SEGMENT1 AS N_ACUERDO
        , pla.LINE_NUM AS LINEA
        , pla.po_line_id
        , pasl.USING_ORGANIZATION_ID AS ORGANIZATION_ID
        , pasl.VENDOR_ID
        , pasl.VENDOR_SITE_ID
        , pasl.ITEM_ID
        , pv.VENDOR_NAME
        , pv.segment1 AS VENDOR_CODE
        , msi.segment1 AS ITEM_CODE
        , mp.organization_code
        , msi.description AS ITEM_DESCRIPTION
        , msi.primary_unit_of_measure AS UDM
        ,pla.unit_price  AS COSTO
        ,pha.CURRENCY_CODE AS MONEDA

      FROM PO_APPROVED_SUPPLIER_LIST pasl
        , PO_ASL_ATTRIBUTES paa
        , PO_ASL_DOCUMENTS pad
        , PO_HEADERS_ALL pha
        , PO_LINES_ALL pla
        , PO_VENDORS pv
        , mtl_system_items_b msi
        , mtl_parameters mp
        , hr_organization_information hoi
      WHERE pasl.ASL_ID = paa.ASL_ID
        AND paa.ASL_ID = pad.ASL_ID
        AND (pasl.DISABLE_FLAG IS NULL OR pasl.DISABLE_FLAG = 'N')
        AND paa.CONSIGNED_FROM_SUPPLIER_FLAG = 'Y' --EN CONSIGNACION
        AND pad.DOCUMENT_HEADER_ID = pha.PO_HEADER_ID
        AND pha.PO_HEADER_ID = pla.PO_HEADER_ID
        AND pv.vendor_id = pha.vendor_id
        AND pad.DOCUMENT_LINE_ID = pla.PO_LINE_ID
        AND msi.inventory_item_id = pasl.ITEM_ID
        AND msi.organization_id = pasl.USING_ORGANIZATION_ID
        AND mp.organization_id = pasl.USING_ORGANIZATION_ID
        AND mp.organization_id = hoi.organization_id
        AND hoi.org_information_context = 'Accounting Information'
        AND TO_NUMBER(hoi.org_information1) = NVL(FND_PROFILE.VALUE('GL_SET_OF_BKS_ID'),0)
        AND mp.organization_code != '0MA'
        AND ( hoi.org_information1 != '2023' OR (hoi.org_information1 = '2023' AND mp.organization_code NOT LIKE 'E%'))

        --SE ANEXAN LOS PARAMETROS DEL CONCURRENTE DE AVISO DE CONSUMOS
        AND INSTR(pv.VENDOR_NAME, NVL(p_supplier_name,pv.VENDOR_NAME)) > 0
         --AND INSTR(mp.organization_code, NVL(p_organization_code,mp.organization_code)) > 0
        AND (p_organization_code IS NULL OR mp.organization_code = p_organization_code)
        --AND INSTR(pha.SEGMENT1, NVL(p_op_number,pha.SEGMENT1)) > 0
        AND (p_op_number IS NULL OR pha.SEGMENT1 = p_op_number)
        --AND INSTR(msi.segment1, NVL(p_item_code,msi.segment1)) > 0
        AND (p_item_code IS NULL OR msi.segment1 = p_item_code)
      ORDER BY N_ACUERDO, LINEA
      )
      LOOP

        BEGIN
          --Se busca el ?ltimo registro de inventario a mano para ese art?lo
          --Esta tabla almacena el inventario a mano al final del d?(inventory_date)
          SELECT MAX(inventory_date) INTO l_start_date
          FROM BOLINF.XXMU_HIST_INVENTORY_CONSIGNED
          WHERE inventory_item_id = cr_acuerdos_de_compra.ITEM_ID
            AND organization_id = cr_acuerdos_de_compra.ORGANIZATION_ID
            AND TRUNC(inventory_date) < TRUNC(TO_DATE(p_start_date2,'DD-MON-YYYY HH24:MI:SS')) --No puede ser la misma fecha para que tome las transacciones de todo el d?            AND po_header_id = cr_acuerdos_de_compra.PO_HEADER_ID
            AND po_line_id = cr_acuerdos_de_compra.po_line_id
            AND supplier_id = cr_acuerdos_de_compra.VENDOR_ID;

          --Se obtiene la cantidad base para el calculo del inventario
          --La cantidad corresponde con el inventario al finalizar el d?en la fecha indicada
          SELECT inventory_quantity INTO l_start_qty_inventory0
          FROM BOLINF.XXMU_HIST_INVENTORY_CONSIGNED
          WHERE inventory_item_id = cr_acuerdos_de_compra.ITEM_ID
            AND organization_id = cr_acuerdos_de_compra.ORGANIZATION_ID
            AND TRUNC(inventory_date) = TRUNC(l_start_date)
            AND po_header_id = cr_acuerdos_de_compra.PO_HEADER_ID
            AND po_line_id = cr_acuerdos_de_compra.po_line_id
            AND supplier_id = cr_acuerdos_de_compra.VENDOR_ID;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            --Se establece fecha por defecto
            l_start_date := TO_DATE('01-ENE-2008 23:59:59','DD-MON-YYYY HH24:MI:SS');
            l_start_qty_inventory0 := 0;
        END;

        --Obtener Inventario Inicial para el periodo indicado
        SELECT SUM (PRIMARY_QUANTITY) INTO l_start_qty_inventory
        FROM MTL_MATERIAL_TRANSACTIONS
        WHERE TRANSACTION_TYPE_ID IN (18,19,31,32,36,41,42,74,75)
          AND ORGANIZATION_ID = cr_acuerdos_de_compra.ORGANIZATION_ID
          AND OWNING_ORGANIZATION_ID = cr_acuerdos_de_compra.vendor_site_id
          AND INVENTORY_ITEM_ID = cr_acuerdos_de_compra.ITEM_ID
          AND TRUNC(CREATION_DATE) >  TRUNC(l_start_date)
          AND CREATION_DATE < TO_DATE(p_start_date2,'DD-MON-YYYY HH24:MI:SS');

        l_start_qty_inventory := NVL(l_start_qty_inventory,0) + NVL(l_start_qty_inventory0,0);

        --Obtener Cantidad recibida en el periodo indicado
        SELECT SUM (PRIMARY_QUANTITY) INTO l_qty_receive
        FROM MTL_MATERIAL_TRANSACTIONS
        WHERE TRANSACTION_TYPE_ID IN (18,19,31,32,36,41,42)
          AND INVENTORY_ITEM_ID = cr_acuerdos_de_compra.ITEM_ID
          AND ORGANIZATION_ID = cr_acuerdos_de_compra.ORGANIZATION_ID
          AND CREATION_DATE >= TO_DATE(p_start_date2,'DD-MON-YYYY HH24:MI:SS')
          AND CREATION_DATE <= TO_DATE(p_end_date2,'DD-MON-YYYY HH24:MI:SS')
          AND OWNING_ORGANIZATION_ID = cr_acuerdos_de_compra.vendor_site_id;

        l_qty_receive := NVL(l_qty_receive,0);


        --Obtener Consumos en el periodo indicado
        SELECT SUM(NET_QTY) INTO l_qty_consumption
        FROM MTL_CONSUMPTION_TRANSACTIONS mct
        WHERE mct.INVENTORY_ITEM_ID = cr_acuerdos_de_compra.ITEM_ID
          AND mct.ORGANIZATION_ID = cr_acuerdos_de_compra.ORGANIZATION_ID
          AND mct.OWNING_ORGANIZATION_ID = cr_acuerdos_de_compra.vendor_site_id
          AND CREATION_DATE >= TO_DATE(p_start_date2,'DD-MON-YYYY HH24:MI:SS')
          AND CREATION_DATE <= TO_DATE(p_end_date2,'DD-MON-YYYY HH24:MI:SS');

        l_qty_consumption := NVL(l_qty_consumption,0);


        --Obtener Consumos Pendientes
        SELECT SUM(mmt.PRIMARY_QUANTITY) INTO l_qty_not_consumption
        FROM MTL_MATERIAL_TRANSACTIONS mmt
        WHERE  mmt.INVENTORY_ITEM_ID = cr_acuerdos_de_compra.ITEM_ID
          AND mmt.ORGANIZATION_ID = cr_acuerdos_de_compra.ORGANIZATION_ID
          AND mmt.TRANSACTION_TYPE_ID IN (74,75)
          AND CREATION_DATE <= TO_DATE(p_end_date2,'DD-MON-YYYY HH24:MI:SS')
          AND mmt.transaction_date > SYSDATE - 360
          AND (
          (
            mmt.owning_organization_id = cr_acuerdos_de_compra.vendor_site_id
            /*AND mmt.TRANSACTION_ID NOT IN
              (SELECT mct.TRANSACTION_ID
              FROM MTL_CONSUMPTION_TRANSACTIONS mct
              WHERE  mct.INVENTORY_ITEM_ID = mmt.inventory_item_id
                AND CREATION_DATE <= TO_DATE(p_end_date2,'DD-MON-YYYY HH24:MI:SS')
                AND mct.ORGANIZATION_ID = mmt.organization_id
                AND mct.OWNING_ORGANIZATION_ID = mmt.owning_organization_id
              )
              */
              AND NOT EXISTS (SELECT 1
                FROM MTL_CONSUMPTION_TRANSACTIONS mct
                WHERE mct.transaction_id = mmt.transaction_id
                  AND CREATION_DATE <= TO_DATE(p_end_date2,'DD-MON-YYYY HH24:MI:SS')
                  AND mct.OWNING_ORGANIZATION_ID = mmt.owning_organization_id
                  AND mct.INVENTORY_ITEM_ID = mmt.inventory_item_id
                  AND mct.OWNING_ORGANIZATION_ID = mmt.owning_organization_id
              )
            )
            OR
            (
              mmt.owning_organization_id = mmt.organization_id
              AND mmt.xfr_owning_organization_id = cr_acuerdos_de_compra.vendor_site_id
              AND mmt.TRANSACTION_TYPE_ID = 75
              AND EXISTS
                (SELECT mct.TRANSACTION_ID
                FROM MTL_CONSUMPTION_TRANSACTIONS mct
                WHERE mmt.transaction_id = mct.transaction_id
                  AND mct.consumption_processed_flag = 'Y'
                )
            )
          );

        l_qty_not_consumption := NVL(l_qty_not_consumption,0);


        --Obtener Inventario Final para el periodo indicado
        SELECT SUM (PRIMARY_QUANTITY) INTO l_qty_onhand
        FROM MTL_MATERIAL_TRANSACTIONS
        WHERE TRANSACTION_TYPE_ID IN (18,19,31,32,36,41,42,74,75)
          AND INVENTORY_ITEM_ID = cr_acuerdos_de_compra.ITEM_ID
          AND ORGANIZATION_ID = cr_acuerdos_de_compra.ORGANIZATION_ID
          AND TRUNC(CREATION_DATE) > TRUNC(l_start_date)
          AND CREATION_DATE <= TO_DATE(p_end_date2,'DD-MON-YYYY HH24:MI:SS')
          AND OWNING_ORGANIZATION_ID = cr_acuerdos_de_compra.vendor_site_id;

        l_qty_onhand := NVL(l_qty_onhand,0) + NVL(l_start_qty_inventory0,0);


        l_end_qty_inventory := l_start_qty_inventory + l_qty_receive - l_qty_consumption;
        l_qty_not_consumption := ABS(l_qty_not_consumption);

        dbms_output.put_line(cr_acuerdos_de_compra.VENDOR_CODE||CHR(9)||cr_acuerdos_de_compra.VENDOR_NAME||CHR(9)||cr_acuerdos_de_compra.ORGANIZATION_CODE||CHR(9)||p_start_date||CHR(9)||p_end_date||CHR(9)||cr_acuerdos_de_compra.N_ACUERDO||CHR(9)||cr_acuerdos_de_compra.LINEA||CHR(9)||cr_acuerdos_de_compra.COSTO||CHR(9)||cr_acuerdos_de_compra.MONEDA||CHR(9)||cr_acuerdos_de_compra.ITEM_CODE||CHR(9)||cr_acuerdos_de_compra.ITEM_DESCRIPTION||CHR(9)||cr_acuerdos_de_compra.UDM||CHR(9)||l_start_qty_inventory||CHR(9)||l_qty_receive|| chr(9)||l_qty_consumption||CHR(9)||l_end_qty_inventory||chr(9)||l_qty_not_consumption||CHR(9)||l_qty_onhand);
        fnd_file.put_line(fnd_file.output,cr_acuerdos_de_compra.VENDOR_CODE||CHR(9)||cr_acuerdos_de_compra.VENDOR_NAME||CHR(9)||cr_acuerdos_de_compra.ORGANIZATION_CODE||CHR(9)||p_start_date||CHR(9)||p_end_date||CHR(9)||cr_acuerdos_de_compra.N_ACUERDO||CHR(9)||cr_acuerdos_de_compra.LINEA||CHR(9)||cr_acuerdos_de_compra.COSTO||CHR(9)||cr_acuerdos_de_compra.MONEDA||CHR(9)||cr_acuerdos_de_compra.ITEM_CODE||CHR(9)||cr_acuerdos_de_compra.ITEM_DESCRIPTION||CHR(9)||cr_acuerdos_de_compra.UDM||CHR(9)||l_start_qty_inventory||CHR(9)||l_qty_receive|| chr(9)||l_qty_consumption||CHR(9)||l_end_qty_inventory||chr(9)||l_qty_not_consumption||CHR(9)||l_qty_onhand);

      END LOOP;



      dbms_output.put_line('');
      fnd_file.put_line(fnd_file.output,'');
      dbms_output.put_line('Hora finalizaci?n = '|| TO_CHAR(sysdate,'DD-MON-RRRR HH24:MI:SS'));
      fnd_file.put_line(fnd_file.output,'Hora finalizaci?n = '|| TO_CHAR(sysdate,'DD-MON-RRRR HH24:MI:SS'));

  END DEV_REP_CONSUMOS_CONSIGNACION;



--=================================================================
--=================================================================
  --FUNCION XXMU_DEV_IS_NUMBER
  --Valida si la cadena de caracteres es num?ca o no
  --Par?tros:
  --  strNumber IN VARCHAR2
  --Retorno:
  --
  --Autor: Camilo Andr?Cardona Arango
  --Fecha de Creaci?n: 28-JUL-2009
  --
  --Actualizado en:

  FUNCTION DEV_IS_NUMBER(strNumber IN VARCHAR2) RETURN VARCHAR2 IS

    tmpNumber NUMBER;

  BEGIN
    tmpNumber := TO_NUMBER(strNumber);
    return ('TRUE');
  EXCEPTION WHEN OTHERS THEN
    RETURN ('FALSE');
  END DEV_IS_NUMBER;

--=================================================================
--=================================================================
  --FUNCION DIAS_DOMINGOS_FESTIVOS_F
  --Retorna el n?mero de dias domingo y festivos de un rango de fechas
  --Par?tros:
  --  fecha_inicial DATE
  --  fecha_final DATE
  --Retorno:
  -- l_cont_dom_fest
  --Autor: Camilo Andr?Cardona Arango
  --Fecha de Creaci?n: 17-FEB-2010
  --
  --Actualizado en:

  FUNCTION DIAS_DOMINGOS_FESTIVOS_F(fecha_inicial DATE, fecha_final DATE) RETURN NUMBER AS


  l_cont_dom_fest       integer;  -- contador de domingos y festivos
  l_total_dias          integer;  -- total de d? entre el rango de fechas
  l_festivo             integer;

  l_fecha               DATE;     -- fecha para evaluar si es domingo o festivo

  BEGIN

    l_cont_dom_fest := 0;
    l_total_dias    := fecha_final-fecha_inicial;
    l_fecha         := NULL;

    FOR x IN 1..l_total_dias LOOP
      l_fecha := fecha_inicial + x;

      IF to_char(l_fecha,'d') = '1' THEN
        l_cont_dom_fest := l_cont_dom_fest + 1;
      END IF;

      -- Consulta en la tabla donde se configuran los d?festivos
      BEGIN

        SELECT 1
        INTO l_festivo
        FROM apps.bom_calendar_exceptions
        WHERE calendar_code = 'GM_ZZ_CAL1'
        AND TRUNC(exception_date) = TRUNC(l_fecha);

        IF l_festivo = 1 THEN
          l_cont_dom_fest := l_cont_dom_fest + 1;
        END IF;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;


    END LOOP;


    RETURN l_cont_dom_fest;

  EXCEPTION
    WHEN OTHERS THEN
    RETURN 'Se ha presentado un error en la funci?n';

  END DIAS_DOMINGOS_FESTIVOS_F;

--=================================================================
--=================================================================
  --FUNCION DIAS_FESTIVOS_F
  --Retorna el n?mero de dias festivos de un rango de fechas
  --Par?tros:
  --  fecha_inicial DATE
  --  fecha_final DATE
  --Retorno:
  -- l_cont_dom_fest
  --Autor: Camilo Andr?Cardona Arango
  --Fecha de Creaci?n: 17-FEB-2010
  --
  --Actualizado en:

  FUNCTION DIAS_FESTIVOS_F(fecha_inicial DATE, fecha_final DATE) RETURN NUMBER AS


  l_cont_fest       integer;  -- contador de domingos y festivos
  l_total_dias          integer;  -- total de d? entre el rango de fechas
  l_festivo             integer;

  l_fecha               DATE;     -- fecha para evaluar si es domingo o festivo

  BEGIN

    l_cont_fest := 0;
    l_total_dias    := fecha_final-fecha_inicial;
    l_fecha         := NULL;

    FOR x IN 1..l_total_dias LOOP
      l_fecha := fecha_inicial + x;

      -- Consulta en la tabla donde se configuran los d?festivos
      BEGIN

        SELECT 1
        INTO l_festivo
        FROM apps.bom_calendar_exceptions
        WHERE calendar_code = 'GM_ZZ_CAL1'
        AND TRUNC(exception_date) = TRUNC(l_fecha);

        IF l_festivo = 1 THEN
          l_cont_fest := l_cont_fest + 1;
        END IF;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;


    END LOOP;


    RETURN l_cont_fest;

  EXCEPTION
    WHEN OTHERS THEN
    RETURN 'Se ha presentado un error en la funci?n';

  END DIAS_FESTIVOS_F;


  --***************************************************************
  --Obtiene el inventario en mano por articulo y organizacion
  FUNCTION INV_EN_MANO_X_ARTICULO (
      p_inventory_item_id IN NUMBER
    , p_organization_id IN NUMBER
    , p_subinventory_code IN VARCHAR2 DEFAULT NULL
    , p_lot_number IN VARCHAR2 DEFAULT NULL
    , p_locator_id IN NUMBER DEFAULT 0
  ) RETURN NUMBER
  AS
    l_cantidad NUMBER;

  BEGIN

    SELECT SUM(primary_transaction_quantity)
    INTO l_cantidad
    FROM mtl_onhand_quantities_detail
    WHERE inventory_item_id = p_inventory_item_id
      AND organization_id = p_organization_id
      AND (p_subinventory_code IS NULL OR subinventory_code = p_subinventory_code)
      AND (p_lot_number IS NULL OR lot_number = p_lot_number)
      AND (p_locator_id = 0 OR locator_id = p_locator_id);

    RETURN NVL(l_cantidad,0);

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 0;
    WHEN OTHERS THEN
      RETURN -9999;
  END INV_EN_MANO_X_ARTICULO;


  --***************************************************************
  --Obtiene el inventario en transito por articulo y organizacion
  FUNCTION INV_EN_TRANSITO_ARTICULO (
      p_inventory_item_id IN NUMBER
    , p_from_org_id IN NUMBER DEFAULT 0 --Organizacion origen
    , p_to_org_id IN NUMBER DEFAULT 0 --Organizacion destino
  ) RETURN NUMBER
  AS
    l_cantidad NUMBER;

  BEGIN

    SELECT SUM (rsl.quantity_shipped - rsl.quantity_received)
    INTO l_cantidad
    FROM rcv_shipment_lines rsl
    WHERE rsl.shipment_line_status_code IN ('EXPECTED', 'PARTIALLY RECEIVED')
      AND rsl.mmt_transaction_id IS NOT NULL
      AND rsl.source_document_code IN ('INVENTORY', 'REQ')
      AND rsl.item_id = p_inventory_item_id
      AND (p_from_org_id = 0 OR rsl.from_organization_id = p_from_org_id)
      AND (p_to_org_id = 0 OR rsl.to_organization_id = p_to_org_id);

    RETURN NVL(l_cantidad,0);

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 0;
    WHEN OTHERS THEN
      RETURN -9999;
  END INV_EN_TRANSITO_ARTICULO;

  --***************************************************************
  --Obtiene la cantidad en produccion por articulo, organizacion y estado del batch
  FUNCTION CANT_EN_PRODUCCION_ARTICULO (
      p_inventory_item_id IN NUMBER
    , p_organization_id IN NUMBER --Organizacion
    , p_batch_status IN NUMBER --estado del batch
  ) RETURN NUMBER
  AS
    l_cantidad NUMBER;

  BEGIN

    SELECT SUM(gmd.plan_qty)
      --, gmd.dtl_um
    INTO l_cantidad
    FROM gme_batch_header gbh
      , gme_material_details gmd
    WHERE gmd.inventory_item_id = p_inventory_item_id
      AND gbh.organization_id = p_organization_id
      AND gbh.batch_status = p_batch_status
      AND gmd.batch_id = gbh.batch_id
      AND gmd.line_type = 1
      AND gmd.line_no = 1;

    RETURN NVL(l_cantidad,0);

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 0;
    WHEN OTHERS THEN
      RETURN -9999;
  END CANT_EN_PRODUCCION_ARTICULO;

  --*******************************************************************

  /*
  * PROCEDURE              : IMPRIME_TEXTO
  * Descripcion            : Proceso Para impresion por PANTALLA o DEBUG
  * Parametros De Entrada  : p_cadena  : texto a mostrar
  *                          p_tipo    : P Pantalla (FND_FILE.PUT_LINE)
  *                                      D Debug    (DBMS_OUTPUT.PUT_LINE)
  *                                      A Ambos    (FND_FILE.PUT_LINE y DBMS_OUTPUT.PUT_LINE)
  * Parametros De Salida   : N.A.
  * Creado por             : Alejandro Pavony M - Interfaces
  * Fecha                  : 14-Oct-2010
  * Historia de modificaciones
  * Fecha       Autor   Modificacion
  * -           -       -
  */

  PROCEDURE IMPRIME_TEXTO ( p_tipo   IN VARCHAR2
                          , p_cadena IN VARCHAR2 ) AS
  BEGIN


     CASE p_tipo
        WHEN 'P' THEN  -- Pantalla
            FND_FILE.PUT_LINE(FND_FILE.OUTPUT, p_cadena );
        WHEN 'D' THEN      -- Debug
            DBMS_OUTPUT.PUT_LINE(p_cadena);
        WHEN 'A' THEN      -- All
            FND_FILE.PUT_LINE(FND_FILE.OUTPUT, p_cadena );
            DBMS_OUTPUT.PUT_LINE(p_cadena);
     END CASE;

    EXCEPTION
      WHEN case_not_found THEN
           DBMS_OUTPUT.PUT_LINE(p_cadena);

  END IMPRIME_TEXTO;

  --=================================================================
  --=================================================================
  /*FUNCTION - BATCH_CANTIDAD_X_FORMULA
    Descripci?n:
        -OBTIENE POR INGREDIENTE DE BATCH LA CANTIDAD PLANEADA A PARTIR DE LA FORMULA Y LA CANTIDAD REAL CONSUMIDA
        -Consulta la cantidad real producida en el batch y calcula para un ingrediente la cantidad
        que por formula se debe utilizar en la elaboraci?n del producto
    Parametros:
        p_batch_id: Id del Batch de Producci?n
        p_organization_id: Id de la organizaci?n
        p_formulaline_id: Id de la l?a en la formula
    Autor: Ricardo Orozco - 20101217
  */

  FUNCTION BATCH_CANTIDAD_X_FORMULA(
      p_batch_id IN NUMBER
    , p_organization_id IN NUMBER
    , p_formulaline_id IN NUMBER
  )
  RETURN NUMBER
  AS
    l_recipe_validity_rule_id gme_batch_header.recipe_validity_rule_id%TYPE;
    l_recipe_id gmd_recipe_validity_rules.recipe_id%TYPE;
    l_routing_id gme_batch_header.routing_id%TYPE;
    l_formula_id gme_batch_header.formula_id%TYPE;
    l_imprimir CHAR(1) := 'D';
    l_scale NUMBER;
    l_qty fm_matl_dtl.qty%TYPE;
    l_detail_uom fm_matl_dtl.detail_uom%TYPE;
    l_scale_type fm_matl_dtl.scale_type%TYPE;
    l_contribute_yield_ind fm_matl_dtl.contribute_yield_ind%TYPE;
    l_scale_multiple fm_matl_dtl.scale_multiple%TYPE;
    l_scale_rounding_variance fm_matl_dtl.scale_rounding_variance%TYPE;
    l_rounding_direction fm_matl_dtl.rounding_direction%TYPE;
    l_inventory_item_id fm_matl_dtl.inventory_item_id%TYPE;
    l_qty_formula NUMBER;
    l_qty_actual NUMBER;
    l_line_type gme_material_details.line_type%TYPE;
    l_line_no gme_material_details.line_no%TYPE;

    x_in_table gmd_common_scale.scale_tab;
    x_out_table gmd_common_scale.scale_tab;
    x_primaries varchar2(10):='OUTPUTS';
    x_status varchar2(100);
    x_message	VARCHAR2(2000);
    x_temp	NUMBER;
    x_cantidad NUMBER;

    COMMON_SCALE_FAILURE EXCEPTION;
    HEADER_DATA EXCEPTION;
    FORMULA_DATA EXCEPTION;
    QTY_DATA EXCEPTION;
    NO_FORMULALINE_ID EXCEPTION;

  BEGIN

    --p_batch_id := 8852790;
    --p_scale := 60;
    --p_organization_id := 109;
    --l_line_no := 1;
    --l_line_type := -1;

    IF p_formulaline_id IS NULL OR p_batch_id IS NULL OR p_organization_id IS NULL THEN
      RAISE NO_FORMULALINE_ID;
    END IF;

    --Se obtienen los datos del batch desde la cabecera
    BEGIN
      SELECT b.recipe_validity_rule_id
        , a.recipe_id
        , b.routing_id
        , b.formula_id
        , gmd.line_no
        , gmd.line_type

        INTO l_recipe_validity_rule_id
          , l_recipe_id
          , l_routing_id
          , l_formula_id
          , l_line_no
          , l_line_type

      FROM gme_batch_header b
        , gmd_recipe_validity_rules a
        , gme_material_details gmd

      WHERE b.recipe_validity_rule_id = a.recipe_validity_rule_id
        AND b.batch_id = p_batch_id
        AND gmd.batch_id = b.batch_id
        AND gmd.formulaline_id = p_formulaline_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE HEADER_DATA;
    END;
    --xxmu_dev_report_pk.imprime_texto(l_imprimir,'Formula: ' || l_formula_id || ' - Receta: ' || l_recipe_id || ' - Ruta: ' ||  l_routing_id || ' - Regla Validaci?n: ' || l_recipe_validity_rule_id);


    --********************************************************
    --Se obtienen los datos de cantidad de formula para el fabricado y cantidad real
    BEGIN
      --Se obtiene la cantidad total
      SELECT SUM(xxmu_dev_report_pk.convert_uom_item(fmd.detail_uom, msi.primary_unit_of_measure, fmd.inventory_item_id) * fmd.qty)
        INTO l_qty_formula
      FROM fm_matl_dtl fmd
        , mtl_system_items_b msi
      WHERE fmd.formula_id = l_formula_id
        AND fmd.line_type IN (1,2) --Producto y Subproducto
        AND msi.inventory_item_id = fmd.inventory_item_id
        AND msi.organization_id = fmd.organization_id;

      SELECT SUM(xxmu_dev_report_pk.convert_uom_item(gmd.dtl_um, msi.primary_unit_of_measure, gmd.inventory_item_id) * gmd.actual_qty)
        INTO l_qty_actual
      FROM gme_material_details gmd
        , mtl_system_items_b msi
      WHERE gmd.batch_id = p_batch_id
        AND gmd.line_type IN (1,2)
        AND msi.inventory_item_id = gmd.inventory_item_id
        AND msi.organization_id = gmd.organization_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE QTY_DATA;
    END;

    --********************************************************
    --Se obtienen los datos por l?a desde la formula
    BEGIN

      --xxmu_dev_report_pk.imprime_texto(l_imprimir, 'Formula: ' || l_formula_id || ' - Linea: ' || l_line_no || ' - tipo: ' || l_line_type || ' - Linea Formula: ' || p_formulaline_id);

      SELECT qty
        , detail_uom
        , scale_type
        , contribute_yield_ind
        , scale_multiple
        , scale_rounding_variance
        , rounding_direction
        , inventory_item_id

        INTO l_qty
          , l_detail_uom
          , l_scale_type
          , l_contribute_yield_ind
          , l_scale_multiple
          , l_scale_rounding_variance
          , l_rounding_direction
          , l_inventory_item_id

      FROM fm_matl_dtl
      WHERE formula_id = l_formula_id
        AND formulaline_id = p_formulaline_id;

      x_in_table(1).line_no    := l_line_no;
      x_in_table(1).line_type  := l_line_type;
      x_in_table(1).inventory_item_id    := l_inventory_item_id;
      x_in_table(1).qty        := l_qty;
      x_in_table(1).detail_uom := l_detail_uom;
      x_in_table(1).scale_type := l_scale_type;
      x_in_table(1).contribute_yield_ind := l_contribute_yield_ind ;
      x_in_table(1).scale_multiple := l_scale_multiple;
      x_in_table(1).scale_rounding_variance := l_scale_rounding_variance;
      x_in_table(1).rounding_direction := l_rounding_direction;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE FORMULA_DATA;
    END;

    --xxmu_dev_report_pk.imprime_texto(l_imprimir,'DESDE FORMULA >> '||'qty: ' || l_qty || ' - detail_uom: ' || l_detail_uom
    --  || ' - scale_type: ' ||  l_scale_type || ' - contribute_yield_ind: ' || l_contribute_yield_ind || ' - scale_multiple: ' || l_scale_multiple
    --  || ' - scale_rounding_variance: ' || l_scale_rounding_variance || ' - rounding_direction: ' || l_rounding_direction || ' - l_inventory_item_id: ' || l_inventory_item_id);

    --********************************************************

    --Factor por el cual se calcula la cantidad
    --l_scale := p_scale / 100;
    l_scale := l_qty_actual/l_qty_formula;

    IF l_scale_type > 0 THEN

      gmd_common_scale.scale(p_scale_tab     => x_in_table,
        p_orgn_id       => p_organization_id,
        p_scale_factor  => l_scale,
        p_primaries     => x_primaries,
        x_scale_tab     => x_out_table,
        x_return_status => x_status);

      IF x_status <> 'S' THEN
          FND_MSG_PUB.GET(p_msg_index     => 1,
                        p_data          => x_message,
                        p_encoded       => 'F',
                        p_msg_index_out => x_temp);
          RAISE COMMON_SCALE_FAILURE;

      END IF;
    ELSE
      x_out_table := x_in_table;
    END IF;

    --xxmu_dev_report_pk.imprime_texto(l_imprimir, 'LINEA FORMULA ID: ' || p_formulaline_id || ' - Escala: ' || l_scale  ||' - CANTIDAD FORMULA: '|| l_qty ||' - CANTIDAD CALCULADA: ' || x_out_table(1).qty );

    x_cantidad := x_out_table(1).qty;

    RETURN x_cantidad;

  EXCEPTION

    WHEN COMMON_SCALE_FAILURE THEN
      --xxmu_dev_report_pk.imprime_texto(l_imprimir,x_message);
      RETURN NULL;

    WHEN HEADER_DATA THEN
      --xxmu_dev_report_pk.imprime_texto(l_imprimir,'No se encontraron datos del batch');
      RETURN NULL;

    WHEN FORMULA_DATA THEN
      --xxmu_dev_report_pk.imprime_texto(l_imprimir,'No se encontraron datos de la Formula');
      RETURN NULL;

    WHEN QTY_DATA THEN
      --xxmu_dev_report_pk.imprime_texto(l_imprimir,'No pudo calcular la cantidad por formula y/o real');
      RETURN NULL;

    WHEN NO_FORMULALINE_ID THEN
      --xxmu_dev_report_pk.imprime_texto(l_imprimir,'Falta informaci?n de parametros');
      RETURN NULL;

    WHEN OTHERS THEN
      --xxmu_dev_report_pk.imprime_texto(l_imprimir,'ERROR: ' || SQLCODE);
      --xxmu_dev_report_pk.imprime_texto(l_imprimir,SQLERRM);
      RETURN -1;

  END BATCH_CANTIDAD_X_FORMULA;

  --=================================================================
  --=================================================================
  /*PROCEDIMIENTO - XXMU_HIST_NIVEL_SERIVICIO
    Descripci?n:
      -- OBTIENE LA INFORMACI? DE PEDIDOS Y NOTAS DE ENTREGAS POR PERIODO NECESARIOS PARA EL CALCULO DE NIVEL DE SERVICIO
      -- Realiza en proceso en dos etapas
        --primero obtiene la informaci?n de los pedidos y los almacena en la tabla BOLINF.XXMU_NIVEL_SERVICIO_PEDIDO (Solo almacena los ?ltimos 3 periodos)
        --segundo obtine la informaci?n de Notas de Entrega relacionadas con los Pedidos
    Par?tros:
      p_errorbuf: String con mensaje de resultado de ejecuci?n
      p_errorcode: C?digo del error de resultado de ejecuci?n (NULL si finaliza correctamente)
      p_periodo: C?digo del periodo a calcular (Si no se especifica, se calcula por defecto el periodo correspondiente al mes anterior a la fecha de ejecuci?n del procedimiento)
  */

  PROCEDURE HIST_NIVEL_SERIVICIO_OM(
      errbuf OUT NOCOPY VARCHAR2
    , errcode OUT NOCOPY VARCHAR2
    , p_periodo IN VARCHAR2 DEFAULT NULL
  )
  AS

    l_fecha DATE;
    l_fecha_desde DATE;
    l_fecha_hasta DATE;
    l_periodo VARCHAR2(10);
    l_no_borrar_periodo1 VARCHAR2(10);
    l_no_borrar_periodo2 VARCHAR2(10);
    l_imprimir CHAR(1) := 'P';

  BEGIN

    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, '***********   XXMU_HIST_NIVEL_SERIVICIO   **********');
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, '');

    IF p_periodo IS NOT NULL THEN
      BEGIN
        SELECT START_DATE INTO l_fecha
        FROM GL_PERIODS
        WHERE PERIOD_SET_NAME = 'CONTABLE'
          AND PERIOD_NUM <= 12
          AND PERIOD_NAME = p_periodo;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          errbuf := SQLERRM;
          errcode := SQLCODE;
      END;
    ELSE
      l_fecha := '01-'||TO_CHAR(ADD_MONTHS(SYSDATE, -1),'MON-YYYY');
    END IF;

    l_fecha_desde := l_fecha;
    l_fecha_hasta := TRUNC(LAST_DAY(l_fecha_desde) + 1);
    l_periodo := TO_CHAR(l_fecha_desde, 'MON-YYYY');
    l_no_borrar_periodo1 := TO_CHAR(ADD_MONTHS(l_fecha_desde, -1),'MON-YYYY');
    l_no_borrar_periodo2 := TO_CHAR(ADD_MONTHS(l_fecha_desde, -2),'MON-YYYY');


    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Fecha desde: ' || l_fecha_desde);
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Fecha hasta: ' || l_fecha_hasta);
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Periodo: ' || l_periodo);

    --**************************************************************
    --SE OBTIENE LA INFORMACION POR PERIODO PARA LOS PEDIDOS
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Eliminando datos hist?ricos de PEDIDOS del periodo: ' || l_periodo || ' - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
    DELETE FROM BOLINF.XXMU_NIVEL_SERVICIO_PEDIDO
    WHERE periodo = l_periodo
      AND EXISTS
        (SELECT 1
          FROM BOLINF.XXMU_DEV_PARAMETROS_REPORTES xdp
          WHERE BOLINF.XXMU_NIVEL_SERVICIO_PEDIDO.ORG_ID = TO_NUMBER(xdp.parameter_qty)
            AND xdp.report_name = 'GM - OM - Nivel de Servicio CGP-119'
            AND xdp.parameter_name = 'ORG_ID');

    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Ingresando datos hist?ricos de PEDIDOS del periodo: ' || l_periodo || ' - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
    INSERT INTO BOLINF.XXMU_NIVEL_SERVICIO_PEDIDO
    SELECT /*ORDERER*/

        (SELECT hp.party_name FROM hz_parties hp, hz_cust_accounts hca
          WHERE hca.party_id = hp.party_id AND hca.cust_account_id = ss.sold_to_org_id AND ROWNUM = 1
        ) AS nombre_cliente
      , (SELECT hca.account_number FROM hz_cust_accounts hca
          WHERE hca.cust_account_id = ss.sold_to_org_id AND ROWNUM = 1
      ) AS codigo_cliente
      , (SELECT ha.class_code FROM hz_code_assignments ha, hz_cust_accounts hca
          WHERE hca.cust_account_id = ss.sold_to_org_id
            AND ha.owner_table_id = hca.party_id
            AND ha.owner_table_name = 'HZ_PARTIES'
            AND ha.class_category =
              (SELECT parameter_qty
                FROM BOLINF.XXMU_DEV_PARAMETROS_REPORTES
                WHERE report_name = 'GM - OM - Nivel de Servicio CGP-119'
                  AND parameter_name = 'CLAS_CLIENTE'
                  AND company = ou.company)--apps.FND_PROFILE.VALUE('GM_ZZ_CLASIFICADOR_CLIENTE')
            AND ROWNUM = 1
      ) AS Canal_Cliente
      , dd.order_number AS pedido
      , tt.name AS tipo_pedido
      , msi.segment1 AS codigo_producto
      , msi.description AS descripcion_producto
      , NVL(SUBSTR(dd.attribute14,10), 'REGIONAL NO ASIGNADA') AS regional
      , org.name AS dodega_de_despacho
      , ss.ordered_quantity AS cantidad_pedida
      , ss.order_quantity_uom AS udm
      , ss.unit_selling_price AS precio_unitario
      , xxmu_dev_report_pk.CONVERT_UOM_ITEM(ss.order_quantity_uom, 'gal' , msi.inventory_item_id) AS convert_gal
      , xxmu_dev_report_pk.CONVERT_UOM_ITEM(ss.order_quantity_uom, 'und' , msi.inventory_item_id) AS convert_und
      , ss.cancelled_quantity AS cantidad_cancelada
      , cc.meaning AS causal_cancelacion
      , dd.creation_date AS fecha_creacion
      , dd.ordered_date AS fecha_pedido
      , ss.request_date AS fecha_requerida --a nivel de l?a
      , ss.schedule_ship_date AS fecha_prog_envio
      , ss.schedule_arrival_date AS fecha_prog_llegada
      --, DECODE(ss.source_type_code,'INTERNAL','Interno','EXTERNAL','Externo', ss.source_type_code) AS tipo_origen
      , ss.attribute10 AS causal_no_cumplimiento
      , (SELECT MAX(creation_date)
        FROM oe_order_holds_all ooho
        WHERE header_id = dd.header_id
          AND line_id IS NULL
          --Poner condicion de tipo de retencion tambien en liberacion, dias y contador
      ) AS fecha_retencion_pedido
      , (SELECT MAX(ohr.creation_date)
        FROM oe_order_holds_all ooh
          , oe_hold_releases ohr
        WHERE ooh.header_id = dd.header_id
          AND ooh.line_id IS NULL
          AND ooh.released_flag = 'Y'
          AND ohr.hold_release_id = ooh.hold_release_id
          AND ooh.creation_date = (SELECT MAX(creation_date) FROM oe_order_holds_all WHERE header_id = dd.header_id AND line_id IS NULL)
      ) AS fecha_liberacion_pedido
      , mre.reservation_quantity AS cantidad_reservada
      , oos.name AS origen_pedido
      , fu.user_name AS creador_por
      , ss.actual_shipment_date AS fecha_envio
      , (SELECT rct.trx_number
        FROM ra_customer_trx_all rct
          , ra_cust_trx_types_all rctt
        WHERE rct.ct_reference = TO_CHAR(dd.order_number)
          AND ROWNUM = 1
          AND rctt.cust_trx_type_id = rct.cust_trx_type_id
          AND rctt.type = 'CM'
      ) AS numero_NC
      , (SELECT SUM(rctl.quantity_credited)
        FROM ra_customer_trx_all rct
          , ra_customer_trx_lines_all rctl
          , ra_cust_trx_types_all rctt
        WHERE rctl.interface_line_attribute6 = ss.line_id
          AND rct.ct_reference = TO_CHAR(dd.order_number)
          AND rctl.customer_trx_id = rct.customer_trx_id
          AND rctl.line_type = 'LINE'
          AND rctt.cust_trx_type_id = rct.cust_trx_type_id
          AND rctt.type = 'CM'
      ) AS cantidad_NC
      , (SELECT al.meaning
        FROM ra_customer_trx_all rct
          , ra_cust_trx_types_all rctt
          , ar_lookups al
        WHERE rct.ct_reference = TO_CHAR(dd.order_number)
          AND ROWNUM = 1
          AND rctt.cust_trx_type_id = rct.cust_trx_type_id
          AND rctt.type = 'CM'
          AND al.lookup_type = 'CREDIT_MEMO_REASON'
          AND al.lookup_code = rct.reason_code
      ) AS causal_NC
      , ss.line_number AS linea
      , ss.shipment_number AS nro_envio_linea
      , ss.fulfilled_quantity AS cantidad_entregada
      , oll.meaning AS estado_linea
      , dd.request_date AS fecha_requerida_pedido
      , olh.meaning AS estado_pedido
      , (SELECT SUM(NVL(orel.creation_date,SYSDATE) - ohold.creation_date)
        FROM oe_order_holds_all ohold
          , oe_hold_releases orel
        WHERE ohold.header_id = dd.header_id
          AND ohold.line_id IS NULL
          AND orel.hold_release_id(+) = ohold.hold_release_id
      ) AS dias_de_retencion
      , (SELECT COUNT(1)
        FROM oe_order_holds_all ohold
          , oe_hold_releases orel
        WHERE ohold.header_id = dd.header_id
          AND ohold.line_id IS NULL
          AND orel.hold_release_id(+) = ohold.hold_release_id

      ) AS numero_de_retenciones
      , NVL(arll.meaning, arlh.meaning) AS motivo_devolucion
      , (SELECT ship_loc.city
        FROM hz_cust_site_uses_all ship_su
          , hz_cust_acct_sites_all ship_cas
          , hz_party_sites ship_ps
          , hz_locations ship_loc
        WHERE ship_su.site_use_id = dd.ship_to_org_id
          AND ship_cas.cust_acct_site_id = ship_su.cust_acct_site_id
          AND ship_ps.party_site_id = ship_cas.party_site_id
          AND ship_loc.location_id = ship_ps.location_id
          AND ROWNUM = 1
      ) AS ciudad_envio
      , (SELECT NVL(ship_loc.state, ship_loc.province)
        FROM hz_cust_site_uses_all ship_su
          , hz_cust_acct_sites_all ship_cas
          , hz_party_sites ship_ps
          , hz_locations ship_loc
        WHERE ship_su.site_use_id = dd.ship_to_org_id
          AND ship_cas.cust_acct_site_id = ship_su.cust_acct_site_id
          AND ship_ps.party_site_id = ship_cas.party_site_id
          AND ship_loc.location_id = ship_ps.location_id
          AND ROWNUM = 1
      ) AS departamento_envio
      , (SELECT ordered_quantity
        FROM oe_order_lines_history olh
        WHERE line_id = ss.line_id
          AND hist_type_code != 'SPLIT'--'CANCELLATION'
          AND hist_creation_date =
            (SELECT MIN(hist_creation_date)
            FROM  oe_order_lines_history
            WHERE line_id = ss.line_id
            AND hist_type_code != 'SPLIT'--'CANCELLATION'
          )
          AND ROWNUM = 1
      ) AS cantidad_pedida_inicial

      , ss.header_id
      , ss.line_id
      , msi.inventory_item_id
      , msi.organization_id
      , dd.org_id
      , l_periodo
      , fu2.user_name AS actualizado_por

    FROM oe_order_headers_all dd
      , (
        SELECT hao.organization_id
          , xdp.company
        FROM hr_all_organization_units hao
          , BOLINF.XXMU_DEV_PARAMETROS_REPORTES xdp
        WHERE ORGANIZATION_ID = TO_NUMBER(xdp.parameter_qty)
          AND xdp.report_name = 'GM - OM - Nivel de Servicio CGP-119'
          AND xdp.parameter_name = 'ORG_ID'
      ) ou
      , oe_order_lines_all ss
      , oe_transaction_types_tl tt
      , mtl_system_items_b msi
      , hr_all_organization_units org
      , oe_order_lines_history oolh
      , oe_reasons oer
      , oe_lookups cc --Causal cancelacion
      , mtl_reservations mre
      , oe_order_sources oos
      , fnd_user fu
      , fnd_user fu2
      , oe_lookups oll
      , oe_lookups olh
      , ar_lookups arlh --Motivo devolucion cabecera
      , ar_lookups arll --Motivo devolucion linea

    WHERE dd.org_id = ou.organization_id
      AND ss.header_id = dd.header_id
      AND tt.transaction_type_id = dd.order_type_id
      AND tt.language = USERENV('LANG')
      AND msi.inventory_item_id = ss.inventory_item_id
      AND msi.organization_id = ss.ship_from_org_id
      AND org.organization_id = ss.ship_from_org_id
      AND oolh.header_id (+) = ss.header_id
      AND oolh.line_id (+) = ss.line_id
      AND oolh.hist_type_code (+) = 'CANCELLATION'
      AND oer.reason_id (+) = oolh.reason_id
      AND oer.reason_type (+) = 'CANCEL_CODE'
      AND cc.lookup_code (+) = oer.reason_code
      AND mre.demand_source_line_id (+) = ss.line_id
      AND oos.order_source_id(+) = dd.order_source_id
      AND fu.user_id = dd.created_by
      AND fu2.user_id = ss.last_updated_by
      AND oll.lookup_type = 'LINE_FLOW_STATUS'
      AND oll.lookup_code = ss.flow_status_code
      AND olh.lookup_type(+) = 'FLOW_STATUS'
      AND olh.lookup_code(+) = dd.flow_status_code
      AND arlh.lookup_type(+) = 'CREDIT_MEMO_REASON'
      AND arlh.lookup_code(+) = dd.return_reason_code
      AND arll.lookup_type(+) = 'CREDIT_MEMO_REASON'
      AND arll.lookup_code(+) = ss.return_reason_code

      AND ss.request_date >= l_fecha_desde
      AND ss.request_date < l_fecha_hasta;

    COMMIT;
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Finaliza proceso de PEDIDOS del periodo: ' || l_periodo || ' - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));


    --**************************************************************
    --SE OBTIENE LA INFORMACION PARA ENTREGAS
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Eliminando datos hist?ricos de ENTREGAS del periodo: ' || l_periodo || ' - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
    DELETE FROM BOLINF.XXMU_NIVEL_SERVICIO_ENTREGA
    WHERE periodo = l_periodo
      AND EXISTS
        (SELECT 1
          FROM BOLINF.XXMU_DEV_PARAMETROS_REPORTES xdp
          WHERE BOLINF.XXMU_NIVEL_SERVICIO_ENTREGA.ORG_ID = TO_NUMBER(xdp.parameter_qty)
            AND xdp.report_name = 'GM - OM - Nivel de Servicio CGP-119'
            AND xdp.parameter_name = 'ORG_ID');

    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Ingrsando datos hist?ricos de ENTREGAS del periodo: ' || l_periodo || ' - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
    INSERT INTO BOLINF.XXMU_NIVEL_SERVICIO_ENTREGA
    SELECT wdd.source_header_id
      , wdd.source_line_id
      , wdd.source_header_number
      , wdd.org_id

      , hl.city AS ciudad_envio
      , hl.state AS departamento
      , wda.delivery_id AS NDE
      , MAX(wts.actual_arrival_date) AS fecha_llegada_real
      , SUM(wdd.requested_quantity) AS cantidad_pedida
      , SUM(wdd.shipped_quantity) AS cantidad_enviada
      , wdd.requested_quantity_uom AS udm
      , wdd.inventory_item_id
      , wnd.creation_date AS fecha_nota_entrega
      , wnd.confirm_date AS fecha_confirmacion
      , (SELECT rct.trx_number
        FROM ra_customer_trx_all rct
          , ra_customer_trx_lines_all rctl
        WHERE rct.interface_header_attribute1 = wdd.source_header_number
          --AND interface_header_attribute3 = TO_CHAR(wda.delivery_id)
          AND rct.org_id = wdd.org_id
          AND rctl.customer_trx_id = rct.customer_trx_id
          AND rctl.interface_line_attribute6 = wdd.source_line_id
          AND ROWNUM = 1
      ) AS numero_factura
      , (SELECT rct.trx_date
        FROM ra_customer_trx_all rct
          , ra_customer_trx_lines_all rctl
        WHERE rct.interface_header_attribute1 = wdd.source_header_number
        --AND interface_header_attribute3 = TO_CHAR(wda.delivery_id)
          AND rct.org_id = wdd.org_id
          AND rctl.customer_trx_id = rct.customer_trx_id
          AND rctl.interface_line_attribute6 = wdd.source_line_id
          AND ROWNUM = 1
      ) AS fecha_factura
      , wt.name AS viaje
      , hp_trans.party_name AS transportista
      , SUM(wdd.net_weight) AS peso_neto
      , SUM(wdd.gross_weight) AS  peso_bruto
      , (SELECT SUM(rctl.quantity_ordered)
        FROM ra_customer_trx_all rct
          , ra_customer_trx_lines_all rctl
          , ra_cust_trx_types_all rctt
        WHERE rctl.interface_line_attribute6 = wdd.source_line_id
          AND rct.ct_reference = TO_CHAR(wdd.source_header_number)
          AND rctl.customer_trx_id = rct.customer_trx_id
          AND rctl.line_type = 'LINE'
          AND rctt.cust_trx_type_id = rct.cust_trx_type_id
          AND rctt.type = 'INV'
      ) AS cantidad_Factura
      , wt.vehicle_num_prefix AS viaje_wms
      , l_periodo

    FROM wsh_delivery_assignments wda
      , wsh_delivery_details wdd
      , wsh_new_deliveries wnd
      , wsh_delivery_legs wdl
      , wsh_trip_stops wts
      , hz_locations hl
      , wsh_trips wt
      , wsh_carriers wc
      , hz_parties hp_trans
      , (
        SELECT *
        FROM hr_all_organization_units hao
          , BOLINF.XXMU_DEV_PARAMETROS_REPORTES xdp
        WHERE ORGANIZATION_ID = TO_NUMBER(xdp.parameter_qty)
          AND xdp.report_name = 'GM - OM - Nivel de Servicio CGP-119'
          AND xdp.parameter_name = 'ORG_ID'
      ) ou
      , oe_order_lines_all ss

    WHERE wdd.delivery_detail_id = wda.delivery_detail_id
      AND wdd.org_id = ou.organization_id
      AND wnd.delivery_id(+) = wda.delivery_id
      AND wnd.delivery_id         = wdl.delivery_id(+)
      AND wdl.drop_off_stop_id    = wts.stop_id(+)
      AND hl.location_id (+) = wnd.ultimate_dropoff_location_id
      AND wt.trip_id(+) = wts.trip_id
      AND wnd.carrier_id = wc.carrier_id(+)
      AND wc.carrier_id = hp_trans.party_id(+)
      AND ss.line_id = wdd.source_line_id
      AND ss.header_id = wdd.source_header_id

      AND ss.request_date >= l_fecha_desde
      AND ss.request_date < l_fecha_hasta

    GROUP BY wdd.source_header_id, wdd.source_line_id, wdd.source_header_number, wdd.org_id, hl.city, hl.state, wda.delivery_id, wdd.requested_quantity_uom, wdd.inventory_item_id, wnd.creation_date, wnd.confirm_date, wt.name, hp_trans.party_name, wt.vehicle_num_prefix;

    COMMIT;
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Finaliza proceso de ENTREGAS del periodo: ' || l_periodo || ' - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));


    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Inicia proceso para Eliminar hist?rico con m?de tres meses de antiguedad - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
    DELETE FROM BOLINF.XXMU_NIVEL_SERVICIO_PEDIDO
    WHERE periodo != l_periodo
      AND periodo != l_no_borrar_periodo1
      AND periodo != l_no_borrar_periodo2
      AND EXISTS
        (SELECT 1
          FROM BOLINF.XXMU_DEV_PARAMETROS_REPORTES xdp
          WHERE BOLINF.XXMU_NIVEL_SERVICIO_PEDIDO.ORG_ID = TO_NUMBER(xdp.parameter_qty)
            AND xdp.report_name = 'GM - OM - Nivel de Servicio CGP-119'
            AND xdp.parameter_name = 'ORG_ID');

    DELETE FROM BOLINF.XXMU_NIVEL_SERVICIO_ENTREGA
    WHERE periodo != l_periodo
      AND periodo != l_no_borrar_periodo1
      AND periodo != l_no_borrar_periodo2
      AND EXISTS
        (SELECT 1
          FROM BOLINF.XXMU_DEV_PARAMETROS_REPORTES xdp
          WHERE BOLINF.XXMU_NIVEL_SERVICIO_ENTREGA.ORG_ID = TO_NUMBER(xdp.parameter_qty)
            AND xdp.report_name = 'GM - OM - Nivel de Servicio CGP-119'
            AND xdp.parameter_name = 'ORG_ID');

    COMMIT;

    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Finaliza proceso para Eliminar hist?rico con m?de tres meses de antiguedad - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      errbuf := SQLERRM;
      errcode := SQLCODE;
  END HIST_NIVEL_SERIVICIO_OM;

  --=================================================================
  --=================================================================
  /*FUNCION - GET_COSTO_TOTAL
    Descripci?n:
      --CALCULA EL COSTO PROMEDIO PARA UN ARTICULO DE INVENTARIO EN UNA FECHA Y TIPO DE COSTO ESPECIFICO
    Par?tros:
      p_inventory_item_id: Id del art?lo
      p_organization_id: Id de la organizaci?n de Inventario
      p_transaction_date: Fecha para la cual se calcula el costo
      p_cost_method: C?digo para el tipo de costo (COPM, IFRS)

  */

  FUNCTION GET_COSTO_TOTAL(
      p_inventory_item_id NUMBER
    , p_organization_id NUMBER
    , p_transaction_date DATE
    , p_cost_method VARCHAR2
  ) RETURN NUMBER AS

  l_return_status VARCHAR2(1) := NULL;
  l_msg_count NUMBER := NULL;
  l_msg_data VARCHAR2(500) := NULL;
  l_cost_method VARCHAR2(10) := p_cost_method;--NULL; --'COPP';
  l_cost_component_class_id NUMBER := 1; --codigo del componente del costo
  l_cost_analysis_code VARCHAR2(3) := NULL; --'DIR';
  l_total_cost NUMBER := 0;
  l_no_of_rows NUMBER := 0;
  l_return NUMBER := NULL;
  BEGIN
  --l_return := apps.gmf_cmcommon.get_process_item_cost(p_api_version => 1, p_init_msg_list => NULL, x_return_status => l_return_status, x_msg_count => l_msg_count, x_msg_data => l_msg_data, p_inventory_item_id => p_inventory_item_id, p_organization_id => p_organization_id, p_transaction_date => p_transaction_date, p_detail_flag => 1, p_cost_method => p_cost_method, p_cost_component_class_id => l_cost_component_class_id, p_cost_analysis_code => l_cost_analysis_code, x_total_cost => l_total_cost, x_no_of_rows => l_no_of_rows);

       l_return      := gmf_cmcommon.get_process_item_cost(p_api_version             => 1,
                                                           p_init_msg_list           => NULL,
                                                           x_return_status           => l_return_status,
                                                           x_msg_count               => l_msg_count,
                                                           x_msg_data                => l_msg_data,
                                                           p_inventory_item_id       => p_inventory_item_id,
                                                           p_organization_id         => p_organization_id,
                                                           p_transaction_date        => p_transaction_date,
                                                           p_detail_flag             => 1,
                                                           p_cost_method             => l_cost_method,
                                                           p_cost_component_class_id => l_cost_component_class_id,
                                                           p_cost_analysis_code      => l_cost_analysis_code,
                                                           x_total_cost              => l_total_cost,
                                                           x_no_of_rows              => l_no_of_rows);


    RETURN(l_total_cost);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END GET_COSTO_TOTAL;

  --=================================================================
  --=================================================================
  /*FUNCION - GET_CATEGORIA_COSTOS
    Descripci?n:
      --OBTIENE LA CATEGORIA DE COSTOS ASOCIADA A UN ARTICULO Y ORGANIZACION
    Par?tros:
      p_inventory_item_id: Id del art?lo
      p_organization_id: Id de la organizaci?n de Inventario
      p_segmento: Segmento a obtener de la categoria
        '1' : segment1
        '2' : segment2
        '3' : segment3

  */

  FUNCTION GET_CATEGORIA_COSTOS(
      p_inventory_item_id NUMBER
    , p_organization_id NUMBER
    , p_segmento VARCHAR2
  ) RETURN VARCHAR2
  AS

    x_dato VARCHAR2(40);
    l_dato1 VARCHAR2(40);
    l_dato2 VARCHAR2(40);
    l_dato3 VARCHAR2(40);

  BEGIN

    SELECT mc.segment1, mc.segment2, mc.segment3
    INTO l_dato1, l_dato2, l_dato3
    FROM mtl_item_categories mic
      , mtl_categories_b_kfv mc

    WHERE mic.category_set_id = 1100000062
      AND mic.inventory_item_id = p_inventory_item_id
      AND mic.organization_id = p_organization_id
      AND mc.category_id = mic.category_id;

    IF p_segmento = '1' THEN
      x_dato := l_dato1;
    ELSE
      IF p_segmento = '2' THEN
        x_dato := l_dato2;
      ELSE
        IF p_segmento = '3' THEN
          x_dato := l_dato3;
        ELSE
          x_dato := NULL;
        END IF;
      END IF;
    END IF;

    RETURN x_dato;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END GET_CATEGORIA_COSTOS;

  --=================================================================
  --=================================================================
  /*PROCEDIMIENTO - ACT_HIST_NIVEL_SERVICIO_OM
    Descripci?n:
      -- ACTUALIZA LA INFORMACI? PARA EL CALCULO DE NIVEL DE SERVICIO (PEDIDOS Y ENTREGAS)
      -- Se actualizan los campos para el periodo inmediatamente anterior a la fecha de ejecuci?n del PL/SQL.
        -- Campos - Pedidos
          -- Cantidad NC
          -- Numero NC
          -- Causal NC
        -- Campos - Entregas
          -- Fecha de Llegada Real

    Par?tros:
      errbuf: String con mensaje de resultado de ejecuci?n
      errcode: C?digo del error de resultado de ejecuci?n (NULL si finaliza correctamente)

  */

  PROCEDURE ACT_HIST_NIVEL_SERVICIO_OM(
      errbuf OUT NOCOPY VARCHAR2
    , errcode OUT NOCOPY VARCHAR2
    , p_operating_unit_id IN NUMBER DEFAULT NULL
  )
  AS

    l_fecha_desde DATE;
    l_fecha_hasta DATE;
    l_periodo VARCHAR2(10);
    l_imprimir CHAR(1) := 'P';
    l_fecha_llegada_real DATE;
    l_numero_nc ra_customer_trx_all.trx_number%TYPE;
    l_cantidad_nc ra_customer_trx_lines_all.quantity_credited%TYPE;
    l_causal_nc ar_lookups.meaning%TYPE;

  BEGIN

    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, '***********   XXMU_UPDATE_HIST_NIVELSERIVICIO   **********');
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, '');

    l_fecha_desde := '01-'||TO_CHAR(ADD_MONTHS(SYSDATE, -1),'MON-YYYY');
    l_fecha_hasta := TRUNC(LAST_DAY(l_fecha_desde) + 1);
    l_periodo := TO_CHAR(l_fecha_desde, 'MON-YYYY');

    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Fecha desde: ' || l_fecha_desde);
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Fecha hasta: ' || l_fecha_hasta);
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'Periodo: ' || l_periodo);

    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, '***********************++****************************');
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'ACTUALIZANDO INFORMACION DEL PEDIDO');

    FOR cr_update_h IN
    (
      SELECT SUM(rctl.quantity_credited) AS cantidad_nc
        , rct.trx_number AS numero_nc
        , al.meaning AS causal_nc
        , ns.periodo
        , ns.org_id
        , ns.header_id
        , ns.line_id

      FROM ra_customer_trx_all rct
        , ra_customer_trx_lines_all rctl
        , ra_cust_trx_types_all rctt
        , ar_lookups al
        , BOLINF.XXMU_NIVEL_SERVICIO_PEDIDO ns

      WHERE rctl.interface_line_attribute6 = ns.line_id
        AND rct.ct_reference = TO_CHAR(ns.pedido)
        AND rct.customer_trx_id = rctl.customer_trx_id
        AND rctl.line_type = 'LINE'
        AND rctt.cust_trx_type_id = rct.cust_trx_type_id
        AND rctt.type = 'CM'
        AND al.lookup_type = 'CREDIT_MEMO_REASON'
        AND al.lookup_code = rct.reason_code
        AND ns.periodo = l_periodo
        AND rctl.interface_line_attribute6 = ns.line_id
        AND rct.ct_reference = TO_CHAR(ns.pedido)
        AND (p_operating_unit_id IS NULL OR ns.org_id = p_operating_unit_id)

      GROUP BY rct.trx_number, al.meaning, ns.periodo, ns.org_id, ns.header_id, ns.line_id
    )
    LOOP


      UPDATE BOLINF.XXMU_NIVEL_SERVICIO_PEDIDO
      SET numero_nc = cr_update_h.numero_nc
        , cantidad_nc = cr_update_h.cantidad_nc
        , causal_nc = cr_update_h.causal_nc
      WHERE periodo = cr_update_h.periodo
        AND org_id = cr_update_h.org_id
        AND header_id = cr_update_h.header_id
        AND line_id = cr_update_h.line_id;

    END LOOP;

    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, '***********************++****************************');
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'FINALIZA INFORMACION DEL PEDIDO');
    COMMIT;


    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, '***********************++****************************');
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'ACTUALIZANDO INFORMACION DE LA ENTREGA');

    FOR cr_actualiza_entrega IN
    (
      SELECT MAX(wts.actual_arrival_date) AS fecha_llegada_real
        , ns.periodo
        , ns.org_id
        , ns.source_header_id
        , ns.source_line_id
      FROM BOLINF.XXMU_NIVEL_SERVICIO_ENTREGA ns
        , wsh_delivery_details wdd
        , wsh_delivery_assignments wda
        , wsh_new_deliveries wnd
        , wsh_delivery_legs wdl
        , wsh_trip_stops wts

      WHERE ns.periodo = l_periodo
        AND (p_operating_unit_id IS NULL OR ns.org_id = p_operating_unit_id)
        AND wdd.source_line_id = ns.source_line_id
        AND wdd.source_header_id = ns.source_header_id
        AND wdd.org_id = ns.org_id
        AND wdd.delivery_detail_id = wda.delivery_detail_id
        AND wnd.delivery_id(+) = wda.delivery_id
        AND wnd.delivery_id         = wdl.delivery_id(+)
        AND wdl.drop_off_stop_id    = wts.stop_id(+)

      GROUP BY ns.periodo, ns.org_id, ns.source_header_id, ns.source_line_id

    )
    LOOP

      UPDATE BOLINF.XXMU_NIVEL_SERVICIO_ENTREGA
      SET fecha_llegada_real = cr_actualiza_entrega.fecha_llegada_real
      WHERE periodo = cr_actualiza_entrega.periodo
        AND org_id = cr_actualiza_entrega.org_id
        AND source_header_id = cr_actualiza_entrega.source_header_id
        AND source_line_id = cr_actualiza_entrega.source_line_id;

    END LOOP;

    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, '***********************++****************************');
    XXMU_DEV_REPORT_PK.IMPRIME_TEXTO(l_imprimir, 'FINALIZA INFORMACION DE LA ENTREGA');
    COMMIT;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      errbuf := SQLERRM;
      errcode := SQLCODE;

  END ACT_HIST_NIVEL_SERVICIO_OM;


  --=================================================================
  --=================================================================
  /*FUNCION - AR_DESCUENTO_FACTURA
    Descripci?n:
      --Obtiene los descuentos por factura de AR cargados desde el pedido OM
    Par?tros:
      p_order_number: Numero del Pedido en OM
      p_trx_number: Numero de la factura en AR
      p_org_id: Id de la unidad operativa
  */

  FUNCTION AR_DESCUENTO_FACTURA(
      p_order_number NUMBER
    , p_trx_number VARCHAR2
    , p_org_id NUMBER
  ) RETURN NUMBER
  AS

    descuento_linea NUMBER;
    descuento_cabecera NUMBER;

  BEGIN

    --Descuento por lineas
    SELECT SUM((ool.unit_list_price - ool.unit_selling_price) * ool.invoiced_quantity)
    INTO descuento_linea
    FROM oe_order_headers_all ooh
      , oe_order_lines_all ool
      , oe_price_adjustments opa
      , ra_customer_trx_lines_all rctl
      , ra_customer_trx_all rct

    WHERE ool.header_id = ooh.header_id
      AND ool.unit_selling_price != ool.unit_list_price
      AND opa.header_id = ool.header_id
      AND opa.line_id = ool.line_id
      AND opa.list_line_type_code = 'DIS'
      AND ool.flow_status_code = 'CLOSED'
      AND ooh.order_number = p_order_number
      AND rctl.interface_line_attribute6 = ool.line_id
      AND rct.customer_trx_id = rctl.customer_trx_id
      AND rctl.line_type = 'LINE'
      AND rct.ct_reference = TO_CHAR(ooh.order_number)
      AND rct.trx_number = p_trx_number
      AND rct.org_id = ooh.org_id
      AND rct.org_id = p_org_id;


    SELECT SUM((ool.unit_list_price - ool.unit_selling_price) * ool.invoiced_quantity)
    INTO descuento_cabecera
    FROM oe_order_headers_all ooh
      , oe_order_lines_all ool
      , oe_price_adjustments opa
      , ra_customer_trx_lines_all rctl
      , ra_customer_trx_all rct

    WHERE ool.header_id = ooh.header_id
      AND ool.unit_selling_price != ool.unit_list_price
      AND opa.header_id = ool.header_id
      AND opa.line_id IS NULL
      AND opa.list_line_type_code = 'DIS'
      AND ool.flow_status_code = 'CLOSED'
      AND ooh.order_number = p_order_number
      AND rctl.interface_line_attribute6 = ool.line_id
      AND rct.customer_trx_id = rctl.customer_trx_id
      AND rctl.line_type = 'LINE'
      AND rctl.inventory_item_id IS NOT NULL
      AND rct.ct_reference = TO_CHAR(ooh.order_number)
      AND rct.trx_number = p_trx_number
      AND rct.org_id = ooh.org_id
      AND rct.org_id = p_org_id;

    RETURN NVL(descuento_linea,0) + NVL(descuento_cabecera,0);

  END AR_DESCUENTO_FACTURA;
  --=================================================================
  --=================================================================

  PROCEDURE INVENTARIO_DIARIO_MLS(
      errbuf OUT NOCOPY VARCHAR2
    , errcode OUT NOCOPY VARCHAR2
  )

  IS

    l_inventory_date DATE;
    l_kg NUMBER;
    l_convert_to_kg NUMBER;
    l_und NUMBER;
    l_convert_to_und NUMBER;
    l_gal NUMBER;
    l_convert_to_gal NUMBER;
    l_cm3 NUMBER;
    l_convert_to_cm3 NUMBER;
    l_imprimir VARCHAR2(1) DEFAULT 'A';

  BEGIN

    l_inventory_date := TRUNC(SYSDATE);

    xxmu_dev_report_pk.imprime_texto(l_imprimir, '**********************INICIO PROCESO DE INVENTARIO DIARIO MLS**********************');
    xxmu_dev_report_pk.imprime_texto(l_imprimir, '');
    xxmu_dev_report_pk.imprime_texto(l_imprimir, 'Fecha : ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
    xxmu_dev_report_pk.imprime_texto(l_imprimir, '');

    FOR cr_inv IN (
      SELECT moq.organization_id
        , moq.inventory_item_id
        , msi.primary_unit_of_measure AS primary_uom
        , SUM(xxmu_dev_report_pk.convert_uom_item(moq.transaction_uom_code, msi.primary_unit_of_measure, moq.inventory_item_id) * moq.transaction_quantity) AS primary_quantity

      FROM mtl_onhand_quantities_detail moq
        , mtl_system_items_b msi
        , (SELECT TO_NUMBER(parameter_qty) AS organization_id
          FROM BOLINF.XXMU_DEV_PARAMETROS_REPORTES
          WHERE report_name = 'MLS - INV - Inventario Diario'
        ) org
      WHERE moq.organization_id = org.organization_id
        AND msi.inventory_item_id = moq.inventory_item_id
        AND msi.organization_id = moq.organization_id

      GROUP BY moq.organization_id
        , moq.inventory_item_id
        , msi.primary_unit_of_measure
    )
    LOOP

      --Se calculan los totales por cada unidad de medida
      l_convert_to_und := xxmu_dev_report_pk.convert_uom_item(cr_inv.primary_uom, 'und', cr_inv.inventory_item_id);
      l_und := l_convert_to_und * cr_inv.primary_quantity;

      l_convert_to_gal := xxmu_dev_report_pk.convert_uom_item(cr_inv.primary_uom, 'gal', cr_inv.inventory_item_id);
      l_gal := l_convert_to_gal * cr_inv.primary_quantity;

      l_convert_to_kg := xxmu_dev_report_pk.convert_uom_item(cr_inv.primary_uom, 'kg', cr_inv.inventory_item_id);
      l_kg := l_convert_to_kg * cr_inv.primary_quantity;

      l_convert_to_cm3 := xxmu_dev_report_pk.convert_uom_item(cr_inv.primary_uom, 'cm3', cr_inv.inventory_item_id);

      --Se obtienen las dimensiones del articulo
      IF l_convert_to_cm3 = 0 THEN
        BEGIN
          SELECT (unit_length * unit_width * unit_height)
          INTO l_convert_to_cm3
          FROM mtl_system_items_b
          WHERE inventory_item_id = cr_inv.inventory_item_id
            AND organization_id = cr_inv.organization_id
            AND unit_length IS NOT NULL
            AND unit_width IS NOT NULL
            AND unit_height IS NOT NULL;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          l_convert_to_cm3 := 0;
        END;
      END IF;

      l_cm3 := l_convert_to_cm3 * cr_inv.primary_quantity;

      INSERT INTO BOLINF.XXMU_DAILY_INVENTORY_MLS (organization_id
        , inventory_date
        , inventory_item_id
        , primary_quantity
        , primary_uom
        , quantity_to_und
        , quantity_to_kg
        , quantity_to_gal
        , quantity_to_cm3)
      VALUES (cr_inv.organization_id
        , l_inventory_date
        , cr_inv.inventory_item_id
        , cr_inv.primary_quantity
        , cr_inv.primary_uom
        , l_und
        , l_kg
        , l_gal
        , l_cm3);
      COMMIT;

    END LOOP;

  EXCEPTION
  WHEN OTHERS THEN
    errbuf := SQLERRM;
    errcode := SQLCODE;
    xxmu_dev_report_pk.imprime_texto(l_imprimir, 'Error: ' || errcode || ' - ' || errbuf);
  END INVENTARIO_DIARIO_MLS;

  --=================================================================
  --=================================================================

/*=================================================================
  =================================================================
  FUNCION GET_CATEGORIA_MERCADEO

  Descripci?n:
    Esta funci?n permite obtener un segmento de la categoria de mercadeo de un art?lo.

  Par?tros:
     - p_inventory_item_id: id del art?lo
     - p_segmento: n?mero del segmento de la categoria de mercadeo que se desea retornar.
     - p_campo: determina si se retorna el c?digo o la descripci?n del segemnto - 'C' ? 'D'

  Retorno: x_segemento

  Autor: Camilo Andr?Cardona Arango - Centro de Servicios Mundial S.A.
  Fecha de Creaci?n: 08-JUL-2011

  Actualizado en:

  =================================================================
  =================================================================
*/
 FUNCTION GET_CATEGORIA_MERCADEO(p_inventory_item_id  IN NUMBER
                                , p_segmento          IN NUMBER
                                , p_campo             IN CHAR
                                 )
  RETURN VARCHAR2 IS

    x_segmento VARCHAR2(240);

    l_cod_segment1        VARCHAR2(40);
    l_cod_segment2        VARCHAR2(40);
    l_cod_segment3        VARCHAR2(40);
    l_cod_segment4        VARCHAR2(40);
    l_cod_segment5        VARCHAR2(40);
    l_cod_segment6        VARCHAR2(40);
    l_cod_segment7        VARCHAR2(40);
    l_desc_segment1       VARCHAR2(240);
    l_desc_segment2       VARCHAR2(240);
    l_desc_segment3       VARCHAR2(240);
    l_desc_segment4       VARCHAR2(240);
    l_desc_segment5       VARCHAR2(240);
    l_desc_segment6       VARCHAR2(240);
    l_desc_segment7       VARCHAR2(240);

    CURSOR c_segmentos (p_inventory_item_id NUMBER) IS
      SELECT  INVENTORY_ITEM_ID
        ,mc.SEGMENT1
        ,mc.SEGMENT2
        ,mc.SEGMENT3
        ,mc.SEGMENT4
        ,mc.SEGMENT5
        ,mc.SEGMENT6
        ,mc.SEGMENT7

        ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre
          FROM FND_ID_FLEX_SEGMENTS_VL fifsv
            , FND_FLEX_VALUE_SETS ffv
            , FND_FLEX_VALUES_VL ffvv
          WHERE APPLICATION_ID = 401
            AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID
            AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code)
            AND fifsv.SEGMENT_NUM = 10
            AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT1
            AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
            AND ROWNUM = 1
        ) AS DESC_SEGMENT1
        ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre
          FROM FND_ID_FLEX_SEGMENTS_VL fifsv
            , FND_FLEX_VALUE_SETS ffv
            , FND_FLEX_VALUES_VL ffvv
          WHERE APPLICATION_ID = 401
            AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID
            AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code)
            AND fifsv.SEGMENT_NUM = 20
            AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT2
            AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
            AND ROWNUM = 1
          ) AS DESC_SEGMENT2
        ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre
          FROM FND_ID_FLEX_SEGMENTS_VL fifsv
            , FND_FLEX_VALUE_SETS ffv
            , FND_FLEX_VALUES_VL ffvv
          WHERE APPLICATION_ID = 401
            AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID
            AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code)
            AND fifsv.SEGMENT_NUM = 30
            AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT3
            AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
            AND ROWNUM = 1
          ) AS DESC_SEGMENT3
        ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre
          FROM FND_ID_FLEX_SEGMENTS_VL fifsv
            , FND_FLEX_VALUE_SETS ffv
            , FND_FLEX_VALUES_VL ffvv
          WHERE APPLICATION_ID = 401
            AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID
            AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code)
            AND fifsv.SEGMENT_NUM = 40
            AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT4
            AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
            AND ROWNUM = 1

          ) AS DESC_SEGMENT4
        ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre
          FROM FND_ID_FLEX_SEGMENTS_VL fifsv
            , FND_FLEX_VALUE_SETS ffv
            , FND_FLEX_VALUES_VL ffvv
          WHERE APPLICATION_ID = 401
            AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID
            AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code)
            AND fifsv.SEGMENT_NUM = 50
            AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT5
            AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
           AND ROWNUM = 1

          ) AS DESC_SEGMENT5
        ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre
          FROM FND_ID_FLEX_SEGMENTS_VL fifsv
            , FND_FLEX_VALUE_SETS ffv
            , FND_FLEX_VALUES_VL ffvv
          WHERE APPLICATION_ID = 401
            AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID
            AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code)
            AND fifsv.SEGMENT_NUM = 60
            AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT6
            AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
            AND ROWNUM = 1

          ) AS DESC_SEGMENT6
        ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre
          FROM FND_ID_FLEX_SEGMENTS_VL fifsv
            , FND_FLEX_VALUE_SETS ffv
            , FND_FLEX_VALUES_VL ffvv
          WHERE APPLICATION_ID = 401
            AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID
            AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code)
            AND fifsv.SEGMENT_NUM = 70
            AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT7
            AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
            AND ROWNUM = 1

          ) AS DESC_SEGMENT7

      FROM  MTL_ITEM_CATEGORIES mic
        , MTL_CATEGORIES mc
        , (SELECT XXMU_DEV_HIERARCHY_CODE() AS HIERARCHY_CODE
          FROM DUAL
        ) hc
      WHERE mic.CATEGORY_ID = mc.CATEGORY_ID
      AND mic.ORGANIZATION_ID = (SELECT ORGANIZATION_ID FROM MTL_PARAMETERS WHERE ORGANIZATION_CODE = '0MA')
      AND mic.CATEGORY_SET_ID = (
          SELECT category_set_id
          FROM MTL_CATEGORY_SETS_B
          WHERE structure_id = (
            SELECT id_flex_num
            FROM FND_ID_FLEX_STRUCTURES_VL
            WHERE application_id = 401
              AND id_flex_code = 'MCAT'
              AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code
            )
          )
      AND INVENTORY_ITEM_ID = p_inventory_item_id
      ;

  BEGIN

    x_segmento := NULL;

    FOR rec_segmento IN c_segmentos(p_inventory_item_id) LOOP

      l_cod_segment1       := rec_segmento.segment1;
      l_cod_segment2       := rec_segmento.segment2;
      l_cod_segment3       := rec_segmento.segment3;
      l_cod_segment4       := rec_segmento.segment4;
      l_cod_segment5       := rec_segmento.segment5;
      l_cod_segment6       := rec_segmento.segment6;
      l_cod_segment7       := rec_segmento.segment7;
      l_desc_segment1      := rec_segmento.desc_segment1;
      l_desc_segment2      := rec_segmento.desc_segment2;
      l_desc_segment3      := rec_segmento.desc_segment3;
      l_desc_segment4      := rec_segmento.desc_segment4;
      l_desc_segment5      := rec_segmento.desc_segment5;
      l_desc_segment6      := rec_segmento.desc_segment6;
      l_desc_segment7      := rec_segmento.desc_segment7;

      IF p_campo = 'C' THEN
        CASE
          WHEN p_segmento = 1 THEN x_segmento := l_cod_segment1;
          WHEN p_segmento = 2 THEN x_segmento := l_cod_segment2;
          WHEN p_segmento = 3 THEN x_segmento := l_cod_segment3;
          WHEN p_segmento = 4 THEN x_segmento := l_cod_segment4;
          WHEN p_segmento = 5 THEN x_segmento := l_cod_segment5;
          WHEN p_segmento = 6 THEN x_segmento := l_cod_segment6;
          WHEN p_segmento = 7 THEN x_segmento := l_cod_segment7;
        END CASE;
      ELSE
        IF p_campo = 'D' THEN
          CASE
            WHEN p_segmento = 1 THEN x_segmento := l_desc_segment1;
            WHEN p_segmento = 2 THEN x_segmento := l_desc_segment2;
            WHEN p_segmento = 3 THEN x_segmento := l_desc_segment3;
            WHEN p_segmento = 4 THEN x_segmento := l_desc_segment4;
            WHEN p_segmento = 5 THEN x_segmento := l_desc_segment5;
            WHEN p_segmento = 6 THEN x_segmento := l_desc_segment6;
            WHEN p_segmento = 7 THEN x_segmento := l_desc_segment7;
          END CASE;
        END IF;
      END IF;


    END LOOP;


    RETURN x_segmento;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;

  END GET_CATEGORIA_MERCADEO;

  --=================================================================
  --=================================================================
  --FUNCION LEAD TIME

  --SUMA N DIAS A UNA FECHA Y RETORNA LA CANTIDAD DE DIAS REALMENTE LABORALES
  --CALCULA LOS DIAS EN TRANSITO INCLUYENDO DIAS NO HABILES
  --Creada por:
    --Camilo Cardona, Ricardo Orozco - 26-JUL-2011
  --Parametros:
    -- p_fecha_inicial : Es la fecha base
    -- p_dias : Cantidad de dias habiles o laborales a sumar
    -- p_dias_no_laborales : cadena de caracteres separados por coma con los dias de la semana considerados como no logisticos o no laborales
      --1 : DOMINGO
      --2 : LUNES
      --3 : MARTES
      --4 : MIERCOLES
      --5 : JUEVES
      --6 : VIERNES
      --7 : SABADO

  FUNCTION LEAD_TIME(
    p_fecha_inicial IN DATE
    , p_dias IN NUMBER
    , p_dias_no_laborales IN VARCHAR2
  )RETURN NUMBER
  IS


    l_fecha_inicial DATE;
    l_fecha_final DATE;
    l_dias NUMBER;
    l_reales NUMBER := 0;
    i NUMBER := 0;
    l_desc_dia VARCHAR2(5);
    l_dias_festivos NUMBER;

  BEGIN

    l_fecha_inicial := p_fecha_inicial;
    l_dias := p_dias;

    WHILE i < l_dias
    LOOP

      l_reales := l_reales + 1;
      l_desc_dia := TO_CHAR(l_fecha_inicial + l_reales, 'd');

      IF INSTR(p_dias_no_laborales, l_desc_dia) = 0 THEN--l_desc_dia != '7' AND l_desc_dia != '1' THEN
        i := i + 1;
      END IF;

    END LOOP;

    l_fecha_final := l_fecha_inicial + l_reales;
    l_dias_festivos := XXMU_DEV_REPORT_PK.DIAS_FESTIVOS_F(l_fecha_inicial, l_fecha_final);

    IF l_dias_festivos > 0 THEN
      l_reales := l_reales + XXMU_DEV_REPORT_PK.LEAD_TIME(l_fecha_final, l_dias_festivos, p_dias_no_laborales);
      l_fecha_final := l_fecha_inicial + l_reales;

    END IF;

    dbms_output.put_line('dias real: ' || l_reales || ' - [' || TO_CHAR(l_fecha_inicial, 'DD-MON-YYYY') || ' a ' || TO_CHAR(l_fecha_final, 'DD-MON-YYYY') ||']');

    RETURN l_reales;

  END LEAD_TIME;

  --=================================================================
  --=================================================================


/*=================================================================
  =================================================================
  FUNCION GET_ITEM_COST

  Descripci?n:
    Esta funci?n busca el costo de un art?lo. Considera el tipo
    de bodega para buscar costo discreto o continuo.

  Par?tros:
     - p_inventory_item_id: id del art?lo
     - p_organization_id  : id de la organizaci?n de inventario
     - p_transaction_date : fecha para buscar el costo
     - p_cost_method      : Metodo de Costo, Ej: COPM, IFRS.
                            Puede enviarse en NULL y el sistema
                            devuelve segun metodo predefinido.

  Retorno: v_costo

  Autor: Andr?Correa - Centro de Servicios Mundial S.A.
  Fecha de Creaci?n: 29-JUL-2011

  Actualizado en:

  =================================================================
  =================================================================
*/
  FUNCTION GET_ITEM_COST (p_organization_id   IN NUMBER
                        , p_inventory_item_id IN NUMBER
                        , p_transaction_date  IN DATE
                        , p_cost_method       IN VARCHAR2) RETURN NUMBER
  IS
     v_cost NUMBER;
  BEGIN
      select DECODE(NVL(mp.process_enabled_flag,'N'), 'Y',
             /*Continua:*/ APPS.XXMU_DEV_REPORT_PK.GET_COSTO_TOTAL(p_inventory_item_id, mp.organization_id, p_transaction_date, p_cost_method),
             /*Discreta:*/ nvl((cst_cost_api.get_item_cost(1,p_inventory_item_id, mp.organization_id,NULL,NULL)),(cst_cost_api.get_item_cost(1,p_inventory_item_id, mp.organization_id,85187,NULL)))) Costo
             --modificado Diego Acosta (Gsg) para que traiga  el costo de discretas si no tiene grupo de costos por defecto
       into v_cost
       from mtl_parameters mp
      where mp.organization_id = p_organization_id;

      RETURN (v_cost);

  EXCEPTION
    WHEN OTHERS THEN
      RETURN (NULL);

  END GET_ITEM_COST;

/*=================================================================
  =================================================================
  FUNCION GET_KIT_OR_ITEM_COST

  Descripci?n:
    Esta funci?n busca el costo de un art?lo, sea o no kit.
    Hace uso de la funcion GET_ITEM_COST .

  Par?tros:
     - p_inventory_item_id: id del art?lo
     - p_organization_id  : id de la organizaci?n de inventario
     - p_transaction_date : fecha para buscar el costo
     - p_cost_method      : Metodo de Costo, Ej: COPM, IFRS.
                            Puede enviarse en NULL y el sistema
                            devuelve segun metodo predefinido.

  Retorno: v_costo

  Autor: Andr?Correa - Centro de Servicios Mundial S.A.
  Fecha de Creaci?n: 29-JUL-2011

  Actualizado en:

  =================================================================
  =================================================================
*/
  FUNCTION GET_KIT_OR_ITEM_COST  (p_organization_id   IN NUMBER
                                , p_inventory_item_id IN NUMBER
                                , p_transaction_date  IN DATE
                                , p_cost_method       IN VARCHAR2) RETURN NUMBER
  IS

     CURSOR c_kit_components (p_assembly_item_id NUMBER, p_org_id NUMBER) IS
      select bsb.assembly_item_id
           , bcb.component_item_id
           , bcb.component_quantity
           , msib_items.segment1
             from BOM_COMPONENTS_B bcb, BOM_STRUCTURES_B bsb, mtl_system_items_b msib_items
            where bcb.bill_sequence_id = bsb.bill_sequence_id
              and bcb.disable_date is null
              and bsb.organization_id = msib_items.organization_id
              and bsb.assembly_item_id = p_assembly_item_id
              and msib_items.organization_id   = p_org_id
              and msib_items.inventory_item_id = bcb.component_item_id;

     v_cost NUMBER;

  BEGIN

      v_cost := 0;

      FOR kit IN c_kit_components(p_inventory_item_id, p_organization_id) LOOP

          v_cost := v_cost + XXMU_DEV_REPORT_PK.GET_ITEM_COST(p_organization_id, kit.component_item_id, p_transaction_date, p_cost_method) * kit.component_quantity;

      END LOOP;

      IF v_cost = 0 THEN

         v_cost := XXMU_DEV_REPORT_PK.GET_ITEM_COST (p_organization_id, p_inventory_item_id, p_transaction_date, p_cost_method);

      END IF;

      RETURN (v_cost);

  EXCEPTION
    WHEN OTHERS THEN
      RETURN (NULL);

  END GET_KIT_OR_ITEM_COST ;

/*=================================================================
  =================================================================
  FUNCION get_org_id_for_last_transfer

  Descripci¿n:
    Devuelve la ultima organizacion continua desde la cual fue
    trasladado el articulo.

  Par¿tros:
     - p_inventory_item_id: id del art¿lo
     - p_organization_id  : id organizaci¿n de inventario discreta que
                            recibio el traslado
     - p_date             : fecha maxima de consulta

  Retorno: x_org_id

  Autor: Andr¿Correa - Centro de Servicios Mundial S.A.
  Fecha de Creaci¿n: ACORREA 05-AGO-2011

  Actualizado en:

  =================================================================
  =================================================================
*/
  FUNCTION get_org_id_for_last_transfer(p_inventory_item_id NUMBER, p_organization_id NUMBER, p_date DATE) RETURN NUMBER IS

       CURSOR org_id_for_last_transfer (p_inventory_item_id NUMBER, p_organization_id NUMBER, p_date VARCHAR2) IS
        select mmt.transfer_organization_id
          from mtl_material_transactions mmt, mtl_parameters mp
         where (mmt.inventory_item_id = p_inventory_item_id)
           and ( mmt.transaction_date <= to_date(p_date,'DD-MM-YYYY HH24:MI:SS') )
           and mmt.organization_id = p_organization_id
           and mmt.transfer_organization_id = mp.organization_id
           and NVL(mp.process_enabled_flag,'N') = 'Y' -- La Bodega que transfiere es Continua?
           and (mmt.LOGICAL_TRANSACTION=2 OR mmt.LOGICAL_TRANSACTION IS NULL )
           and mmt.transaction_type_id = 95 -- Transferencia de Organizaci¿n Directa de Solicitud Interna
         order by mmt.TRANSACTION_DATE DESC;

       x_org_id NUMBER;
       l_date VARCHAR2(25);
    BEGIN
        l_date := to_char(p_date,'DD-MM-YYYY HH24:MI:SS');
        OPEN org_id_for_last_transfer(p_inventory_item_id, p_organization_id, l_date);
        FETCH org_id_for_last_transfer INTO x_org_id; -- Lee el primer registro (transferencia mas reciente)
        CLOSE org_id_for_last_transfer;

        RETURN (x_org_id);

    EXCEPTION
      WHEN OTHERS THEN
        RETURN (-1);

  END get_org_id_for_last_transfer;


/*=================================================================
  =================================================================
  FUNCION GET_COMPANY_CODE_FOR_ORG_ID

  Descripci¿n:
    Devuelve codigo de compania para el id organizacion.

  Par¿tros:
     - p_org_id  : id organizaci¿n unidad operativa

  Retorno: x_company_code

  Autor: Andr¿Correa - Centro de Servicios Mundial S.A.
  Fecha de Creaci¿n: ACORREA 08-AGO-2011

  Actualizado en:

  =================================================================
  =================================================================
*/
   FUNCTION GET_COMPANY_CODE_FOR_ORG_ID (p_org_id NUMBER) RETURN VARCHAR2 IS
      x_company_code VARCHAR2(3);
   BEGIN
     select trim(glnsv.segment_value)
     into x_company_code
     from HR_ORGANIZATION_INFORMATION_V hoiv,
          gl_ledgers                   gl,
          gl_ledger_norm_seg_vals      glnsv
     where hoiv.organization_id = p_org_id
       and hoiv.org_information_context = 'Operating Unit Information'
       and glnsv.legal_entity_id = hoiv.org_information2
       and gl.ledger_category_code = 'PRIMARY'
       and gl.ledger_id = glnsv.ledger_id;

        RETURN (x_company_code);

    EXCEPTION
      WHEN OTHERS THEN
        RETURN (NULL);

   END GET_COMPANY_CODE_FOR_ORG_ID;

  -- ACORREA 10-AGO-2011
   FUNCTION GET_VALIDATION_ORG_ID (p_org_id NUMBER) RETURN NUMBER IS
      x_validation_org_id NUMBER;
   BEGIN
     select mp.organization_id
       into x_validation_org_id
       from apps.hr_organization_information hoi
          , mtl_parameters mp
          , gl_ledgers gl
          , gl_ledger_norm_seg_vals glnsv
          , hr_all_organization_units haou
      where hoi.org_information_context = 'Accounting Information'
        and hoi.org_information3 = p_org_id -- Org id de la Unidad Operativa
        and mp.organization_id = hoi.organization_id
        and glnsv.legal_entity_id = hoi.org_information2
        and gl.ledger_category_code = 'PRIMARY'
        and gl.ledger_id = glnsv.ledger_id
        and substr(mp.organization_code,1,1) = 'V'
        and NVL(haou.date_from,SYSDATE) <= SYSDATE
        and NVL(haou.date_to,SYSDATE) >= SYSDATE
        and mp.organization_id = haou.organization_id;

     return x_validation_org_id;

    EXCEPTION
      WHEN OTHERS THEN
        RETURN (NULL);
   END GET_VALIDATION_ORG_ID;

  -- ACORREA 17-AGO-2011
  FUNCTION GET_BUSINESS_CODE (p_ord_code VARCHAR2) RETURN VARCHAR2 IS
     x_business_code VARCHAR2(3);
  BEGIN
        select parent_flex_value
          into x_business_code
          from fnd_flex_value_hierarchies
         where flex_value_set_id = 1013553 -- GM_ZZ_GL_COMPANIA
           and length(parent_flex_value) = 3
           and child_flex_value_high = p_ord_code;  -- 'CML'

        return x_business_code;

    EXCEPTION
      WHEN OTHERS THEN
        RETURN (NULL);

  END GET_BUSINESS_CODE;


  FUNCTION get_discrt_org_item_sales_cost(p_line_id NUMBER
                                         ,p_org_id  NUMBER) RETURN NUMBER IS
    v_cost NUMBER;
  BEGIN

    SELECT DISTINCT mmt.actual_cost
    INTO   v_cost
    FROM   mtl_material_transactions mmt
          ,mtl_parameters            mp
    WHERE  mmt.trx_source_line_id = p_line_id
           AND mmt.transaction_type_id IN (15,
                                           33) -- 15:Recepcion RMA, 33:Emision de pedido de ventas
           AND mmt.organization_id = mp.organization_id
           AND mp.organization_id = p_org_id
           AND nvl(mp.process_enabled_flag,
                   'N') = 'N' -- Organizacion Discreta
    ;

    RETURN v_cost;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN(NULL);

  END get_discrt_org_item_sales_cost;


  FUNCTION get_item_sales_cost(p_organization_id   IN NUMBER
                              ,p_inventory_item_id IN NUMBER
                              ,p_transaction_date  IN DATE
                              ,p_cost_method       IN VARCHAR2
                              ,p_order_line_id     IN NUMBER := NULL)
    RETURN NUMBER IS
    v_cost NUMBER;

  BEGIN
    SELECT decode(nvl(mp.process_enabled_flag,
                      'N'),
                  'Y',
                  /*Continua:*/
                  apps.xxmu_dev_report_pk.get_costo_total(p_inventory_item_id,
                                                          mp.organization_id,
                                                          p_transaction_date,
                                                          p_cost_method),
                  /*Discreta:*/
                  decode(p_order_line_id,
                         NULL,
                         cst_cost_api.get_item_cost(1,
                                                    p_inventory_item_id,
                                                    mp.organization_id,
                                                    NULL,
                                                    NULL),
                         apps.xxmu_dev_report_pk.get_discrt_org_item_sales_cost(p_order_line_id,
                                                                                mp.organization_id))) costo
    INTO   v_cost
    FROM   mtl_parameters mp
    WHERE  mp.organization_id = p_organization_id;

    RETURN(v_cost);

  EXCEPTION
    WHEN OTHERS THEN
      RETURN(NULL);

  END get_item_sales_cost;


  FUNCTION get_kit_or_item_sales_cost(p_organization_id   IN NUMBER
                                     ,p_inventory_item_id IN NUMBER
                                     ,p_transaction_date  IN DATE
                                     ,p_cost_method       IN VARCHAR2
                                     ,p_validation_org_id IN NUMBER
                                     ,p_header_id         IN NUMBER := NULL
                                     ,p_order_line_id     IN NUMBER := NULL)
    RETURN NUMBER IS

    CURSOR c_kit_components(p_assembly_item_id NUMBER
                           ,p_org_id           NUMBER) IS
      SELECT bsb.assembly_item_id
            ,bcb.component_item_id
            ,bcb.component_quantity
            ,msib_items.segment1
      FROM   bom_components_b   bcb
            ,bom_structures_b   bsb
            ,mtl_system_items_b msib_items
      WHERE  bcb.bill_sequence_id = bsb.bill_sequence_id
             AND bcb.disable_date IS NULL
             AND bsb.organization_id = msib_items.organization_id
             AND bsb.assembly_item_id = p_assembly_item_id
             AND msib_items.organization_id = p_org_id
             AND msib_items.inventory_item_id = bcb.component_item_id;

    v_cost NUMBER;
    v_cmpnt_order_line_id NUMBER;

  BEGIN

    v_cost := 0;

    FOR kit IN c_kit_components(p_inventory_item_id,
                                p_validation_org_id)
    LOOP

     -- Busca el line_id del componente en el pedido
     select line_id
       into v_cmpnt_order_line_id
       from ont.oe_order_lines_all
      where header_id       = p_header_id
        and link_to_line_id = p_order_line_id
        and inventory_item_id = kit.component_item_id
        and item_type_code  = 'INCLUDED';

      v_cost := v_cost + xxmu_dev_report_pk.get_item_sales_cost(p_organization_id,
                                                                kit.component_item_id,
                                                                p_transaction_date,
                                                                p_cost_method,
                                                                v_cmpnt_order_line_id) *
                kit.component_quantity;

    END LOOP;

    IF v_cost = 0 THEN

      v_cost := xxmu_dev_report_pk.get_item_sales_cost(p_organization_id,
                                                       p_inventory_item_id,
                                                       p_transaction_date,
                                                       p_cost_method,
                                                       p_order_line_id);

    END IF;

    RETURN(v_cost);

  EXCEPTION
    WHEN OTHERS THEN
      RETURN(NULL);

  END get_kit_or_item_sales_cost;

END XXMU_DEV_REPORT_PK; 
/
