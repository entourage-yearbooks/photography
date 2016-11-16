<!-- #include File="../../wwwroot/appservices/DatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/YearbookDatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/PhotographyQueryManager.asp" -->
<%
  pageTitle = "View Photos"
  
  uid = request("uid")
  photoId = request("photo_id")
  
  sql = "SELECT contract_id, photo_person_id FROM photography_users WHERE user_guid = '" & escapeString(uid) & "'"
  set uRecSet = executeYBQuery(sql)
  if uRecSet.EOF = false then
    contractId = uRecSet("contract_id")
    photoPersonId = uRecSet("photo_person_id")
    set personRecSet = getPhotographyPersonInformation(photoPersonId)
    personName = personRecSet("first_name") & " " & personRecSet("last_name")
    sql = "SELECT org_id FROM service_contracts WHERE contract_id = '" & contractId & "'"
    set conRecSet = executeYBQuery(sql)
    if conRecSet.EOF = false then
      orgId = conRecSet("org_id")
      set orgRecSet = getOrganizationInformation(orgId)
      if orgRecSet.EOF = false then
        schoolName = orgRecSet("org_name")
      end if
    end if
  else
    response.redirect "/index.asp"
  end if
  
%>
<!-- #include File="./_header.asp" -->
  <style>
  
    #labelCol {
      margin-bottom: 20px;
    }
  </style>
  <script language="javascript">
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
  <form name="theForm" action="/ViewPhotosAction.asp" onsubmit="return submitForm();">
    <input type="hidden" name="photo_id" value="<%= selectedPhotoId %>">
    <input type="hidden" name="uid" value="<%= uid %>">
    <div class="container">
      <div class="row">
        <div id="" class="col-xs-12 col-md-12">
          <h1>Your Photo Selection Is Complete</h1>          
          <p>
            <b>Thank you!</b> Your photo selection is complete and your photo order will be processed shortly.  You can expect your photo package to be delivered 
            to your school, <%= schoolName %>.
          </p>
        </div>
      </div>
      <div class="row">
        <div id="labelCol" class="col-xs-12 col-md-6">
          <h3><%= personName %></h3>
          <p>
            <%= schoolName %>
          </p>
          <input type="button" class="btn" value="Change" onclick="document.location = 'ViewPhotos.asp?uid=<%= uid %>';">
          <input type="button" class="btn btn-default" value="Done" onclick="document.location = 'index.asp?uid=<%= uid %>';">
          
        </div>
        <div id="" class="col-xs-12 col-md-3">
          <%
            sql = "SELECT photo_thumbnail_url, photo_file_name FROM photography_photos WHERE photography_photo_id = '" & photoId & "'"
            set pRecSet = executeYBQuery(sql)
          %>
          <div class="imgDiv">
            <div class="imgPreviewDiv">
              <img src="<%= pRecSet("photo_thumbnail_url") %>" alt="" border="0" class="img-responsive">
              <div class="imgOverlay">
              </div>
            </div>
            <div class="imgFileName">   
              Selected Photo
            </div>
          </div>
        </div>
      </div>
    </div>
  </form>
      
<!-- #include File="./_footer.asp" -->
