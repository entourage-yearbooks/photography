<!-- #include File="../../wwwroot/appservices/DatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/YearbookDatabaseManager.inc" -->
<%
  OUTPUT_DEBUG_MSG = False
  if request("debug") <> "" then
    OUTPUT_DEBUG_MSG = True
  end if
  
  theType = request("type")
  
  if theType = "TEST" then
  
  else
    term = request("term")
    sql = "SELECT org_name, sc.org_id, contract_id FROM organizations o, service_contracts sc WHERE sc.org_id = o.org_id " & _
      "AND contract_status in ('CONFIRMED', 'SIGNED', 'PENDING') " & _
      "AND org_name like '" & escapeString(term) & "%' AND contract_type in ('School Photography', 'Event Photography') ORDER BY org_name"
    debugMessage "SQL: " & sql
    set recset = executeYBQuery(sql)
    json = "["
    counter = 0
    do while not recset.EOF
      if counter > 0 then
        json = json & ", "
      end if
      json = json & "{ ""label"" : """ & escapeJSON(recset("org_name")) & """, ""value"" : """ & escapeJSON(recset("contract_id")) & """} " & vbCRLF  
      counter = counter + 1
      recset.MoveNext
    loop
    
    json = json & "]"
    response.write json
  end if
%>
