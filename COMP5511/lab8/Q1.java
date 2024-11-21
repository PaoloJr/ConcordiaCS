package COMP5511.lab8;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class Q1 {

    public static List<List<Integer>> levelOrder(TreeNode tn) {
        List<List<Integer>> result = new ArrayList<>();
        Stack<List<TreeNode>> stack = new Stack<>();            
        if (tn == null) {
            return result;
        } else {
            List<TreeNode> initList = new ArrayList<>();
            initList.add(tn);
            stack.push(initList);
        }
        System.out.println(stack.pop().toString());

        while(!stack.isEmpty()) {
            int levelSize = stack.size();
            List<Integer> currLevel = new ArrayList<>();

            for(int i = 0; i < levelSize; i++) {
                List<TreeNode> currNode = stack.peek();
            }

        }

        return result;

    }



    public static void main(String[] args) {
        TreeNode root = new TreeNode(1);
        root.left = new TreeNode(2);
        root.right = new TreeNode(3);
        root.left.left = new TreeNode(4);
        root.left.right = new TreeNode(5);
        root.right.right = new TreeNode(6);
        root.right.right = new TreeNode(7);

        List<List<Integer>> result = levelOrder(root);
        System.out.println(result);
    }
}
