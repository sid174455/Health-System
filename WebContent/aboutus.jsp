
<%
	request.getSession().setAttribute("selectPage",2);
%>

<%@include file="header_home.jsp" %>


<div id="main_content" style="margin-top:50px">
			
			<div style="align:center;margin-top:20px">
					<label style="font-size:25px;padding-top:20px"><b>About US:</b></label>
					<br/><br/>
			<p style="font-size:15px;width:80%">
				A key approach to secure cloud computing is for the data owner to store encrypted 
				data in the cloud, and issue decryption keys to authorized users. Then, when a 
				user is revoked, the data owner will issue re-encryption commands to the cloud 
				to re-encrypt the data, to prevent the revoked user from decrypting the data, 
				and to generate new decryption keys to valid users, so that they can continue to 
				access the data. However, since a cloud computing environment is comprised of many 
				cloud servers, such commands may not be received and executed by all of the cloud 
				servers due to unreliable network communications. In this paper, we solve this 
				problem by proposing a time based re-encryption scheme, which enables the cloud 
				servers to automatically re-encrypt data based on their internal clocks. 
				Our solution is built on top of a new encryption scheme, attribute based encryption, 
				to allow fine-grain access control, and does not require perfect clock 
				synchronization for correctness.
       		</p>
	
            </div>            
        <div class="clear"></div>    
       </div>    
		
		<%@include file="footer.jsp" %>
