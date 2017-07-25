<!-- #include File="../../wwwroot/appservices/DatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/YearbookDatabaseManager.inc" -->
<%
  pageTitle = "Entourage Photography"
  
  contractId = request("contract_id")
  email = request("email_address")
  studentId = request("student_id")
  msg = request("msg")
  
  if contractId <> "" then
    sql = "SELECT org_name, sc.org_id, contract_id FROM organizations o, service_contracts sc WHERE sc.org_id = o.org_id " & _
      "AND contract_status in ('CONFIRMED', 'SIGNED', 'PENDING') " & _
      "AND contract_id = '" & contractId & "' "
    debugMessage "SQL: " & sql
    set contractRecSet = executeYBQuery(sql)
    if contractRecSet.EOF = false then
      schoolName = contractRecSet("org_name")
    end if
  end if
  
%>
<!-- #include File="./_header.asp" -->
  <style>
    
  </style>
  <script language="javascript">
    $(document).ready(function() {
    });    
  </script>
  <form name="theForm" action="/IndexAction.asp" onsubmit="return submitForm();">
  <div class="row">
    <h1>Contact Us</h1>
  </div>
  <div class="row">
    <div class="col-xs-12 col-md-4 col-md-offset-2">
      <strong>Phone Number:</strong>
    </div>
    <div class="col-xs-12 col-md-4">
      1-888-926-9288
    </div>
  </div>
  <div class="row">
    <div class="col-xs-12 col-md-4 col-md-offset-2">
      <strong>Email:</strong>
    </div>
    <div class="col-xs-12 col-md-4">
      <a href="photohelp@entourageco.com">photohelp@entourageco.com</a>
    </div>
  </div>
  </form>
      
<!-- #include File="./_footer.asp" -->
