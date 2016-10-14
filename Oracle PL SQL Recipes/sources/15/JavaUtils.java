CREATE OR REPLACE JAVA SOURCE NAMED "JavaUtils" AS
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.naming.*;
import java.sql.*;
import oracle.jdbc.*;

public class JavaUtils {

    public static void sendMail(String subject,
            String recipient,
            String message) {
        try {

            Properties props = System.getProperties();
            props.put("mail.from", "yourname@yourcompany.com");
            props.put("mail.smtp.host","smtp.yourcompany.com");
            Session session = Session.getDefaultInstance(props,null);
            Message msg = new MimeMessage(session);
            msg = new MimeMessage(session);
            msg.setSubject(subject);
            msg.setSentDate(new java.util.Date());
            msg.setFrom();
            
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient, false));
            
            MimeBodyPart body = new MimeBodyPart();
            body.setText(message);
            Multipart mp = new MimeMultipart();
            mp.addBodyPart(body);
            msg.setContent(mp);

            Transport.send(msg);
        } catch (MessagingException ex) {
            Logger.getLogger(JavaUtils.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }

    public static void listDatabaseSchemas() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection("jdbc:default:connection:");
            OracleDatabaseMetaData meta = (OracleDatabaseMetaData) conn.getMetaData();

            if (meta == null) {
                System.out.println("Database metadata is unavailable");
            } else {
                ResultSet rs = meta.getSchemas();
                while (rs.next()) {
                    System.out.println(rs.getString(1));
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        } 
    }
}
