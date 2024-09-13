package COMP5511.lab1;
import COMP5511.lab1.Shape;

public class Circle extends Shape {
    double radius;

    public Circle(double input) {
        this.radius = input;
    }

    public double area() {
        double area = Math.PI * radius * radius;
        return area;
    }
}
