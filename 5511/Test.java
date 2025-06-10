// Java program for inorder traversals
class Node {
    int data;
    Node left, right;

    Node(int v)
    {
        data = v;
        left = right = null;
    }
}

// Main class
class Test {

    // Function to print inorder traversal
    public static void printInorder(Node node, int rankX, int depthY)
    {
        if (node == null)
            return;

        // First recur on left subtree
        printInorder(node.left, rankX, depthY + 1);

        rankX = rankX + 1;

        // Now deal with the node
        System.out.print("\nnode: " + node.data + " rankX: " + rankX + " depthY: " +  depthY);

        // Then recur on right subtree
        printInorder(node.right, rankX,  depthY + 1);
    }

    // Driver code
    public static void main(String[] args)
    {
        int rankX = 0;
        int depthY = 0;
        Node root = new Node(1);
        root.left = new Node(2);
        root.right = new Node(3);
        root.left.left = new Node(4);
        root.left.right = new Node(5);
        root.right.right = new Node(6);
        root.right.left = new Node(7);

        // Function call
        System.out.println(
            "Inorder traversal of binary tree is: ");
        printInorder(root, rankX,  depthY);
    }
}
