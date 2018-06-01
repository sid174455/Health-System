/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SendSMS;

public class SendSms {

    public static void Way2SMS(String mobile, String message) {
        try {
            String username = "9920600396";//userid of Way2sms
            String password = "pasighat";//password of Way2sms
            
            ThreadSms th = new ThreadSms(username, password, mobile, message);
            Thread t = new Thread(th);
            t.start();
        } catch (Exception e) {
        }
    }

    public static void main(String args[]) throws InterruptedException {
        String username = "9920600396";//userid of Way2sms
        String password = "pasighat";//password of Way2sms
        String message = "Testing Way2SMS";//msg to be sent
        String mobile = "9920600396";//phonenumber for whoom msg to be sent;

        ThreadSms th = new ThreadSms(username, password, mobile, message);
        Thread t = new Thread(th);
        t.start();
    }
}
