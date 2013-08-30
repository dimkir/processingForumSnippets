/**
* This class is taken from SO:
* http://stackoverflow.com/questions/1378171/writing-a-bitset-to-a-file-in-java
*
* Author: ZZ Coder
* http://stackoverflow.com/users/149808/zz-coder
*/
import java.util.BitSet;

public class ExportableBitSet extends BitSet {

    private static final long serialVersionUID = 1L;

    public ExportableBitSet() {
      super();
    }

    public ExportableBitSet(int nbits) {
      super(nbits);
    }

    public ExportableBitSet(byte[] bytes) {
      this(bytes == null? 0 : bytes.length*8);
     // this();    
      for (int i = 0; i < bytes.length * 8 ; i++) {
        processing.core.PApplet.println("ExportableBitSet(byte[]) setting bit: " + i);
        if (isBitOn(i, bytes))
          set(i);
      }
    }

    @Override
    public void set(int i ){
       processing.core.PApplet.println("Setting bit (" + i  + ")");
       super.set(i);
    }

    public byte[] toByteArray()  {

      // we need logical length. (which is only used when last bit is set)      
      if (length() == 0)
        return new byte[0];

      // Find highest bit
      int hiBit = -1;
      for (int i = 0; i < length(); i++)  {
        if (get(i))
          hiBit = i;
      }

      int n = (hiBit + 8) / 8;
      byte[] bytes = new byte[n];
      if (n == 0)
        return bytes;

      java.util.Arrays.fill(bytes, (byte)0);
      for (int i=0; i<n*8; i++) {
        if (get(i)) 
          setBit(i, bytes);
      }

      return bytes;
    }

    protected static int BIT_MASK[] = 
        {0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01};

    protected static boolean isBitOn(int bit, byte[] bytes) {
      int size = bytes == null ? 0 : bytes.length*8;

      if (bit >= size) 
        return false;

      return (bytes[bit/8] & BIT_MASK[bit%8]) != 0;
    }

    protected static void setBit(int bit, byte[] bytes) {
      int size = bytes == null ? 0 : bytes.length*8;

      if (bit >= size) 
        throw new ArrayIndexOutOfBoundsException("Byte array too small");

      bytes[bit/8] |= BIT_MASK[bit%8];
    }
}
