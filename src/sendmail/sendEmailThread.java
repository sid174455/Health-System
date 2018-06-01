/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sendmail;
/**
 *
 * @author Administrator
 */
public class sendEmailThread implements Runnable {

    String fromemail = "";
    String toemail = "";
    String Subject = "";
    String message = "";
    String password = "";
    String Attachment = "";
    boolean withAttachment=false;

    public sendEmailThread(String frmemail, String temail, String sbject, String msg, String pwd) {
        withAttachment=false;
        fromemail = frmemail;
        toemail = temail;
        Subject = sbject;
        message = msg;
        password = pwd;       
    }

    public sendEmailThread(String frmemail, String temail, String sbject, String msg, String pwd,String attachment) {
        
        withAttachment=true;
        fromemail = frmemail;
        toemail = temail;
        Subject = sbject;
        message = msg;
        password = pwd;
        Attachment = attachment;
    }
    
    @Override
    public void run() {

        try {
            if(withAttachment)
            {
                SimpleSendEmail smp = new SimpleSendEmail(fromemail, toemail, Subject, message, password,Attachment);
            }
            else{
                 SimpleSendEmail smp = new SimpleSendEmail(fromemail, toemail, Subject, message, password);
            }
        }
        catch (Exception e) {
        }
    }
}