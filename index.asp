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
    #searchSchool {
      text-align: left;
    }
    
    #loginInfoDiv {
      background-color: #dddddd;
      border-radius: 10px;
      padding: 20px 10px 20px 10px;
      text-align: left;
    }
    
    #bottomSpacer {
      height: 100px;
    }
    
    #messageDiv {
      font-size: 14pt;
      font-weight: bold;
      color: #aa0000;
      text-align: center;
      background-color: #dddddd;
      border-radius: 10px;
      padding: 10px;
      
    }
    
  </style>
  <script language="javascript">
    $(document).ready(function() {
      browserHeight = $(window).height();
      browserWidth = $(window).width();
      
    	$("#school_name").autocomplete({
    		source: "IndexHandler.asp",
    		minLength: 2,
    		select: function( event, ui ) {
    				$("#school_name" ).val(ui.item.label);
    				$("#contract_id" ).val(ui.item.value);
    				return false;
    		  }
    		});
    });  
  
    function submitForm() {
      var errMsg = "";
      var theForm = document.theForm;
      
      <%
        if contractId <> "" then 
      %>
      if (theForm.email_address.value == '') {
        errMsg += " - Please enter your email address\n";
      }  
      if (theForm.student_id.value == '') {
        errMsg += " - Please enter your student id\n";
      }  
      <%
        
        else
      %>
      if (theForm.school_name.value == '') {
        errMsg += " - Please enter a school name\n";
      }  
      <%
        end if
      %>
      if (errMsg !== "") {
        alert("Error submitting the form.\n" + errMsg);        
        return false;
      }
      else {
        return true;
      }
    }
    
  </script>
  <form name="theForm" action="/IndexAction.asp" onsubmit="return submitForm();">
    <input type="hidden" id="contract_id" name="contract_id" value="<%= contractId %>">
    <div class="container" align="center">
      <%
        if contractId = "" then 
      %>
      <div class="row" id="searchSchool">
        <h2>Search For Your School</h2>
        <p class="lead">
          Enter School Name
        </p>
        <div class="form-group ui-widget">      
          <input type="edit" name="school_name" id="school_name" value="<%= schoolName %>">
          <input class="btn btn-default" type="submit" value="Search">
        </div>
        <p>
          View your photos by first searching for you school.
        </p>
      </div>
      <%
        else 
      %>
      <h1><%= schoolName %></h1>
      <p>
        Enter your student id number and your email address to view your photos from your school's photo day. 
        If you do not have you student id, you can contact us at <a href="mailto: photohelp@entourageco.com">photohelp@entourageco.com</a> to request your information. Make sure 
        to include the student's name and grade.          
      </p>
      <%
        if msg <> "" then
      %>
      <div class="row msgRow">        
        <div id="messageDiv" class="col-xs-12 col-md-4 col-md-offset-4" align="center">
          <%= msg %>
        </div>
      </div>
      <%
        end if
      %>
      <div class="row">
        <div id="loginInfoDiv" class="col-xs-12 col-md-4 col-md-offset-4">
          <div class="row form-group">      
            <div class="col-sm-4">
              <label>Email Address</label>
            </div>
            <div class="col-sm-8">
              <input type="edit" name="email_address" id="email_address" value="<%= email %>">
            </div>
          </div>
          <div class="row form-group">      
            <div class="col-sm-4">
              <label>Student Id #</label>
            </div>
            <div class="col-sm-8">
              <input type="edit" name="student_id" id="student_id" value="<%= studentId %>">
            </div>
          </div>
          <div class="row">      
            <div class="col-sm-12" align="center">
              <input class="btn" type="button" value="Start Over" onclick="document.location = '/index.asp';">
              <input class="btn btn-default" type="submit" value="Search">
            </div>
          </div>
        </div>
      </div>
      <div id="bottomSpacer" class="row">
      
      </div>
      <%
        end if
      %>
    </div>
  </form>
      
<!-- #include File="./_footer.asp" -->
