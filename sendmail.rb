require 'rubygems'
require 'tmail'
require 'base64' 
require 'dropio'
require 'net/smtp'


def sendEmail(to_add,subject,file)

	tomail = to_add
	frommail = 'wemmaster@tweet.io'
	attachments =[file] 

	mail = TMail::Mail.new
	mail.to = tomail
	mail.from = frommail
	mail.subject = subject
	mail.date = Time.now
	

	mailpart=TMail::Mail.new
	mailpart.set_content_type 'text', 'plain'
	mailpart.body = subject
	mail.parts << mailpart
	
	
	attachments.each do |att|
		if FileTest.exists?(att)
		ifile = File.open(att,"rb")
		content=ifile.read
		ifile.close
		mailpart=TMail::Mail.new
		mailpart.set_content_type 'image', 'jpeg'
		mailpart.set_disposition("attachment", {:filename => "#{att}"})
		mailpart.transfer_encoding = "base64"
		content = Base64.b64encode(content.to_s)
		mailpart.body = content.to_s
		mail.parts << mailpart
		end
	end

	Net::SMTP.start( '172.16.1.35', 25 ) do|smtpclient|
	  smtpclient.send_message(
	    mail.to_s,
	    frommail,
	    tomail
	  )
end

end

mail ="williamricherd5504@tweet.io"
s= mail.split("@")
puts s[0]

sendEmail 'begin.samuel@photoninfotech.net',"Hello from sam","Home page_new.JPG"



