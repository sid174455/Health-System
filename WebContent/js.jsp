
<script type="text/javascript" language="JavaScript">

function trim(s)
{
	var l=0; var r=s.length -1;
	while(l < s.length && s[l] == ' ')
	{	l++; }
	while(r > l && s[r] == ' ')
	{	r-=1;	}
	return s.substring(l, r+1);
}
 
window.onerror = function (msg, url, line) 
{ 
	//var message = "Message : " + msg +  "    -      Line number : "  + line;
//	alert(message); 
}

function loadPage(urlPage)
{
	location = urlPage;
}

function hideStuff(boxID)
{
	document.getElementById(boxID).style.display = "none";
}

function showStuff(boxID)
{
	document.getElementById(boxID).style.display = "block";
}

function clearText(boxID)
{
	document.getElementById(boxID).value = "";
}

function clearHtml(boxID)
{
	document.getElementById(boxID).innerHTML = "";
}




function chkEmail()
{
	var email = trim(document.getElementById("email").value);
	if(email != "")
	{
		if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)))
		{
			alert('Please enter valid Email Address');
			document.getElementById("email").value = "";
			document.getElementById("email").focus();
		}
	}
}

function chkImage(str)
{
	str = trim(str);
	if(str != "")
	{
		var strArr = str.split("\\");
		strArr = strArr[strArr.length - 1].split(".");
		var strExt = trim(strArr[strArr.length - 1]).toLowerCase();
		if((strExt != "jpg") && (strExt != "bmp") && (strExt != "png")  && (strExt != "gif")  && (strExt != "jpeg") ) 
		{
			alert("Please provide valid photo");
			document.getElementById("photo").value = "";
		}
	}
}
</script>