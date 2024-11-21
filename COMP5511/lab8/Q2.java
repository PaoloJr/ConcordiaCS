package COMP5511.lab8;

public class Q2 {

    public static int maxProfit(int[] prices) {
        if (prices == null || prices.length < 2) {
            return 0;
        }

        int minPrice = Integer.MAX_VALUE;
        int maxProfit = 0;

        for (int price : prices) {
            if (price < minPrice) {
                minPrice = price;
            } else {
                maxProfit = Math.max(maxProfit, price - minPrice);
            }
        }
        return maxProfit;
    }


    public static void main(String[] args) {
        int[] prices = {7, 23, 1, 5, 3, 6, 4};
        int profit = maxProfit(prices);
        System.out.println(profit);
    }

}
