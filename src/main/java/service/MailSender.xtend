package service

import org.eclipse.xtend.lib.annotations.Data

interface MailSender {
	def void mandarMail(Mail mail)
}

@Data
class Mail {
	// String from
	String to
	String subject
	String text
}
