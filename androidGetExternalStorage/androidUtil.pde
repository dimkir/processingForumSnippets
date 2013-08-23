























///**
// THIS IS NOT ADAPTED TO PROCESSING. NEEDS TO BE DONE
//* This is method to figure out whether there's storage or not.
//* Taken from here:
//* http://stackoverflow.com/questions/902089/how-to-tell-if-the-sdcard-is-mounted-in-android
//*/
//public boolean hasStorage(boolean requireWriteAccess) {
//    //TODO: After fix the bug,  add "if (VERBOSE)" before logging errors.
//    String state = Environment.getExternalStorageState();
//    Log.v(TAG, "storage state is " + state);
//
//    if (Environment.MEDIA_MOUNTED.equals(state)) {
//        if (requireWriteAccess) {
//            boolean writable = checkFsWritable();
//            Log.v(TAG, "storage writable is " + writable);
//            return writable;
//        } else {
//            return true;
//        }
//    } else if (!requireWriteAccess && Environment.MEDIA_MOUNTED_READ_ONLY.equals(state)) {
//        return true;
//    }
//    return false;
//}
