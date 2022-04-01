package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {

	@Override
	protected PasswordAuthentication getPasswordAuthentication(){
		
			return new PasswordAuthentication("bronze13571@gmail.com","!qwer1234");				
	}	
}

