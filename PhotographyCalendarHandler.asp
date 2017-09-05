<!-- #include File="../../wwwroot/appservices/DatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/YearbookDatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/PhotographyQueryManager.asp" -->
<!-- #include File="../../wwwroot/appservices/FormHandlerResources.asp" -->
<!-- #include File="../../wwwroot/appservices/JSON_2.0.4.asp" -->
<%
  OUTPUT_DEBUG_MSG = False
  if request("debug") <> "" then
    OUTPUT_DEBUG_MSG = True
  end if
  theType = request("type")
  debugMessage "theType = " & theType
  
  if theType = "ADD DATE" then
    debugMessage "Add new date"
    
    createDate = Now()
    sql = prepareFormInsertSQL("photography_calendar", Request.QueryString, createDate)
    
    debugMessage "Insert SQL: " & sql
    executeYBQuery sql
    response.redirect "PhotographyCalendar.asp?fld_this_date=" & request("this_date") & "&admin=1"
  elseif theType = "DATE DETAILS" then
    theDate = request("date")
    sql = "SELECT sc.org_id, o.org_name, contract_id, sc.photo_date, sc.retake_date, org_state, org_city " & _
      "FROM view_service_contract_photography sc, organizations o " & _
      "WHERE sc.org_id = o.org_id AND sc.contract_status not in ('PENDING', 'CLOSED', 'VOID') " & _
      "AND (sc.photo_date = '" & theDate & "' or sc.retake_date = '" & theDate & "') "
    debugMessage "SQL: " & sql
    set recset = executeYBQuery(sql)
    json = recsetToJSONString(recset)
    response.write json
  end if
  
%>