<!-- #include File="../../wwwroot/appservices/DatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/YearbookDatabaseManager.inc" -->
<%
  OUTPUT_DEBUG_MSG = True
  contractId = request("contract_id")
  
  if request("email_address") <> "" then
    debugMessage "Authenticate this access"
    studentId = request("student_id")
    email = Trim(lcase(request("email_address")))
    sql = "SELECT photo_person_id FROM photography_people WHERE contract_id = '" & contractId & "' " & _
      "AND student_id = '" & escapeString(studentId) & "' "
    debugMessage "SQL: " & sql
    set pRecSet = executeYBQuery(sql)
    if pRecSet.EOF then
      debugMessage "Student not found, redirect to prior page"
      response.redirect "index.asp?contract_id=" & contractId & "&email_address=" & email & "&student_id=" & studentId & "&msg=Student record not found"
    else
      if validateEmail(email) = False then
        response.redirect "index.asp?contract_id=" & contractId & "&email_address=" & email & "&student_id=" & studentId & "&msg=Invalid Email"
      else
        debugMessage "Student found: " & studentId
        sql = "SELECT photography_user_id, user_guid FROM photography_users WHERE photography_user_id = '" & escapeString(email) & "' " & _  
          "AND contract_id = '" & contractId & "' "
        debugMessage "SQL: " & sql
        set checkRecSet = executeYBQuery(sql)
        photoPersonId = pRecSet("photo_person_id")
        userGUID = getGUID()
        
        if checkRecSet.EOF then
          sql = "INSERT INTO photography_users (photography_user_id, contract_id, user_guid, photography_user_email, photo_person_id, photography_user_status) " & _
            "VALUES ('" & escapeString(email) & "', '" & contractId & "', '" & userGUID & "', '" & escapeString(email) & "', " & photoPersonId & ", 'REGISTERED') " 
            
        else
          userGUID = checkRecSet("user_guid")
          sql = "UPDATE photography_users SET update_date = getdate(), photo_person_id = " & photoPersonId & " WHERE photography_user_id = '" & escapeString(email) & "'"
        end if
        debugMessage "SQL: " & sql
        executeYBQuery sql
        
        response.redirect "ViewPhotos.asp?uid=" & userGUID
        
        
      end if
    end if
    
  else
    response.redirect "index.asp?contract_id=" & contractId 
  end if
  
  Function validateEmail(email)
    Dim retVal 
    retVal = True
    if InStr(email, "@") < 0 then
      retVal = False    
    end if
    if InStr(email, ".") < 0 then
      retVal = False    
    end if
    if InStr(email, "$") > 0 then
      retVal = False    
    end if
    if InStr(email, "'") > 0 then
      retVal = False    
    end if
    if InStr(email, """") > 0 then
      retVal = False    
    end if
    if InStr(email, "<") > 0 then
      retVal = False    
    end if
    if InStr(email, ">") > 0 then
      retVal = False    
    end if
    if InStr(email, "?") > 0 then
      retVal = False    
    end if
    if Len(email) < 3 then
      retVal = False    
    end if
    debugMessage "validateEmail() : email : " & email & " retVal = " & retVal
    validateEmail = retVal
  End Function
%>