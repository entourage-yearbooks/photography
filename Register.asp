<!-- #include File="../../wwwroot/appservices/DatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/YearbookDatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/FormHandlerResources.asp" -->
<%
  pageTitle = "Register New User"
  
  
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
    });  
  
    
  </script>
  <form name="theForm" action="/IndexAction.asp" onsubmit="return submitForm();">
    <div class="container">
      <div class="row">
        <h1>Register User</h1>
      </div>
      <div class="row">
        <div class="col-md-6 col-md-push-6">
          <h2>Preview Image</h2>
        </div>
        <div class="col-md-6 col-md-pull-6">
          <div class="row">
            <%
              renderEntFormInput "text", "photography_user_name", "Name", "Name", "", "col-md-12", "required", ""
            %>
          </div>
          <div class="row">
            <%
              renderEntFormInput "email", "photography_user_email", "Email", "Email", "", "col-md-12", "required", ""
            %>
          </div>
          <div class="row">
            <%
              renderEntFormInput "password", "photography_user_password", "Password", "********", "", "col-md-12", "required", ""
            %>
          </div>
          <div class="row">
            <div class="form-group">
              <input type="submit" class="form-control btn" value="Register">
            </div>
            
          </div>
          
        </div>        
      </div>
    </div>  
  </form>
      
<!-- #include File="./_footer.asp" -->
