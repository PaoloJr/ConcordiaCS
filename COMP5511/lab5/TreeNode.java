package COMP5511.lab5;

public class TreeNode {
    int value;
    TreeNode left, right, parent;

    public TreeNode(int value) {
        this.value = value;
        left = right = parent = null;
    }

    public TreeNode(int value, TreeNode parent) {
        this.value = value;
        this.left = this.right = null;
        this.parent = parent;
    }

    public int getValue() {
        return value;
    }

    public TreeNode getParent() {
        return parent;
    }

    public TreeNode getRight() {
        return right;
    }

    public TreeNode getLeft() {
        return left;
    }

    public void setValue(int newValue) {
        value = newValue;
    }

    public void setParent(TreeNode newParent) {
        parent = newParent;
    }

    public void setLeft(TreeNode newLeft) {
        this.left = newLeft;
        if (left != null) {
            left.parent = this;
        }
    }

    public void setRight(TreeNode newRight) {
        this.right = newRight;
        if (right != null) {
            right.parent = this;
        }
    }
}
