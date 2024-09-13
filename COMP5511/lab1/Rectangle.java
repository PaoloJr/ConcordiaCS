package COMP5511.lab1;
import COMP5511.lab1.Shape;

public class Rectangle extends Shape {
    double width, height;

    public Rectangle(double h, double w) {
        this.width = w;
        this.height = h;
    }

    public double area(){
        double area = width * height;
        return area;
    }
    
}
