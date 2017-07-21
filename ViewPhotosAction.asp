<!-- #include File="../../wwwroot/appservices/DatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/YearbookDatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/PhotographyQueryManager.asp" -->
<%
  OUTPUT_DEBUG_MSG = True
  uid = request("uid")
  photoId = request("photo_id")
  debugMessage "uid = " & uid & " photoId= " & photoId
  set uRecSet = getPhotographyUserInformationByGUID(uid)
  
  contractId = uRecSet("contract_id")
  photoPersonId = uRecSet("photo_person_id")
  packageId = "DEFAULT"
  
  sql = "SELECT photography_user_id, photo_person_id, photography_photo_id FROM photography_user_photos " & _
    "WHERE photography_user_id = '" & escapeString(uRecSet("photography_user_id")) & "' " & _
    " AND photo_person_id = " & photoPersonId & " AND package_id = '" & escapeString(packageId) & "'"
  debugMessage "sql: " & sql
  set recset = executeYBQuery(sql)
  if recset.EOF then
    sql = "INSERT INTO photography_user_photos (photography_user_id, photo_person_id, package_id, photography_photo_id, map_status) " & _
      "VALUES ('" & escapeString(uRecSet("photography_user_id")) & "', " & photoPersonId & ", '" & escapeString(packageId) & "', '" & photoId & "', 'SELECTED')"
  else
    sql = "UPDATE photography_user_photos SET photography_photo_id = '" & photoId & "', update_date = getDate() WHERE photography_user_id = '" & escapeString(uRecSet("photography_user_id")) & "' " & _
      " AND photo_person_id = " & photoPersonId & " AND package_id = '" & escapeString(packageId) & "' "
  end if  
  debugMessage "Insert SQL: " & sql
  executeYBQuery sql
  response.redirect "PhotoSelectionComplete.asp?uid=" & uid & "&photo_id=" & photoId
  
%>