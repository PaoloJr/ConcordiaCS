package COMP5511.lab8;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class Q1 {

    public static List<List<Integer>> levelOrder(TreeNode tn) {
        List<List<Integer>> result = new ArrayList<>();
        Queue<TreeNode> queue = new LinkedList<>();            
        if (tn == null) {
            return result;
        } else {
            queue.add(tn);
        }

        while(!queue.isEmpty()) {
            int levelSize = queue.size();
            List<Integer> currLevel = new ArrayList<>();

            for(int i = 0; i < levelSize; i++) {
                TreeNode currNode = queue.poll();
                currLevel.add(currNode.val);

                if (currNode.left != null) {
                    queue.add(currNode.left);
                }
                if (currNode.right != null) {
                    queue.add(currNode.right);
                }
            }
            result.add(currLevel);
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
