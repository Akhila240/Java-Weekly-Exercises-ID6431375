public class FinancialForecast {
    public static double futureValueRecursive(double P, double r, int n) {
        if (n == 0) {
            return P;
        }
        return futureValueRecursive(P, r, n - 1) * (1 + r);
    }
    public static double futureValueIterative(double P, double r, int n) {
        double fv = P;
        for (int i = 0; i < n; i++) {
            fv *= (1 + r);
        }
        return fv;
    }
    public static void main(String[] args) {
        double initialValue = 1000.0; 
        double growthRate = 0.1;      
        int years = 5;                
        double resultRecursive = futureValueRecursive(initialValue, growthRate, years);
        double resultIterative = futureValueIterative(initialValue, growthRate, years);
        System.out.println("Initial Value       : Rs. " + initialValue);
        System.out.println("Growth Rate         : " + (growthRate * 100) + "%");
        System.out.println("Years               : " + years);
        System.out.printf("Future Value (Recursive) : Rs. %.2f\n", resultRecursive);
        System.out.printf("Future Value (Iterative) : Rs. %.2f\n", resultIterative);
    }
}
