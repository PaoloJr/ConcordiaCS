package COMP5511.lab1;
import COMP5511.lab1.Shape;
import COMP5511.lab1.Circle;
import COMP5511.lab1.Rectangle;

public class Q2 {
    public static void main(String args[]) {
        double testRadius = 5;
        int width = 5;
        int height = 5;
        Shape ci = new Circle(testRadius);
        Shape rect = new Rectangle(width, height);
        double cirleArea = ci.area();
        double rectArea = rect.area();

        System.out.println("Circle Area = " + cirleArea);
        System.out.println("Rectangle Area = " + rectArea);
    }
    
}
