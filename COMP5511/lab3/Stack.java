package COMP5511.lab3;

public class Stack {
    String[] strings;
    int stringArrayLength;

        public Stack(){
            strings = new String[100];
            stringArrayLength = strings.length;
        }

        public String push(String[] someStringArray) {
            int someStringArrayLength = someStringArray.length;

            if (someStringArrayLength > 0) {
                String someString = "Here I am!";
                int index = someStringArrayLength - 1;

                someStringArray[index] = someString;
                stringArrayLength++;

                return someString;
            } else {
                return null;
            }
        }

        public String pop(String[] someStringArray) {
            int someStringArrayLength = someStringArray.length;
            
            if (someStringArrayLength > 0) {
                String returnString = someStringArray[stringArrayLength - 1];
                int lastIndex = someStringArrayLength - 1;

                someStringArray[lastIndex] = null;
                stringArrayLength--;

                return returnString;
            } else {
                return null;
            }      
        }

        public static void main(String[] args) {
            Stack s = new Stack();
            int endOfStringArray = s.stringArrayLength - 1;
            
            String pushedString = s.push(s.strings);
            System.out.println(s.strings[endOfStringArray]);
            System.out.println("Pushed String --> " + pushedString);
            
            String removedString = s.pop(s.strings);
            System.out.println("Popped String --> " + removedString);
        }
}
