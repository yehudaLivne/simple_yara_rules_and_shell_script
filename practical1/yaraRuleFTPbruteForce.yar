rule FTP_Brute_Force 
{
	meta:
		author = "Yehuda Livne"
		date = "2023-09-19"
		description = "catch FTP brute force attack"

	strings:
		$ftp_login_failed = "530 Login failed"

	condition:
		//Detects more than 10 login failed attempts
		#ftp_login_failed > 10		
}
