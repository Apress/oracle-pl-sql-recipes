CREATE OR REPLACE JAVA SOURCE NAMED "JavaUtils" AS
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.naming.*;

public class JavaUtils {

    public static void sendMail(String subject,
                                String[] recipients,
                                String message){
        try {
            InitialContext ic = new InitialContext();
            String sessionName = "java:comp/env/mail/JavaMailSession";
            Session session = (Session) ic.lookup(sessionName);
            Properties props = session.getProperties();
            props.put("mail.from", "juneau@fnal.gov");
            Message msg = new MimeMessage(session);
            msg = new MimeMessage(session);
            msg.setSubject(subject);
            msg.setSentDate(new Date());
            msg.setFrom();
            for (int x = 0; x <= recipients.length; x++) {
                msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipients[x], false));
            }
            MimeBodyPart body = new MimeBodyPart();
            body.setText(message);
            Multipart mp = new MimeMultipart();
            mp.addBodyPart(body);
            msg.setContent(mp);

            Transport.send(msg);
        } catch (MessagingException ex) {
            Logger.getLogger(JavaUtils.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(JavaUtils.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

};