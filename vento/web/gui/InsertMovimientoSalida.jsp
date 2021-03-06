<%@page import="jspread.core.util.SystemUtil"%>
<%@page contentType="text/html;charset=utf-8" pageEncoding="utf-8" language="java"%>
<%@ include file="/gui/pageComponents/globalSettings.jsp"%>
<%    try {
        if (fine) {
            if (request.getParameter(WebUtil.encode(session, "imix")) != null) {
                LinkedList<String> access4ThisPage = new LinkedList();
                access4ThisPage.add("InsertMovimientoSalida");

                LinkedList<String> userAccess = (LinkedList<String>) session.getAttribute("userAccess");
                if (UserUtil.isAValidUser(access4ThisPage, userAccess)) {
                    Iterator it = null;
                    LinkedList listAux = null;
%>
<!DOCTYPE html>
<html lang="<%=PageParameters.getParameter("Content-Language")%>">
    <head>
        <title>Nueva Salida</title>
        <jsp:include page='<%=PageParameters.getParameter("globalLibs")%>'/>        
        <jsp:include page='<%=PageParameters.getParameter("styleFormCorrections")%>'/>   
        <jsp:include page='<%=PageParameters.getParameter("ajaxFunctions") + "/tablaCapturaCSS.jsp"%>'/>
        <script type="text/javascript" language="javascript" charset="utf-8">
            function resetForm() {
                document.getElementById("noDictamen").value = '';
                document.getElementById("descripcion").value = '';
                document.getElementById("noFactura").value = '';
                document.getElementById("noSerie").value = '';
                document.getElementById("noInventario").value = '';
                document.getElementById("fechaCompra").value = '';
                document.getElementById("observaciones").value = '';
                document.getElementById('status').selectedIndex = "0";
                getDepartamento(document.getElementById("idPlantel").value);
                getDetalle4Subcategoria(document.getElementById("idSubcategoria").value);
            }
            function enviarInfo(form) {
                $.ajax({type: 'POST'
                    , contentType: 'application/x-www-form-urlencoded;charset=utf-8'
                    , cache: false
                    , async: false
                    , url: '<%=PageParameters.getParameter("mainController")%>'
                    , data: $(form).serialize()
                    , success: function(response) {
                        $('#wrapper').find('#divResult').html(response);
                    }});
            }

            function getDepartamento(idPlantel) {
                if (idPlantel !== null) {
                    $.ajax({type: 'POST'
                        , contentType: 'application/x-www-form-urlencoded;charset=utf-8'
                        , cache: false
                        , async: false
                        , url: "<%=PageParameters.getParameter("mainContext") + PageParameters.getParameter("ajaxFunctions")%>/getDepartamento4Plantel.jsp"
                        , data: '<%=WebUtil.encode(session, "imix")%>=<%=WebUtil.encode(session, UTime.getTimeMilis())%>&idPlantel=' + idPlantel
                        , success: function(response) {
                            $('#wrapper').find('#divDepartamento').html(response);
                        }});
                }
            }
            function getPersonal(idPlantel) {
                if (idPlantel !== null) {
                    $.ajax({type: 'POST'
                        , contentType: 'application/x-www-form-urlencoded;charset=utf-8'
                        , cache: false
                        , async: false
                        , url: "<%=PageParameters.getParameter("mainContext") + PageParameters.getParameter("ajaxFunctions")%>/getPersonal4Plantel.jsp"
                        , data: '<%=WebUtil.encode(session, "imix")%>=<%=WebUtil.encode(session, UTime.getTimeMilis())%>&idPlantel=' + idPlantel
                        , success: function(response) {
                            $('#wrapper').find('#divPersonal').html(response);
                        }});
                }
            }

function buscarPlantelCCT(keyCode)
            {
                
                var value = document.getElementById('searchPlantel').value;
                
                if (keyCode === 13 || keyCode === 32) {
                       
                    searchPlantel = document.getElementById("searchPlantel").value;
                    $.ajax({type: 'POST'
                        , contentType: 'application/x-www-form-urlencoded;charset=utf-8'
                        , cache: false
                        , async: true
                        , url: '/vento/ajaxFunctions/buscarCCTPlantel.jsp'
                        , data: '<%=WebUtil.encode(session, "imix")%>=<%=WebUtil.encode(session, UTime.getTimeMilis())%>&searchText='+value
                                        , success: function (response) {
                                            if (response.length > 0) {
                                                $('#suggestions').show();
                                                $('#autoSuggestionsList').html(response);
                                            }
                                        }
                                    });

                                }else if(keyCode ===8 && value.length===0)
                                {
                                    $('#suggestions').hide();
                                    $('#divDepartamento').hide();
                                    $('#divPersonal').hide();
                                }
                            }
                            function fillSuggestions(cadena, plantel)
                            {
                                $('#divDepartamento').show();
                                    $('#divPersonal').show();
                                if (cadena.length === 0)
                                {
                                    $('#searchPlantel').val('');
                                   
                                   
                                } else
                                {
                                     $('#searchPlantel').val(cadena);
                                     $('#suggestions').hide();
                                     getDepartamento(plantel);
                                     getPersonal(plantel);
                                }

                            }
        </script>
    </head>
    <body>
        <div id="wrapper">
            <div id="divBody">
                <jsp:include page='<%=("" + PageParameters.getParameter("logo"))%>' />
                <div id="barMenu">
                    <jsp:include page='<%=(PageParameters.getParameter("barMenu"))%>' />
                </div>
                <div class="errors">
                    <p>
                        <em>Los campos con  <strong>*</strong> son necesarios.</em>
                    </p>
                </div>
                <div class="form-container" width="100%">                    
                    <p></p>
                    <table width="100%" height="25px" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="64%" height="25" align="left" valign="top">
                                <a class="NVL" href="<%=PageParameters.getParameter("mainMenu")%>"> Menú Principal</a>
                                > <a class="NVL" href="<%=PageParameters.getParameter("mainContext") + PageParameters.getParameter("gui")%>/MenuConsumibles.jsp?<%=WebUtil.encode(session, "imix")%>=<%=WebUtil.encode(session, UTime.getTimeMilis())%>">Menú Consumibles</a> 
                                > <a class="NVL" href="<%=PageParameters.getParameter("mainContext") + PageParameters.getParameter("gui")%>/ConsultaMovimientoSalida.jsp?<%=WebUtil.encode(session, "imix")%>=<%=WebUtil.encode(session, UTime.getTimeMilis())%>&idPlantel=<%=request.getParameter("idPlantel")%>">Movimientos de Salida</a> 
                                > Nueva Salida
                            </td>
                            <td width="36" align="right" valign="top">
                                <script language="JavaScript" src="<%=PageParameters.getParameter("jsRcs")%>/funcionDate.js" type="text/javascript"></script>
                            </td>
                        </tr>                        
                    </table>
                    <form name="insertMovimientoSalida" method="post" action="" enctype="application/x-www-form-urlencoded" id="insertMovimientoSalida">
                        <input type="hidden" name="<%=WebUtil.encode(session, "imix")%>" value="<%=WebUtil.encode(session, UTime.getTimeMilis())%>"/>
                        <input type="hidden" name="FormFrom" value="insertMovimientoSalida"/>
                        <input type="hidden" name="idTipoMovimiento" value="<%=WebUtil.encode(session, QUID.select_TipoMovimiento("SALIDA"))%>"/>
                       <fieldset>
                            <legend>Nueva Salida</legend>
                            <jsp:include page='<%=PageParameters.getParameter("ajaxFunctions") + "/getSelectPlantelSection.jsp"%>' flush = 'true'>
                                <jsp:param name='plantelActual' value='<%=request.getParameter("idPlantel") != null ? request.getParameter("idPlantel") : WebUtil.encode(session, session.getAttribute("FK_ID_Plantel"))%>' />
                            </jsp:include>
                            
                            <div>
                                <label for="noTurno">*Número de Turno</label>
                                <input type="text" name="noTurno">
                            </div>
                            <div>
                                <label for="fechaMovimiento">*Fecha</label>
                                <input type="text" class="w8em format-y-m-d divider-dash highlight-days-67" id="fechaMovimiento"   name="fechaMovimiento" value="" size="10" MAXLENGTH="10">
                            </div>
                            <div class="divControlHelp">
                                <div id="divAyuda" class="div4HelpButton" >
                                    <img  id="botonAyuda"  src="<%=PageParameters.getParameter("imgRsc") + "/icons/help-browser.png"%>" width="24px" height="24px" onclick="showButton('divInfo');
            hideButton('divAyuda');" title="Abrir ayuda">
                                </div>
                                <div>
                                    <label for"peDestino">*Plantel Destino</label>
                                    <input type="text" name="searchPlantel" id="searchPlantel" onkeyup="buscarPlantelCCT(event.keyCode);" size="75">
                                    <div class="suggestionsBox" id="suggestions" style="display: none;">
                                        <div class="suggestionList" id="autoSuggestionsList">

                                        </div>
                                    </div>
                                </div>

                               <div id="divInfo" class="msginfo div4HelpInfo" style="width:340px;" onmouseover="showButton('botonCerrarInfo');" onmouseout="hideButton('botonCerrarInfo');">
                                    <div class="deleteBar div4HelpInfoCloseButton" >
                                        <img  class="div4HelpCloseButton" align="right" id="botonCerrarInfo"  src="<%=PageParameters.getParameter("imgRsc") + "/icons/delete.png"%>" width="16px" height="16px" onclick="hideButton('divInfo');
                                                showButton('divAyuda');" title="Cerrar ayuda">
                            </div>
                                    <p>
                                        &nbsp Busque plantel por CCT o Nombre.
                                    </p>
                                </div>
                            </div>
                               
                            <div id="divDepartamento"></div>
                            <div id="divPersonal"></div>
                            <div>
                                <label for="motivoMovimiento">Motivo</label>
                                <textarea  name="motivoMovimiento" cols="30" rows="5"></textarea>
                            </div>
                            <div>
                                <label for="estatus">*Estatus</label>
                                <select name="estatus">
                                    <option value=""></option>
                                    <option value="<%=WebUtil.encode(session, "Completo")%>">Completo</option>
                                    <option value="<%=WebUtil.encode(session, "Incompleto")%>"">Incompleto</option>
                                </select>
                            </div>
                            <div>
                                <label for="observaciones">Observaciones</label>
                                <textarea  name="observaciones" cols="30" rows="5" id="observaciones"></textarea>
                            </div>
                        </fieldset>
                        <div id="botonEnviarDiv" >
                            <input type="button" value="Guardar y Continuar" name="Enviar" onclick="enviarInfo(document.getElementById('insertMovimientoSalida'));">
                        </div> 
                    </form>
                    <div id="divResult"> 
                    </div>
                </div>   
                <div id="divFoot">
                    <jsp:include page='<%=(PageParameters.getParameter("footer"))%>' />
                </div> 
            </div>            
        </div>
    </body>
</html>
<%
} else {
    //System.out.println("Usuario No valido para esta pagina");
%>                
<%@ include file="/gui/pageComponents/invalidUser.jsp"%>
<%    }
} else {
    //System.out.println("No se ha encontrado a imix");
%>
<%@ include file="/gui/pageComponents/invalidParameter.jsp"%>
<%        }
    }
} catch (Exception ex) {
    Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, null, ex);
%>
<%@ include file="/gui/pageComponents/handleUnExpectedError.jsp"%>
</body>
</html>
<%
        //response.sendRedirect(redirectURL);
    }
%>