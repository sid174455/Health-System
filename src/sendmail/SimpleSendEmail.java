/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sendmail;

/**
 *
 * @author kp
 */

import java.util.*;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;

public class SimpleSendEmail {

    private static String femail = "";
    private static String pass = "";
    boolean done = false;

    public SimpleSendEmail(String fromemail, String toemail, String Subject, String message, String password) {
        String host = "smtp.gmail.com";
        String to = toemail;
        String from = fromemail;
        femail = fromemail;
        String subject = Subject;
        String messageText = message;

        pass = password;
        boolean sessionDebug = false;
// Create some properties and get the default Session.
        Properties props = System.getProperties();
        props.setProperty("mail.smtp.host", "smtp.gmail.com");
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.smtp.port", "" + 587);
        props.setProperty("mail.smtp.starttls.enable", "true");

        Session session = createSmtpSession();
// Set debug on the Session so we can see what is going on
// Passing false will not echo debug info, and passing true
// will.        
        session.setDebug(sessionDebug);
        try {
// Instantiate a new MimeMessage and fill it with the
// required information.
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            InternetAddress[] address = {new InternetAddress(to)};
//            InternetAddress[] address1 = {new InternetAddress(from)};
            msg.setRecipients(Message.RecipientType.TO, address);
//            msg.setRecipients(Message.RecipientType.CC,address1);
            msg.setSubject(subject);
            msg.setSentDate(new Date());
            msg.setText(messageText);
// Hand the message to the default transport service
// for delivery.
            Transport.send(msg);
//            JOptionPane.showMessageDialog(null, "Email Send Successfully.!!!");
            done = true;
        }
        catch (MessagingException mex) {
            done = false;
        }
    }     
   
    public static Session createSmtpSession() {
        final Properties props = new Properties();
        props.setProperty("mail.smtp.host", "smtp.gmail.com");
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.smtp.port", "" + 587);
        props.setProperty("mail.smtp.starttls.enable", "true");

        return Session.getInstance(props, new javax.mail.Authenticator() {

            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(femail, pass);
            }
        });
    }
    
    //===========================================================================
    
    public SimpleSendEmail(String fromemail, String toemail, String Subject, String message, String password,String Attachment) {
        String host = "smtp.gmail.com";
        String to = toemail;
        String from = fromemail;
        femail = fromemail;
        String subject = Subject;
        String messageText = message;

        pass = password;
        boolean sessionDebug = false;
// Create some properties and get the default Session.
        Properties props = System.getProperties();
        props.setProperty("mail.smtp.host", "smtp.gmail.com");
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.smtp.port", "" + 587);
        props.setProperty("mail.smtp.starttls.enable", "true");

        Session session = createSmtpSession();
// Set debug on the Session so we can see what is going on
// Passing false will not echo debug info, and passing true
// will.        
        session.setDebug(sessionDebug);
        try {
// Instantiate a new MimeMessage and fill it with the
// required information.
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            InternetAddress[] address = {new InternetAddress(to)};
            msg.setRecipients(Message.RecipientType.TO, address);
            msg.setSubject(subject);
            msg.setSentDate(new Date());
            //msg.setText(messageText);
// Hand the message to the default transport service
// for delivery.
            MimeBodyPart messagePart = new MimeBodyPart();
            messagePart.setText(messageText);
            //
            // Set the email attachment file
            //
            MimeBodyPart attachmentPart = new MimeBodyPart();
            FileDataSource fileDataSource = new FileDataSource(Attachment) {
                @Override
                public String getContentType() {
                    return "application/octet-stream";
                }
            };
            attachmentPart.setDataHandler(new DataHandler(fileDataSource));
            attachmentPart.setFileName(fileDataSource.getName());
 
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messagePart);
            multipart.addBodyPart(attachmentPart);
 
            msg.setContent(multipart);
           
            Transport.send(msg);
//            JOptionPane.showMessageDialog(null, "Email Send Successfully.!!!");
            done = true;
        }
        catch (MessagingException mex) {
            done = false;
        }
    }
}