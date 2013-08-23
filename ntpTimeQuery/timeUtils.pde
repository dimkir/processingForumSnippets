import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.DatagramPacket;
import java.net.SocketException;
import java.net.UnknownHostException;

/**
* Attempts to get time from the server and returns it as
* NtpMessage structure. 
* 
* This is "blocking call" meaning that this method
* doesn't return until it receives reply(or error) from the network.
* If any failure getting time prints error to console and returns null.
*
* @param server string containing ntp server name like: ntp.cais.rnp.br
* @return valid NtpMessage on success or null value on error getting time.
*/
NtpMessage getTimeOrNull(String server){
  try {
    // Send message
    DatagramSocket socket = new DatagramSocket();
    InetAddress address = InetAddress.getByName(server);
    NtpMessage msg = new NtpMessage();
    byte[] buf = msg.toByteArray();
    DatagramPacket packet = new DatagramPacket(buf, buf.length, address, 123);
    socket.send(packet);

    // Get response
    socket.receive(packet);
    //println(msg.toString());
    return msg;
  }
  catch(SocketException socex) {
    socex.printStackTrace();
  }
  catch(UnknownHostException uhex) {
    uhex.printStackTrace();
  }
  catch(IOException ioex){
    ioex.printStackTrace();
  }
  return null; // if we got to here, means there was an exception.   
}

