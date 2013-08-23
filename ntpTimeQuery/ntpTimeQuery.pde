import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.DatagramPacket;
import java.net.SocketException;
import java.net.UnknownHostException;
void setup() {
   String server = "0.uk.pool.ntp.org";
   //String server = "time.euro.apple.com";
   NtpMessage msg = getTimeOrNull(server);
   if ( msg == null ){
      println("There was an error getting ntp time from server:  " +  server);
   }
   else{
      println("Time received: " + msg.toString());     
   }
}


void draw() {
}

