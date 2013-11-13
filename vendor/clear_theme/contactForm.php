<?php

$admin_email = "lukasz@holeczek.pl"; // Only Change This Mail

	
if ($_POST['new_message']) {
	
	function valid_email($email) {
  		return (! preg_match("/^([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,6}$/ix", $email)) ? FALSE : TRUE;
	}
	
	$name = $_POST['name'];
	
	$email = $_POST['message_email'];
	$email = str_replace(' ', '', $email);
		
	$user_message = $_POST['message'];
	
	$www = $_POST['www'];
	
	if(valid_email($email)) {
				
		$host  = $_SERVER['HTTP_HOST'];
		$uri   = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
							
		$message = 
"$name - $email - $www - send you message.\n\n
$user_message\n\n
_____________________________________________
PLEASE DO NOT REPLY \n\n
BOOTSTRAPMASTER.COM - BEST BOOTSTRAP THEMES \n\n
NESSFILE.COM - The most beautiful and the best Address Book ever 

";

		mail($admin_email , "Website Contact Form", $message,
		"From: \"Website Contact Form\" <no-reply@$host>\r\n" .
		"X-Mailer: PHP/" . phpversion());
		unset($_SESSION['ckey']);
		
		echo 1;
			
	} else {
		
		echo 2;
		
	}
				
}

?>