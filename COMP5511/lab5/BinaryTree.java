package COMP5511.lab5;

import COMP5511.lab5.TreeNode;

public class BinaryTree {
    TreeNode root;

    public BinaryTree() {
        root = null;
    }

    public void insert(int value) {
        root = insertRec(root, value);
    }

    private TreeNode insertRec(TreeNode root, int value) {
        // base case
        if (root == null) {
            root = new TreeNode(value);
            return root;
        }

        if (value < root.value) {
            root.left = insertRec(root.left, value);
        } else if (value > root.value) {
            root.right = insertRec(root.right, value);
        }
        return root;
    }

    public void inOrder() {
        inOrderRec(root);
        System.out.println();
    }

    public void inOrderRec(TreeNode root) {
        if (root != null) {
            inOrderRec(root.left);
            System.out.print(root.value + " ");
            inOrderRec(root.right);
        }
    }

    public int maxDepth(TreeNode root) {
        if (root == null) return 0;
        int leftDepth = maxDepth(root.left);
        int rightDepth = maxDepth(root.right);
        return Math.max(leftDepth, rightDepth) + 1;
    }


    public static void main(String[] args) {
        BinaryTree bt = new BinaryTree();
        int first = 50;
        int second = 30;
        int third = 20;
        int fourth = 40;
        int fifth = 70;
        int sixth = 60;
        int seventh = 80;

        bt.insert(first);
        bt.insert(second);
        bt.insert(third);
        bt.insert(fourth);
        bt.insert(fifth);
        bt.insert(sixth);
        bt.insert(seventh);

        System.out.println("In-Order Traversal:");
        bt.inOrder();

        System.out.println("BinaryTree Depth: " + bt.maxDepth(bt.root));
    }
   
} 
